# Instalar NGINX y Certbot si no existen - "nginx -v"
sudo apt update
sudo apt install -y nginx certbot python3-certbot-nginx

# Paso 1: Crear configuración temporal HTTP sin SSL sobrescribiendo evolution_api
sudo bash -c 'cat > "/etc/nginx/sites-available/evolution_api" <<EOF
server {
    listen 80;
    server_name TU_DOMINIO.com;

    location / {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF'

# Habilitar configuración
sudo ln -sf /etc/nginx/sites-available/evolution_api /etc/nginx/sites-enabled/evolution_api
sudo nginx -t && sudo systemctl reload nginx

# Paso 2: Obtener certificado SSL con Certbot
sudo certbot --nginx -d TU_DOMINIO.com

# Paso 3: Reescribir configuración con versión segura (HTTPS)
sudo bash -c 'cat > /etc/nginx/sites-available/evolution_api <<EOF
server {
    listen 80;
    server_name TU_DOMINIO.com;
    return 301 https://\$host\$request_uri;
}

server {
    listen 443 ssl;
    server_name TU_DOMINIO.com;

    ssl_certificate /etc/letsencrypt/live/TU_DOMINIO.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/TU_DOMINIO.com/privkey.pem;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;

    location / {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        chunked_transfer_encoding off;
        proxy_buffering off;
        proxy_cache off;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF'


# Recargar NGINX con configuración final
sudo nginx -t && sudo systemctl reload nginx
