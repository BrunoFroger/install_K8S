#!/bin/bash

cd ~/projets/install_K8S/popote
kubectl apply -f deployment-monopod.yaml
kubectl apply -f popote-service.yaml
kubectl apply -f popote-ingress.yaml
