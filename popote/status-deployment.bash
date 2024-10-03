#!/bin/bash

echo "Pod         : " $(kubectl get pods | tail -1)
echo "Deployments : " $(kubectl get deployments.apps | tail -1)
echo "Service     : " $(kubectl get services | tail -1)
echo "Ingress     : " $(kubectl get ingress | tail -1)