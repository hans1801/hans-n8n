#!/bin/bash
set -euo pipefail

# === Parámetros ===
PROJECT_DIR="chatwoot_stack"
APP_HTTP_PORT="3000" # Puerto host -> contenedor:3000
FRONTEND_URL_DEFAULT="${FRONTEND_URL:-http://localhost:${APP_HTTP_PORT}}"

# === Crear carpeta proyecto ===
if [ ! -d "$PROJECT_DIR" ]; then
  echo "✅ Creando carpeta $PROJECT_DIR..."
  mkdir -p "$PROJECT_DIR"
  chmod 755 "$PROJECT_DIR"
fi
cd "$PROJECT_DIR"

# === Generar SECRET_KEY_BASE si no existe variable previa ===
if [ -z "${SECRET_KEY_BASE:-}" ]; then
  if command -v openssl >/dev/null 2>&1; then
    SECRET_KEY_BASE="$(openssl rand -hex 64)"
  else
    # Fallback simple si no hay openssl
    SECRET_KEY_BASE="$(head -c 64 /dev/urandom | tr -dc 'A-Fa-f0-9' | head -c 128)"
  fi
fi

# === Crear .env ===
echo "📝 Generando .env..."
cat > .env <<EOF
# === Chatwoot / Rails ===
RAILS_ENV=production
NODE_ENV=production
SECRET_KEY_BASE=${SECRET_KEY_BASE}

# URL pública del frontend
FRONTEND_URL=${FRONTEND_URL_DEFAULT}

# === Base de datos ===
POSTGRES_DATABASE=chatwoot_production
POSTGRES_USERNAME=chatwoot
POSTGRES_PASSWORD=$(openssl rand -hex 16 2>/dev/null || echo changeme_pgpass)

# === Redis (opcional password) ===
REDIS_PASSWORD=
REDIS_URL=redis://redis:6379

# === Exposición local ===
APP_HTTP_PORT=${APP_HTTP_PORT}

# === SMTP (opcional, comenta/ajusta según proveedor) ===
# SMTP_ADDRESS=smtp.sendgrid.net
# SMTP_PORT=587
# SMTP_DOMAIN=example.com
# SMTP_USERNAME=apikey
# SMTP_PASSWORD=changeme
# SMTP_AUTHENTICATION=plain
# SMTP_ENABLE_STARTTLS_AUTO=true
EOF

# === Estructura de datos persistentes ===
mkdir -p data/postgres data/redis
chmod -R 700 data/postgres || true

# === Crear docker-compose.yml ===
echo "📝 Generando docker-compose.yml..."
cat > docker-compose.yml <<'EOF'
x-chatwoot-env: &chatwoot-env
  RAILS_ENV: production
  NODE_ENV: production
  FRONTEND_URL: ${FRONTEND_URL:-http://localhost:3000}
  POSTGRES_HOST: ${POSTGRES_HOST:-postgres}
  POSTGRES_PORT: ${POSTGRES_PORT:-5432}
  POSTGRES_DATABASE: ${POSTGRES_DATABASE:-chatwoot_production}
  POSTGRES_USERNAME: ${POSTGRES_USERNAME:-chatwoot}
  POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
  REDIS_URL: ${REDIS_URL:-redis://redis:6379}
  REDIS_PASSWORD: ${REDIS_PASSWORD:-}
  SECRET_KEY_BASE: ${SECRET_KEY_BASE}

services:
  postgres:
    image: pgvector/pgvector:pg14
    container_name: chatwoot_postgres
    restart: unless-stopped
    environment:
      POSTGRES_DB: ${POSTGRES_DATABASE:-chatwoot_production}
      POSTGRES_USER: ${POSTGRES_USERNAME:-chatwoot}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    volumes:
      - ./data/postgres:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USERNAME:-chatwoot} -d ${POSTGRES_DATABASE:-chatwoot_production}"]
      interval: 10s
      timeout: 5s
      retries: 10

  redis:
    image: redis:7-alpine
    container_name: chatwoot_redis
    restart: unless-stopped
    command: >
      sh -c "redis-server --appendonly yes
      ${REDIS_PASSWORD:+ --requirepass ${REDIS_PASSWORD}}"
    volumes:
      - ./data/redis:/data
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 10

  rails:
    image: chatwoot/chatwoot:v4.1.0
    container_name: chatwoot_rails
    restart: unless-stopped
    env_file:
      - .env
    environment:
      <<: *chatwoot-env
    depends_on:
      - postgres
      - redis
    ports:
      - "${APP_HTTP_PORT:-3000}:3000"
    entrypoint: ["docker/entrypoints/rails.sh"]
    command: bundle exec rails s -b 0.0.0.0 -p 3000

  sidekiq:
    image: chatwoot/chatwoot:v4.1.0
    container_name: chatwoot_sidekiq
    restart: unless-stopped
    command: bundle exec sidekiq -C config/sidekiq.yml
    env_file:
      - .env
    environment:
      <<: *chatwoot-env
    depends_on:
      - postgres
      - redis
EOF

# === Bajar stack previo (de este proyecto) ===
echo "🧼 Limpiando stack previo (si existía)..."
sudo docker compose down -v || true

# === Levantar nuevo stack ===
echo "🚀 Iniciando Chatwoot..."
sudo docker compose up -d

# === Esperar a que Postgres y Rails estén listos de forma básica ===
echo "⏳ Esperando 10s antes de preparar la base de datos..."
sleep 10

# === Preparar DB (migraciones/seed) ===
echo "🛠  Ejecutando db:chatwoot_prepare..."
sudo docker compose run --rm rails bundle exec rails db:chatwoot_prepare

# === Mostrar endpoints útiles ===
HOST_IP=$(hostname -I 2>/dev/null | awk '{print $1}')
echo
echo "✅ Chatwoot levantado."
echo "   • URL local:  ${FRONTEND_URL_DEFAULT}"
[ -n "${HOST_IP}" ] && echo "   • Acceso por IP: http://${HOST_IP}:${APP_HTTP_PORT}"

# === Logs ===
echo
echo "📜 Logs de chatwoot_rails (Ctrl+C para salir):"
sudo docker logs -f chatwoot_rails
