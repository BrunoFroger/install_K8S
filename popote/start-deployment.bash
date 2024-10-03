#!/bin/bash


kubectl apply -f deployment-monopod.yaml
kubectl apply -f popote-service.yaml
kubectl apply -f popote-ingress.yaml
