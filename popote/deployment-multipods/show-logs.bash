#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "manque nom du pod pour afficher ses logs"
    exit -1
fi

POD=$(kubectl get pods | grep $1 | awk -F ' ' '{print $1}')
echo $Pods
nbPods=$(echo $POD | wc -l)
echo "nbPods = $nbPods"
if [[ $nbPods -gt 1 ]]; then 
    echo "$1 ne correspond pas a un pod unique, veuillez affiner votre selection"
    exit -1
fi
if [[ $nbPods -eq 0 ]]; then 
    echo "$1 ne correspond pas a un pod veuillez modifier votre selection"
    exit -1
fi
echo "logs du pod : $POD"
kubectl logs -f $POD