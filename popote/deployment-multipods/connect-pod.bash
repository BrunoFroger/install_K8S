#!/bin/bash


if [[ "X-$1" == "X-" ]]; then   
    echo "manque nom du pod (mariadb / backend / nginx / frontend)"
    exit -1
fi

podId=$(kubectl get pods | grep $1 | awk -F ' ' '{print $1}')
if [[ "X-$podId" == "X-" ]]; then
    echo "le pod $1 n'existe pas"
    exit -1
fi

kubectl exec -it $podId bash
