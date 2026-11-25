# ProjectSend on Railway

[ProjectSend](https://github.com/projectsend/projectsend) (GPL-2.0): a self-hosted client file-sharing portal with per-client uploads and downloads, groups, roles and an admin panel. Deploy it on Railway with one click.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/PLACEHOLDER)

## What this template runs
- **projectsend**: `ghcr.io/onepush-dev/projectsend:2.10.0`, the official `projectsend/projectsend:2.10.0` image (application unmodified). nginx + PHP-FPM on port 80 plus the queue workers and scheduler. One volume at `/var/www/html/storage` holds uploads and the generated `APP_KEY`.
- **MySQL**: Railway MySQL for the database.
- **Redis**: Railway Redis for cache, sessions and queue.

The first administrator is created on first boot from `ADMIN_EMAIL` / `ADMIN_PASSWORD`, so nobody else can claim the setup screen.

## After deploy
Sign in at the Railway URL as `admin@example.com` with the `ADMIN_PASSWORD` service variable, then change the email and password. Configure SMTP under System → Settings → Email (mail is logged until then).

Not affiliated with ProjectSend.
