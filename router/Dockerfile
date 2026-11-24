# Tiny nginx router for single-domain deployments (e.g. Railway).
# Routes:
#   /              -> play web server (HTTP, port 3000)
#   /ws/           -> play websocket server (port 3001)
#   /api/          -> back API (port 8080, prefix stripped)
#   /map-storage/  -> map-storage API (port 3000, prefix stripped)
#   /icon/         -> icon server (port 8080, prefix stripped)
#   /maps/         -> static starter maps bundled from this repo
FROM nginx:1.27-alpine

COPY router/nginx.conf.template /etc/nginx/templates/default.conf.template
COPY maps /usr/share/nginx/html/maps

# Upstreams default to Railway private-networking hostnames; override per environment.
ENV PLAY_UPSTREAM=play.railway.internal:3000 \
    PLAY_WS_UPSTREAM=play.railway.internal:3001 \
    BACK_UPSTREAM=back.railway.internal:8080 \
    MAP_STORAGE_UPSTREAM=map-storage.railway.internal:3000 \
    ICON_UPSTREAM=icon.railway.internal:8080 \
    PORT=80

EXPOSE 80
