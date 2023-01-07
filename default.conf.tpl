events {
    worker_connections 1024;
}
http {
  server_tokens off;
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
      proxy_set_header X-Forwarded-For $remote_addr;
      proxy_set_header Host            $http_host;
      proxy_pass ${APP_HOST}:${APP_PORT};
    }
  }
}
