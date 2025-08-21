#!/bin/bash

# Configura tu dominio aquí
N8N_DOMAIN="TU_DOMINIO.com"
N8N_PROJECT_DIR="$HOME/n8n-docker"

# Crea carpeta principal y de datos si no existen
if [ ! -d "$N8N_PROJECT_DIR" ]; then
  echo "Creando proyecto en $N8N_PROJECT_DIR..."
  sudo mkdir -p "$N8N_PROJECT_DIR/data"
else
  echo "El proyecto ya existe en $N8N_PROJECT_DIR"
fi

cd "$N8N_PROJECT_DIR"

# Crea docker-compose.yml solo si no existe
if [ ! -f "docker-compose.yml" ]; then
  echo "Creando archivo docker-compose.yml..."
  sudo tee docker-compose.yml > /dev/null <<EOF
services:
  n8n:
    container_name: n8n
    image: n8nio/n8n
    restart: unless-stopped
    ports:
      - "5678:5678"
    environment:
      - N8N_HOST=${N8N_DOMAIN}
      - WEBHOOK_URL=https://${N8N_DOMAIN}/
      - WEBHOOK_TUNNEL_URL=https://${N8N_DOMAIN}/
    volumes:
      - ./data:/home/node/.n8n
EOF
  echo "Archivo docker-compose.yml creado."
else
  echo "El archivo docker-compose.yml ya existe. Modifícalo manualmente si deseas cambiar configuraciones."
fi

echo
echo "Ejecutando doker compose..."
cd ~/n8n-docker && sudo docker compose up -d

# Instrucción para actualizar n8n
echo
echo "🔄 Para actualizar n8n a la última versión:"
echo "1. Ejecuta: sudo docker pull n8nio/n8n"
echo "2. Luego reinicia el servicio con:"
echo "   cd $N8N_PROJECT_DIR"
echo "   sudo docker compose down"
echo "   sudo docker compose up -d"
