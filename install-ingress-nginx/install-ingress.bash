#!/bin/bash

# installation de ingress-nginx controler
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.2/deploy/static/provider/cloud/deploy.yaml

# attendre fin d'ainstall (running)
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s

# creation d'un serveur http provisoire pour test
kubectl create deployment demo --image=httpd --port=80
kubectl expose deployment demo

# creation d'une ressource ingress associee
kubectl create ingress demo-localhost --class=nginx \
  --rule="popote.zapto.org/*=demo:80"

# activation du port forward pour acceder a ce site
kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 8080:80

# test 
echo "test : doit afficher 'Itworks!'"
curl --resolve popote.zapto.org:8080:127.0.0.1 http://popote.zapto.org:8080