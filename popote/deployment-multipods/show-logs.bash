#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "manque nom du pod pour afficher ses logs"
    exit -1
fi

POD=$(kubectl get pods | grep $1 | awk -F ' ' '{print $1}')
echo "logs du pod : $POD"
kubectl logs -f $POD