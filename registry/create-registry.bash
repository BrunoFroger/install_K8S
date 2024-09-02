#!/bin/bash -e


kubectl create namespace docker-registry
kubectl apply -f registry-pvc.yaml

./gen-pass.bash

helm repo add twuni https://helm.twun.io
helm repo update

REGISTRY_HTPASSWD=$(cat./registry/htpasswd)
cat registry-chart.yaml | sed "s/{{REGISTRY_HTPASSWD}}/$REGISTRY_HTPASSWD/g" | \
helm install docker-registry --namespace docker-registry twuni/docker-registry -f -


kubectl apply -f ingressroute.yaml

