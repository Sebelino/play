#!/usr/bin/env bash

set -euo pipefail

set -x

docker build . -t myapp:dev
kind load docker-image myapp:dev
kubectl rollout restart deployment myapp
