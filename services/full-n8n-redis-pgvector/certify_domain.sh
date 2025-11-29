#!/bin/bash
# 1. Instalar Nginx
sudo apt install -y nginx

# 2. Crear configuración temporal de Nginx SIN SSL
sudo bash -c 'cat > /etc/nginx/sites-available/n8n <<EOF
server {
    listen 80;
    server_name TU_DOMINIO.com;
    location / {
        proxy_pass http://localhost:5678;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection “Upgrade”;
        proxy_set_header Host \$host;
        chunked_transfer_encoding off;
        proxy_buffering off;
        proxy_cache off;
    }
}
EOF'

# 3. Habilitar el sitio y reiniciar Nginx
sudo ln -s /etc/nginx/sites-available/n8n /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl restart nginx

# 4. Instalar Certbot
sudo apt install certbot python3-certbot-nginx -y

# 5. Obtener certificado SSL automáticamente
sudo certbot --nginx -d TU_DOMINIO.com

# 6. Reemplazar configuración con versión segura (HTTPS + headers)
sudo bash -c 'cat > /etc/nginx/sites-available/n8n <<EOF
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
    ssl_prefer_server_ciphers on;
    ssl_ciphers HIGH:!aNULL:!MD5;
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;
    add_header Permissions-Policy "geolocation=(), microphone=()" always;
    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload" always;
    location / {
        proxy_pass http://localhost:5678;
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
    }
}
EOF'

# 7. Verificar y reiniciar Nginx con SSL activado
sudo nginx -t && sudo systemctl reload nginx

