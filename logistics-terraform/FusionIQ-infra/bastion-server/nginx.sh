#!/bin/bash

# Install NGINX
sudo yum install nginx -y

# Backup existing configuration
sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak

# Overwrite nginx.conf
# sudo cat <<EOL > /etc/nginx/nginx.conf
# user nginx;
# worker_processes auto;
# error_log /var/log/nginx/error.log notice;
# pid /run/nginx.pid;
# include /usr/share/nginx/modules/*.conf;

# events {
#     worker_connections 1024;
# }

# http {
#     log_format  main  '\$remote_addr - \$remote_user [\$time_local] "\$request" '
#                       '\$status \$body_bytes_sent "\$http_referer" '
#                       '"\$http_user_agent" "\$http_x_forwarded_for"';
#     access_log  /var/log/nginx/access.log  main;
#     sendfile            on;
#     tcp_nopush          on;
#     keepalive_timeout   65;
#     types_hash_max_size 4096;
#     include             /etc/nginx/mime.types;
#     default_type        application/octet-stream;

#     include /etc/nginx/conf.d/*.conf;

#     server {
#         listen       80;
#         server_name _;
        
#         location / {
#             root /usr/share/nginx/html;
#             try_files \$uri \$uri/ /index.html;
#         }
        
#         location /api/ {
#             proxy_pass https://d3bnsvwp4mo98j.cloudfront.net; # Update if needed
#         }
#     }
# }
# EOL

# Start and enable NGINX service
sudo systemctl start nginx
sudo systemctl enable nginx

# Reload NGINX to apply changes
sudo systemctl reload nginx

echo "NGINX installed and configured successfully."
