# syntax=docker/dockerfile:1
# All-in-one WorkAdventure image for single-container free hosting (Northflank Sandbox).
# Assembles the official prebuilt v1.35.0 images: play + back + map-storage + redis
# behind one nginx front on port 80.

FROM thecodingmachine/workadventure-play:v1.35.0 AS play
FROM thecodingmachine/workadventure-back:v1.35.0 AS back
FROM thecodingmachine/workadventure-map-storage:v1.35.0 AS mapstorage

FROM node:24-trixie-slim
RUN apt-get update \
 && apt-get install -y --no-install-recommends nginx supervisor redis-server curl \
 && rm -rf /var/lib/apt/lists/*

COPY --from=play /usr/src /wa/play-app
COPY --from=back /usr/src /wa/back-app
COPY --from=mapstorage /usr/src /wa/map-storage-app

COPY deploy/allinone/nginx.conf /etc/nginx/nginx.conf
COPY deploy/allinone/supervisord.conf /etc/supervisor/supervisord.conf
COPY deploy/allinone/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80
CMD ["/entrypoint.sh"]
