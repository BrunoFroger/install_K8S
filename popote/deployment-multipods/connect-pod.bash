#!/bin/bash


if [[ "X-$1" == "X-" ]]; then   
    echo "manque nom du pod (mariadb / backend / nginx / frontend)"
    echo "syntaxe : connect-pod.bash pod [container]"
    echo "          pod = chaine minimale permaettant d'dentifier un pod"
    echo "          container = (si plusieurs container dans un pod) chaine minimale permaettant d'dentifier un container"
    exit -1
fi

if [[ "X-$2" != "X-" ]]; then   
    echo "execution de la commande dans le containeur $2"
    containeur="--container $2"
else 
    containeur=""
fi

podId=$(kubectl get pods | grep $1 | awk -F ' ' '{print $1}')
containerListe=$(kubectl get pods $podId -o='custom-columns=CONTAINERS:.spec.containers[*].name')| tail -1 | sed 's/;/\n\g'
echo "Liste des containeurs = $containerListe"
containerId=$(echo $containerListe | grep $2)
echo "containeur sur lequel on se connecte : $containerId
if [[ "X-$podId" == "X-" ]]; then
    echo "le pod $1 n'existe pas"
    exit -1
fi

kubectl exec -it $podId $containeur -- bash
