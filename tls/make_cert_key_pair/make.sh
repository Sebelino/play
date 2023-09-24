#!/usr/bin/env bash

set -Eeuo pipefail

openssl req \
    -new \
    -newkey rsa:2048 \
    -x509 \
    -sha256 \
    -days 30 \
    -nodes \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=root.sebelino.com" \
    -keyout rootca.key \
    -out rootca.crt

# Print cert
openssl x509 -text -noout -in rootca.crt
