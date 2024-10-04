#!/bin/bash -e

#Vérification argument
if [ $# -ne 1 ]; then
    echo "Le nombre d'argument est invalide : $#"
    echo "Commande attendue : ./$0 <namespace>" 
    exit
else
    # test que le namespace existe
    result=$(kubectl get namespaces | grep $1 | wc -l)
    if [ $result -ne 1 ]; then
        echo "le namespce $1 n'existe pas"
        exit
    fi
    #echo "on change de namespace : $1"
    export K8S_NAMESPACE=$1
    set-bash-variable.bash K8S_NAMESPACE=$1
    kubectl config set-context --current --namespace=$K8S_NAMESPACE
    kubectl config get-contexts
fi
