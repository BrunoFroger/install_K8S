#!/bin/bash

podId=$(kubectl get deployments.apps | grep popote | awk -F ' ' '{print $1}')
kubectl get pods $podId
kubectl get deployments.apps
kubectl get services
kubectl get ingress