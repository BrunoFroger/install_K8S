#!/bin/bash

exec-cde(){
    echo "suppresion de <$1>"
    result=$(kubectl get $1 | grep popote | wc -l)
    if [[ $result -ge 1 ]]; then
        ressource=$(kubectl get $1 | grep popote | awk -F '{print $1}')
        echo "suppression de la ressource $ressource"
        kubectl delete $1 $ressource
        while :
        do
            result= $(kubectl get $1 | grep popote | wc -l)
            if [[ $result -eq 0 ]]; then
                break
            fi
        done
    fi
}

listeItems=("deployments.apps" "services" "ingress")

for item in $listeItems
do
    exec-cde $item
done

