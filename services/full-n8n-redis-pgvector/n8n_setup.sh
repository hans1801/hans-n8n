#!/bin/bash

# ============================
# CONFIGURACIÓN INICIAL
# ============================
N8N_DOMAIN="TU_DOMINIO.com"
PROJECT_DIR="n8n_project"

# ============================
# CREAR CARPETA DEL PROYECTO
# ============================
if [ ! -d "$PROJECT_DIR" ]; then
  echo "Creando proyecto en $PROJECT_DIR..."
  mkdir -p "$PROJECT_DIR"
  chmod 755 "$PROJECT_DIR"
else
  echo "El proyecto ya existe en $PROJECT_DIR"
fi

cd "$PROJECT_DIR"
sudo mkdir -p data
sudo chown -R 1000:1000 data

# ============================
# CREAR ARCHIVO .env
# ============================
if [ ! -f ".env" ]; then
  echo "Creando archivo .env..."

  cat <<EOF > .env
# ============================
# VARIABLES PARA N8N
# ============================

N8N_ENCRYPTION_KEY=9c204c9a-952a-4045-97e8-c128f92c04c0
N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
N8N_DOMAIN=$N8N_DOMAIN
N8N_HOST=$N8N_DOMAIN
WEBHOOK_URL=https://$N8N_DOMAIN/
WEBHOOK_TUNNEL_URL=https://$N8N_DOMAIN/

# Redis
QUEUE_BULL_REDIS_HOST=redis
QUEUE_BULL_REDIS_PORT=6379
QUEUE_BULL_REDIS_DB=0

# Postgres Vector
POSTGRES_USER=postgres-user
POSTGRES_PASSWORD=postgres-password
POSTGRES_DB=postgres-db
EOF

  echo ".env creado correctamente."
else
  echo "El archivo .env ya existe."
fi


# ============================
# CREAR DOCKER-COMPOSE
# ============================
if [ ! -f "docker-compose.yml" ]; then
  echo "Creando archivo docker-compose.yml..."

  sudo tee docker-compose.yml > /dev/null <<EOF
services:
  n8n:
    container_name: n8n
    image: n8nio/n8n:latest
    restart: unless-stopped
    ports:
      - "5678:5678"
    environment:
      - N8N_ENCRYPTION_KEY=\${N8N_ENCRYPTION_KEY}
      - N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=\${N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS}
      - N8N_HOST=\${N8N_HOST}
      - WEBHOOK_URL=\${WEBHOOK_URL}
      - WEBHOOK_TUNNEL_URL=\${WEBHOOK_TUNNEL_URL}
      - QUEUE_BULL_REDIS_HOST=\${QUEUE_BULL_REDIS_HOST}
      - QUEUE_BULL_REDIS_PORT=\${QUEUE_BULL_REDIS_PORT}
      - QUEUE_BULL_REDIS_DB=\${QUEUE_BULL_REDIS_DB}
    volumes:
      - ./data:/home/node/.n8n
    depends_on:
      - redis

  redis:
    container_name: redis
    image: redis:7
    restart: unless-stopped
    ports:
      - "6379:6379"
    volumes:
      - ./redis-data:/data

  postgres-vector:
    container_name: postgres-vector
    image: ankane/pgvector:latest
    restart: unless-stopped
    ports:
      - "5432:5432"
    environment:
      - POSTGRES_USER=\${POSTGRES_USER}
      - POSTGRES_PASSWORD=\${POSTGRES_PASSWORD}
      - POSTGRES_DB=\${POSTGRES_DB}
    volumes:
      - ./postgres-vector-data:/var/lib/postgresql/data
EOF

  echo "docker-compose.yml creado correctamente."
else
  echo "El archivo docker-compose.yml ya existe."
fi

# ============================
# LEVANTAR SERVICIOS
# ============================
echo
echo "Ejecutando docker compose..."
sudo docker compose up -d

# ============================
# INSTRUCCIONES DE ACTUALIZACIÓN
# ============================
echo
echo "🔄 Para actualizar n8n a la última versión:"
echo "1. Ejecuta: sudo docker pull n8nio/n8n"
echo "2. Reinicia servicios:"
echo "   cd $PROJECT_DIR"
echo "   sudo docker compose down"
echo "   sudo docker compose up -d"
