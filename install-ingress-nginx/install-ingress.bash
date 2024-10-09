#!/bin/bash

# d'apres l'article : https://kubernetes.github.io/ingress-nginx/deploy/

# installation de ingress-nginx controler
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.2/deploy/static/provider/cloud/deploy.yaml

# attendre fin d'ainstall (running)
kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=120s

# creation d'un serveur http provisoire pour test
#kubectl create deployment demo --image=httpd --port=80
#kubectl expose deployment demo

# creation d'une ressource ingress associee
#kubectl create ingress demo-localhost --class=nginx --rule="k8sbfr.zapto.org/*=demo:80"
kubectl create ingress demo-localhost --class=nginx --rule="k8sbfr.zapto.org/*=service-popote:80" --type=LoadBalancer

# activation du port forward pour acceder a ce site
kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 8080:80

# test 
echo "test : doit afficher 'Itworks!'"
curl --resolve k8sbfr.zapto.org:8080:127.0.0.1 http://k8sbfr.zapto.org:8080