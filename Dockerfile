# ProjectSend on Railway: the official projectsend/projectsend:2.10.0 image (GPL-2.0), application unmodified.
# Railway layer: production defaults baked in (MySQL + Redis for cache/session/queue, trusted proxy headers) so the
# template needs no deploy-time inputs. The web app listens on port 8080 inside the container.
FROM projectsend/projectsend:2.10.0
LABEL org.opencontainers.image.source="https://github.com/onepush-dev/projectsend"
# Single public listener on 8080 (nginx); php-fpm stays on loopback so Railway's port detection and health check
# only ever see the web port.
RUN sed -i 's/listen 80 default_server;/listen 8080 default_server;/' /etc/nginx/http.d/default.conf \
 && printf '[www]\nlisten = 127.0.0.1:9000\n' > /usr/local/etc/php-fpm.d/zzz-railway.conf \
 && grep -n "listen" /etc/nginx/http.d/default.conf
ENV APP_ENV=production \
    APP_DEBUG=false \
    DB_CONNECTION=mysql \
    DB_PORT=3306 \
    DB_DATABASE=projectsend \
    DB_USERNAME=root \
    REDIS_PORT=6379 \
    CACHE_STORE=redis \
    SESSION_DRIVER=redis \
    QUEUE_CONNECTION=redis \
    TRUSTED_PROXIES=* \
    MAIL_MAILER=log \
    ADMIN_NAME=Administrator \
    ADMIN_EMAIL=admin@example.com
EXPOSE 8080
