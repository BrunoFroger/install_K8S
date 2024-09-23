#!/bin/bash

docker build -t monapp:0.1 .
docker image tag monapp:0.1 fbruno/monapp:latest
docker image push fbruno/monapp:latest
#docker run --name monapp -d -p 5000:5000 monapp:0.1

kubectl create namespace monapp
kubectl config set-context --current --namespace=monapp

kubectl create configmap monapp-nginx --from-file=nginx.conf

kubectl apply -f app-deployment.yml

kubectl apply -f app-service.yaml
