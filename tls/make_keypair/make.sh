#!/usr/bin/env bash

set -Eeuo pipefail

openssl genrsa -out rootca.key 2048

openssl rsa -in rootca.key -pubout > rootca.pub

# Print private key
openssl rsa -text -noout -in rootca.key -check

echo "------------------------------------------------------------"

# Print public key
openssl rsa -text -noout -pubin -in rootca.pub
