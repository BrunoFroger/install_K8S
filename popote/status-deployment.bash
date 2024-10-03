#!/bin/bash

echo "Pod    : " $(kubectl get pods | tail -1)
kubectl get deployments.apps
kubectl get services
kubectl get ingress