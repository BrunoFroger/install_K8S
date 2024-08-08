#!/bin/bash -e

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
            echo "export K8S_TYPE_NOEUD"
            export K8S_TYPE_NOEUD="master"
            break
        elif [[ "$type_install" == "slave" ]]; then
            echo "export K8S_TYPE_NOEUD"
            export K8S_TYPE_NOEUD="slave"
            echo -n "nom de la machine master (ex:machinexx.local) : "
            read master
            echo "export K8S_MASTER_KUBERNETES"
            export K8S_MASTER_KUBERNETES=$master
            break
        else
            echo "saisie incorrecte !"
        fi
        echo -n "nom du namespace a utiliser : "
        read namespace
        export K8S_NAMESPACE=$namespace

        echo "type install      : $K8S_TYPE_NOEUD"
        echo "master Kubernetes : $K8S_MASTER_KUBERNETES"
        echo "master namespace  : $K8S_NAMESPACE"
        
        echo -n "est-ce que ces donnees sont exactes : (o/N) : "
        read valid
        if [[  "X-$valid" == "X-o" || "X-$valid" == "X-O" ]]; then
            break
        fi
    done

    echo "export K8S_SCRIPT_INITIALISATION"
    export K8S_SCRIPT_INITIALISATION="OK"
    echo "initialisations => fin"
fi

