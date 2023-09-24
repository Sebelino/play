#!/usr/bin/env bash

set -Eeuo pipefail

openssl x509 \
    -req \
    -days 30 \
    -in rootca.in.csr \
    -signkey rootca.in.key \
    -out rootca.out.crt

# Print cert
openssl x509 -text -noout -in rootca.out.crt
