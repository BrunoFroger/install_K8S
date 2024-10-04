#!/bin/bash -e

if [[ "X-$K8S_NAMESPACE" == "X-" ]]; then

    #Vérification argument
    if [ $# -ne 1 ]; then
        echo "Le nombre d'argument est invalide : $#"
        echo "Commande attendue : ./$0 <namespace>" 
        exit
    else
        source ./95-set-bash-variable.bash K8S_NAMESPACE=$1
    fi
fi
kubectl config set-context --current --namespace=$K8S_NAMESPACE
kubectl config get-contexts