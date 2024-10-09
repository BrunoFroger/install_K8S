#!/bin/bash


# creation du namespace master-nginx
kubectl create namespace master-nginx
change-namespace.bash master-nginx

kubectl apply -f master-service.yaml
kubectl apply -f master-ingress.yaml