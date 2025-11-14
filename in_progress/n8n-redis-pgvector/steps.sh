# 1. Create a new folder
sudo mkdir -p ~/n8n-docker
cd ~/n8n-docker
sudo mkdir -p data redis-data postgres-init
sudo chown -R 1000:1000 ./data
sudo find ./data -type f -name config -exec chmod 600 {} +


# 2. Save .env
sudo nano .env

# 3. Create script en ~/n8n-docker/postgres-init/01-init-n8n.sh
sudo nano postgres-init/01-init-n8n.sh

```
#!/usr/bin/env bash
set -euo pipefail

echo "[init] creando rol y base de datos para n8n + extensiones..."

# 1) Crear rol si no existe
if ! psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" -tAc \
  "SELECT 1 FROM pg_roles WHERE rolname='${N8N_DB_USER}'" | grep -q 1; then
  psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c \
    "CREATE ROLE ${N8N_DB_USER} LOGIN PASSWORD '${N8N_DB_PASSWORD}';"
fi

# 2) Crear DB si no existe (NO usar DO $$ ... $$)
if ! psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" -tAc \
  "SELECT 1 FROM pg_database WHERE datname='${N8N_DB_NAME}'" | grep -q 1; then
  psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c \
    "CREATE DATABASE ${N8N_DB_NAME} OWNER ${N8N_DB_USER};"
fi

# 3) Extensiones + esquema en la DB de n8n
psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$N8N_DB_NAME" <<SQL
CREATE EXTENSION IF NOT EXISTS vector;
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE SCHEMA IF NOT EXISTS ${DB_POSTGRESDB_SCHEMA} AUTHORIZATION ${N8N_DB_USER};
GRANT USAGE, CREATE ON SCHEMA ${DB_POSTGRESDB_SCHEMA} TO ${N8N_DB_USER};

ALTER ROLE ${N8N_DB_USER} IN DATABASE ${N8N_DB_NAME}
  SET search_path = ${DB_POSTGRESDB_SCHEMA}, public;
SQL

echo "[init] listo ✅"
```

sudo chmod +x ~/n8n-docker/postgres-init/01-init-n8n.sh

# 5. set docker compose
sudo nano docker-compose.yml

# 4. run docker compose
sudo docker compose up -d