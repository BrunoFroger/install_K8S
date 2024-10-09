#!/bin/bash

# https://blog.zwindler.fr/2018/03/06/exposer-des-applications-kubernetes-en-dehors-des-cloud-providers-nginx-ingress-controller/

# creation du namespace master-nginx
kubectl create namespace master-nginx
change-namespace.bash master-nginx

# deploiement ....
kubeadm apply -f popote-service.yaml
kubectl apply -f master-service.yaml
kubectl apply -f master-ingress.yaml