#!/usr/bin/env bash

set -Eeuo pipefail

openssl req \
    -new \
    -key rootca.in.key \
    -nodes \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=root.sebelino.com" \
    -out rootca.out.csr

# Print CSR + verify its signature
openssl req -text -noout -verify -in rootca.out.csr
