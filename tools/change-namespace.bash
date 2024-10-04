#!/bin/bash -e

#Vérification argument
if [ $# -ne 1 ]; then
    echo "Le nombre d'argument est invalide : $#"
    echo "Commande attendue : ./$0 <namespace>" 
    exit
else
    export K8S_NAMESPACE=$1
    set-bash-variable.bash K8S_NAMESPACE=$1
    kubectl config set-context --current --namespace=$K8S_NAMESPACE
    kubectl config get-contexts
fi
