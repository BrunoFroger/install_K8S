#!/bin/bash

aide(){    
    echo "syntaxe : connect-pod.bash pod [container]"
    echo "          pod = chaine minimale permaettant d'identifier un pod"
    echo "          container = (si plusieurs container dans un pod) chaine minimale permaettant d'identifier un container"
    exit -1
}

if [[ "X-$1" == "X-" ]]; then   
    echo "ERREUR : manque nom du pod (mariadb / backend / nginx / frontend)"
    aide
fi

podId=$(kubectl get pods | grep $1 | awk -F ' ' '{print $1}')

if [[ "X-$podId" == "X-" ]]; then
    echo "ERREUR : le pod $1 n'existe pas"
    aide
fi

echo "podId : $podId"

containerListe=$(kubectl get pods $podId -o='custom-columns=CONTAINERS:.spec.containers[*].name'| tail -1 | sed 's/,/\n/g')
#echo "Liste des containeurs = $containerListe"
nbContainers=$(echo $containerListe | wc -w)
#echo "nombre des containeurs = $nbContainers"

containeur=""
if [[ $nbContainers -gt 1 ]]; then
    #echo "le pod $podId contient plusieurs containeurs"
    if [[ "X-$2" != "X-" ]]; then   
        containerId=$(echo "$containerListe" | grep $2)
        echo "containerId : $containerId"
        containeur="--container $containerId"
    else 
        echo "ERREUR : ce pod contient plusieurs container, il faut preciser sur quel container se connecter"
        aide
    fi
fi

kubectl exec -it $podId $containeur -- bash
