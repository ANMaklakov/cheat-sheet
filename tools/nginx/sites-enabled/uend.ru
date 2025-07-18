server {
  listen 80;
  server_name uend.ru;
  return 301 https://$server_name$request_uri;
}

limit_req_zone $binary_remote_addr zone=req_limit_per_ip:10m rate=5r/s;
limit_conn_zone $binary_remote_addr zone=conn_limit_per_ip:10m;

server {

  listen 443 ssl;

  server_name uend.ru;

  ssl_certificate /etc/letsencrypt/live/uend.ru/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/uend.ru/privkey.pem;

  include /etc/nginx/snippets/errors.conf;

  root /opt/uend/www;

  index index.html index.htm;

limit_conn conn_limit_per_ip 10;

add_header X-Frame-Options "SAMEORIGIN" always;
add_header X-Content-Type-Options "nosniff" always;
add_header X-XSS-Protection "1; mode=block" always;
add_header Referrer-Policy "strict-origin-when-cross-origin" always;
#add_header Content-Security-Policy "default-src 'self';" always;
add_header Content-Security-Policy "default-src 'self'; style-src 'self' https://cdnjs.cloudflare.com; font-src 'self' https://cdnjs.cloudflare.com; img-src 'self' https://images.unsplash.com; script-src 'self';";


client_max_body_size 10M;

  location / {
    try_files $uri $uri/ =404; # Обрабатывает запросы к файлам и папкам
limit_req zone=req_limit_per_ip burst=10 nodelay;
  }

    location ~* \.(css|js|png|jpg|jpeg|gif|ico|svg)$ {
        try_files $uri =404;
    }

}
