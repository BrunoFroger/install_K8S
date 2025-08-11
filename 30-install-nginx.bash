#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       installation de nginx"
echo "*"
echo "*************************************************"


kubectl apply -f nginx-configmap.yaml
kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-service.yaml

