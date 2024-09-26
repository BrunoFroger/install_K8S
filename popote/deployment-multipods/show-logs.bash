#!/bin/bash

# if [[ $# -ne 1 ]]; then
#     echo "manque nom du pod pour afficher ses logs"
#     exit -1
# fi

# POD=$(kubectl get pods | grep $1 | awk -F ' ' '{print $1}')
# #echo $POD
# nbPods=$(echo $POD | wc -w)
# #echo "nbPods = $nbPods"
# if [[ $nbPods -gt 1 ]]; then 
#     echo "<$1> ne correspond pas a un pod unique, veuillez affiner votre selection"
#     exit -1
# fi
# if [[ $nbPods -eq 0 ]]; then 
#     echo "<$1> ne correspond pas a un pod veuillez modifier votre selection"
#     exit -1
# fi
# echo "logs du pod : $POD"

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
echo "podId = $podId"

if [[ "X-$podId" == "X-" ]]; then
    echo "ERREUR : le pod $1 n'existe pas"
    aide
fi

containerListe=$(kubectl get pods $podId -o='custom-columns=CONTAINERS:.spec.containers[*].name'| tail -1 | sed 's/,/\n/g')
#echo "Liste des containeurs = $containerListe"
nbContainers=$(echo $containerListe | wc -w)
#echo "nombre des containeurs = $nbContainers"

containeur=""
if [[ $nbContainers -gt 1 ]]; then
    #echo "le pod $podId contient plusieurs containeurs"
    if [[ "X-$2" != "X-" ]]; then   
        containerId=$(echo "$containerListe" | grep $2)
        #echo "containeur sur lequel on se connecte : $containerId"
        containeur="--container $containerId"
    else 
        echo "ERREUR : ce pod contient plusieurs container, il faut preciser sur quel container se connecter"
        aide
    fi
fi

#kubectl exec -it $podId $containeur -- bash

#kubectl logs -f $POD

kubectl logs -f $podId $containeur