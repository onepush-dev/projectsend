# ProjectSend on Railway: the official projectsend/projectsend:2.10.0 image (GPL-2.0), application unmodified.
# Railway layer: production defaults baked in (MySQL + Redis for cache/session/queue, trusted proxy headers) so the
# template needs no deploy-time inputs. The web app listens on port 80 inside the container.
FROM projectsend/projectsend:2.10.0
LABEL org.opencontainers.image.source="https://github.com/onepush-dev/projectsend"
# Railway's private network and health checks are IPv6: make nginx listen there too.
RUN sed -i 's/^\(\s*\)listen 80 default_server;/&\n\1listen [::]:80 default_server;/' /etc/nginx/http.d/default.conf && grep -n listen /etc/nginx/http.d/default.conf
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
