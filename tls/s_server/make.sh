#!/usr/bin/env bash

set -Eeuo pipefail

openssl req \
    -new \
    -newkey rsa:2048 \
    -x509 \
    -sha256 \
    -days 30 \
    -nodes \
    -subj "/CN=root.sebelino.com" \
    -keyout rootca.out.key \
    -out rootca.out.crt

# Print cert
openssl x509 -text -noout -in rootca.out.crt
