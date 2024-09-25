#!/bin/bash

aide(){    
    echo "manque nom du pod (mariadb / backend / nginx / frontend)"
    echo "syntaxe : connect-pod.bash pod [container]"
    echo "          pod = chaine minimale permaettant d'dentifier un pod"
    echo "          container = (si plusieurs container dans un pod) chaine minimale permaettant d'dentifier un container"
    exit -1
}

if [[ "X-$1" == "X-" ]]; then   
    aide
fi

podId=$(kubectl get pods | grep $1 | awk -F ' ' '{print $1}')
echo "podId = $podId"

if [[ "X-$podId" == "X-" ]]; then
    echo "le pod $1 n'existe pas"
    aide
fi

containerListe=$(kubectl get pods $podId -o='custom-columns=CONTAINERS:.spec.containers[*].name'| tail -1 | sed 's/,/\n/g')
echo "Liste des containeurs = $containerListe"
nbContainers=$(echo $containerListe | wc -w)
echo "nombre des containeurs = $nbContainers"

containeur=""
if [[ n$nbContainers -gt 1 ]]; then
    if [[ "X-$2" != "X-" ]]; then   
        containerId=$(echo "$containerListe" | grep $2)
        echo "containeur sur lequel on se connecte : $containerId"
        containeur="--container $containerId"
    else 
        echo "erreur ce pod contient plusieurs container, il faut preciser sur quel container se connecter"
        aide
    fi
fi

kubectl exec -it $podId $containeur -- bash
