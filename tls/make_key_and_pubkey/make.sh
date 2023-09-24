#!/usr/bin/env bash

set -Eeuo pipefail

openssl genrsa -out rootca.out.key 2048

openssl rsa -in rootca.out.key -pubout > rootca.out.pub

# Print private key
openssl rsa -text -noout -in rootca.out.key -check

echo "------------------------------------------------------------"

# Print public key
openssl rsa -text -noout -pubin -in rootca.out.pub
