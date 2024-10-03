#!/bin/bash

exec-cde(){
    echo "traitement de <$1>"
    result=$(kubectl get $1 | grep popote | wc -l)
    if [[ $result -ge 1 ]]; then
        ressource=$(kubectl get $1 | grep popote | awk -F ' ' '{print $1}')
        echo "suppression de la ressource $ressource"
        kubectl delete $1 $ressource
        while :
        do
            echo "on attends la fin de l'arret de $1"
            result=$(kubectl get $1 | grep popote | wc -l)
            if [[ $result -eq 0 ]]; then
                continue
            fi
        done
    fi
}

for item in "deployments.apps" "services" "ingress"
do
    echo "item = $item"
    exec-cde $item
done

