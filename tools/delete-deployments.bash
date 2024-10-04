#!/bin/bash

DEPLOYMENTS=$(kubectl get deployments.apps | grep deployment | awk -F ' ' '{print $1}')

for deployment in $DEPLOYMENTS
do
    kubectl delete deployments.apps $deployment
done
