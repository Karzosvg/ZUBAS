#!/bin/sh
set -e
: "${DOMAIN:?DOMAIN env var is required (host only, e.g. my-app.code.run)}"
: "${SECRET_KEY:?SECRET_KEY env var is required}"
: "${MAP_STORAGE_PASSWORD:?MAP_STORAGE_PASSWORD env var is required}"

# Inter-service wiring (all localhost, single container)
export PUSHER_URL="https://${DOMAIN}/"
export FRONT_URL="/"
export API_URL="127.0.0.1:50051"
export PLAY_URL="https://${DOMAIN}"
export MAP_STORAGE_URL="127.0.0.1:50053"
export INTERNAL_MAP_STORAGE_URL="http://127.0.0.1:3000"
export PUBLIC_MAP_STORAGE_URL="https://${DOMAIN}/map-storage"
export REDIS_HOST="127.0.0.1"
export PUSHER_HTTP_PORT=3010
export PUSHER_WS_PORT=3011

# Sensible defaults matching the production compose template
export ENABLE_MAP_EDITOR="${ENABLE_MAP_EDITOR:-true}"
export MAP_EDITOR_ALLOW_ALL_USERS="${MAP_EDITOR_ALLOW_ALL_USERS:-true}"
export ENABLE_CHAT="${ENABLE_CHAT:-true}"
export ENABLE_CHAT_UPLOAD="${ENABLE_CHAT_UPLOAD:-true}"
export ENABLE_CHAT_ONLINE_LIST="${ENABLE_CHAT_ONLINE_LIST:-true}"
export ENABLE_CHAT_DISCONNECTED_LIST="${ENABLE_CHAT_DISCONNECTED_LIST:-true}"
export DISABLE_ANONYMOUS="${DISABLE_ANONYMOUS:-false}"
export MAX_PER_GROUP="${MAX_PER_GROUP:-4}"
export MAX_USERS_FOR_WEBRTC="${MAX_USERS_FOR_WEBRTC:-4}"
export STORE_VARIABLES_FOR_LOCAL_MAPS="${STORE_VARIABLES_FOR_LOCAL_MAPS:-true}"
export JITSI_URL="${JITSI_URL:-meet.jit.si}"
export JITSI_PRIVATE_MODE="${JITSI_PRIVATE_MODE:-false}"
export ENABLE_TUTORIAL="${ENABLE_TUTORIAL:-true}"
export SKIP_RENDER_OPTIMIZATIONS="${SKIP_RENDER_OPTIMIZATIONS:-false}"
export FALLBACK_LOCALE="${FALLBACK_LOCALE:-en-US}"
export ENABLE_OPENAPI_ENDPOINT="${ENABLE_OPENAPI_ENDPOINT:-true}"
export GRPC_VERBOSITY=ERROR
export TZ="${TZ:-Africa/Cairo}"

# map-storage
export PATH_PREFIX="/map-storage"
export MAP_STORAGE_API_TOKEN="${MAP_STORAGE_API_TOKEN:-$SECRET_KEY}"
export ENABLE_BASIC_AUTHENTICATION=true
export ENABLE_BEARER_AUTHENTICATION=false
export ENABLE_DIGEST_AUTHENTICATION=false
export AUTHENTICATION_USER="${MAP_STORAGE_USER:-admin}"
export AUTHENTICATION_PASSWORD="$MAP_STORAGE_PASSWORD"
export ENTITY_COLLECTION_URLS="https://${DOMAIN}/collections/FurnitureCollection.json,https://${DOMAIN}/collections/OfficeCollection.json"

mkdir -p /data /maps
exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
