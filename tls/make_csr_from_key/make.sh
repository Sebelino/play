#!/usr/bin/env bash

set -Eeuo pipefail

openssl req \
    -new \
    -key rootca.in.key \
    -nodes \
    -subj "/CN=root.sebelino.com" \
    -out rootca.out.csr

# Print CSR + verify its signature
openssl req -text -noout -verify -in rootca.out.csr
