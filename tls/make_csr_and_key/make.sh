#!/usr/bin/env bash

set -Eeuo pipefail

openssl req \
    -new \
    -newkey rsa:2048 \
    -nodes \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=root.sebelino.com" \
    -keyout rootca.out.key \
    -out rootca.out.csr

# Print CSR + verify its signature
openssl req -text -noout -verify -in rootca.out.csr
