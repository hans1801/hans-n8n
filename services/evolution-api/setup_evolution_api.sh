#!/bin/bash
set -e

# Variables
PROJECT_DIR="evolution_project"

# Crear carpeta si no existe y entrar
if [ ! -d "$PROJECT_DIR" ]; then
  echo "✅ Creando carpeta $PROJECT_DIR..."
  mkdir -p "$PROJECT_DIR"
  chmod 755 "$PROJECT_DIR"
fi

cd "$PROJECT_DIR"

# Crear .env
cat > .env <<EOF
CONFIG_SESSION_PHONE_VERSION=2.3000.1023204200
AUTHENTICATION_API_KEY=change-password

DATABASE_ENABLED=true
DATABASE_PROVIDER=postgresql
DATABASE_CONNECTION_URI=postgresql://myuser:mypassword@postgres:5432/evolution

CACHE_REDIS_ENABLED=true
CACHE_REDIS_URI=redis://redis:6379/0
CACHE_REDIS_PREFIX_KEY=evolution
CACHE_REDIS_SAVE_INSTANCES=false
CACHE_LOCAL_ENABLED=false
EOF

# Crear docker-compose.yml
cat > docker-compose.yml <<EOF
services:
  evolution_api:
    container_name: evolution_api
    image: atendai/evolution-api:latest
    restart: always
    ports:
      - "8080:8080"
    env_file:
      - .env
    depends_on:
      - postgres
      - redis
    volumes:
      - evolution_instances:/evolution/instances

  postgres:
    image: postgres:15
    restart: always
    environment:
      POSTGRES_USER: myuser
      POSTGRES_PASSWORD: mypassword
      POSTGRES_DB: evolution
    volumes:
      - pgdata:/var/lib/postgresql/data

  redis:
    image: redis:7
    restart: always

volumes:
  evolution_instances:
  pgdata:
EOF

# Eliminar contenedores y volúmenes previos si existen
echo "🧼 Limpiando contenedores anteriores..."
sudo docker compose down -v || true
sudo docker volume prune -f || true

# Levantar nuevo stack
echo "🚀 Iniciando Evolution API..."
sudo docker compose up -d

# Esperar 5 segundos
sleep 5

# Mostrar logs iniciales
echo "📜 Logs iniciales de evolution_api:"
sudo docker logs -f evolution_api
