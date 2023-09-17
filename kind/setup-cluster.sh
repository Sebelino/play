#!/usr/bin/env bash

set -euo pipefail

set -x

if ! kubectl cluster-info --context kind-kind; then
    kind create cluster --config=./kind-cluster.yaml
fi

kind load docker-image myapp:dev

kubectl apply -f myapp.yaml
kubectl apply -f nginx.yaml

kubectl apply -f ./kong/all-in-one-dbless.yaml
kubectl -n kong patch deployment proxy-kong -p "$(cat ./kong/deployment-patch.json)"
kubectl -n kong patch service kong-proxy -p "$(cat ./kong/service-patch.json)"

# Getting weird networking issues here from Kong? Did you upgrade your kernel
# recently? Try restarting your machine and modprobing some stuff.
# https://github.com/kubernetes-sigs/kind/issues/3170

# Now try `curl localhost/myapp`
