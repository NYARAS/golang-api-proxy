server {
    listen ${LISTEN_PORT};
    root  /var/www;

    location / {
      index index.html;
    }

    # Media: images, icons, video, audio, HTC
    location ~* \.(?:jpg|jpeg|gif|png|ico|cur|gz|svg|svgz|mp4|ogg|ogv|webm|htc)$ {
      expires 1d;
      access_log off;
      add_header Cache-Control "public";
    }

    # CSS and Javascript
    location ~* \.(?:css|js)$ {
      expires 1d;
      access_log off;
      add_header Cache-Control "public";
    }

    location /api/ {
        proxy_pass              http://${APP_HOST}:${APP_PORT}/;
        proxy_http_version  1.1;
        proxy_redirect      default;
        client_max_body_size    10M;
    }
}
