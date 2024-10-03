#!/bin/bash

exec-cde(){
    echo "suppresion de $1"
    result=$(kubectl get $1 | grep popote | wc -l)
    if [[ $result -ge 1 ]]; then
        result=$(kubectl get $1 | grep popote | awk -F '{print $1}')
        kubectl delete $1s $result
        while :
        do
            result= $(kubectl get $1 | grep popote | wc -l)
            if [[ $result -eq 0 ]]; then
                break
            fi
        done
    fi
}

listeitems=("deployments.apps", "services", "ingress")

for item in $listeItems
do
    exec-cde $item
done

