#!/bin/bash -e

kubectl config set-context --current --namespace=ingress-nginx

# Installons le gestionnaire d’Ingress Nginx
#kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/baremetal/deploy.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml

# patchons le déploiement du contrôleur nginx 
kubectl patch deployment ingress-nginx-controller -n ingress-nginx -p '{"spec":{"template":{"spec":{"hostNetwork":true}}}}'

#kubectl apply -f ./nginx-deployment.yaml