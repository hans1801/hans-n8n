#!/bin/bash

# ============================
# CONFIGURACIÓN INICIAL
# ============================
N8N_HOST="SUBDOMINIO.DOMINIO.COM"
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

# n8n - env variables
N8N_HOST=$N8N_HOST
WEBHOOK_URL=https://$N8N_HOST/
N8N_ENCRYPTION_KEY=1631eafc-9943-4059-99c7-55e3e31c8707

N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
N8N_BLOCK_ENV_ACCESS_IN_NODE=true
NODES_EXCLUDE="[]"

# n8n task ruuner - env variables

# Redis - env variables

# Postgres - env variables
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
    image: n8nio/n8n:stable
    restart: unless-stopped
    ports:
      - "5678:5678"
    env_file:
      - .env
    environment:
      - N8N_RUNNERS_ENABLED=true
      - N8N_RUNNERS_MODE=external
      - N8N_RUNNERS_BROKER_LISTEN_ADDRESS=0.0.0.0
      - N8N_RUNNERS_BROKER_PORT=5679
      - N8N_RUNNERS_AUTH_TOKEN=runner_token-7b686508-2570-47d6-a39b-0e5bc4c18d7a
    volumes:
      - ./data:/home/node/.n8n
    depends_on:
      - redis

  task-runner:
    container_name: n8n-task-runner
    image: n8nio/runners:stable
    restart: unless-stopped
    env_file:
      - .env
    environment:
      - N8N_RUNNERS_AUTH_TOKEN=runner_token-7b686508-2570-47d6-a39b-0e5bc4c18d7a
      - N8N_RUNNERS_TASK_BROKER_URI=http://n8n:5679

  redis:
    container_name: redis
    image: redis:7
    restart: unless-stopped
    ports:
      - "6379:6379"
    env_file:
      - .env
    volumes:
      - ./redis-data:/data

  postgres-vector:
    container_name: postgres-vector
    image: ankane/pgvector:latest
    restart: unless-stopped
    ports:
      - "5432:5432"
    env_file:
      - .env
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
