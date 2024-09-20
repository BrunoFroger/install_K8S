#!/bin/bash

DEPLOYMENTS=$(kubectl get deployments.apps | grep deployment | awk -F ' ' '{print $1}')
kubectl delete $DEPLOYMENTS
