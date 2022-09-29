upstream elyasapis {
        server 172.27.2.182:9010;
        server 172.27.2.219:9010;
        server 172.27.4.165:9010        backup;
}
server {
        listen 443 ssl http2;
        server_name elyasapi.isaco.ir;
        include /etc/nginx/includes/ca.conf;
        include /etc/nginx/includes/headers.conf;
        access_log /var/www/logs/elyasapi.isaco.ir_access.log;
        error_log /var/www/logs/elyasapi.isaco.ir_error.log;
        location / {
                include /etc/nginx/includes/proxyConfig.conf;
                proxy_pass http://elyasapis;
        }
        include /etc/nginx/includes/commonConf.conf;
}

server {
        listen 80;
        server_name elyasapi.isaco.ir;
        location / {
                return 301 https://elyasapi.isaco.ir$request_uri;
        }
}
