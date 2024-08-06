#!/bin/bash


echo "*************************************************"
echo "*"
echo "*       initialisations"
echo "*"
echo "*************************************************"

if [[ "X-$K8S_SCRIPT_INITIALISATION" == "X-OK" ]]; then
    echo "Initialisations déjà réalisées"
else 
    export K8S_MASTER_KUBERNETES="$(hostname).local"
    while :
    do
        echo -n "quel tye de noeud voulez vous installer (master/slave) ? : "
        read type_install
        if [[ "$type_install" == "master" ]]; then
            export K8S_TYPE_NOEUD="master"
            break
        elif [[ "$type_install" == "slave" ]]; then
            export K8S_TYPE_NOEUD="slave"
            echo -n "nom de la machine master (ex:machinexx.local) : "
            read master
            export K8S_MASTER_KUBERNETES=$master
            break
        else
            echo "saisie incorrecte !"
        fi
    done

    export K8S_SCRIPT_INITIALISATION="OK"
fi

echo "type install : $K8S_TYPE_NOEUD"
echo "master Kubernetes : $K8S_MASTER_KUBERNETES"
