#!/usr/bin/env bash

set -Eeuo pipefail

cd ./data/nginx/tls-untrusted/

echo "-------------- Root CA setup, run by root CA --------------"

openssl genrsa -out rootca.out.key 2048

openssl rsa -in rootca.out.key -pubout > rootca.out.pub

openssl req \
    -new \
    -key rootca.out.key \
    -nodes \
    -subj "/CN=root.sebelino.com" \
    -out rootca.out.csr

openssl x509 \
    -req \
    -days 30 \
    -in rootca.out.csr \
    -signkey rootca.out.key \
    -out rootca.out.crt

echo "-------------- End entity setup, run by end entity --------------"

openssl genrsa -out end.out.key 2048

openssl rsa -in end.out.key -pubout > end.out.pub

openssl req \
    -new \
    -key end.out.key \
    -nodes \
    -subj "/CN=web.sebelino.com" \
    -out end.out.csr

echo "-------------- Issuing, run by root CA --------------"

openssl x509 \
    -req \
    -CAcreateserial \
    -in end.out.csr \
    -CA rootca.out.crt \
    -CAkey rootca.out.key \
    -out end.out.crt

echo "-------------- Adjust files for Nginx --------------"

mv end.out.key privkey.pem
mv end.out.crt fullchain.pem
