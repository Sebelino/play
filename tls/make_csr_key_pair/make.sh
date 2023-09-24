#!/usr/bin/env bash

set -Eeuo pipefail

openssl req \
    -new \
    -newkey rsa:2048 \
    -nodes \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=root.sebelino.com" \
    -keyout rootca.key \
    -out rootca.csr

# Print CSR + verify its signature
openssl req -text -noout -verify -in rootca.csr
