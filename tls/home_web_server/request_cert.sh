#!/usr/bin/env bash

set -Eeuo pipefail

set -x

certbot \
    --manual \
    certonly \
    --config-dir ./certbot/config-dir \
    --work-dir ./certbot/work-dir \
    --logs-dir ./certbot/logs-dir \
    -m sebelino7@gmail.com \
    --agree-tos \
    --no-eff-email \
    --preferred-challenges dns \
    -d web2.sebelino.com

cp \
    ./certbot/config-dir/archive/web2.sebelino.com/privkey1.pem \
    ./data/nginx/tls-trusted/privkey.pem

cp \
    ./certbot/config-dir/archive/web2.sebelino.com/fullchain1.pem \
    ./data/nginx/tls-trusted/fullchain.pem
