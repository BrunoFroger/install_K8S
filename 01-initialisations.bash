#!/bin/bash -e

echo "*************************************************"
echo "*"
echo "*       initialisations"
echo "*"
echo "*************************************************"

if [[ "X-$K8S_SCRIPT_INITIALISATION" == "X-OK" ]]; then
    echo "Initialisations déjà réalisées"
else 
    while :
    do
        echo -n "quel tye de noeud voulez vous installer (master/slave) <${K8S_TYPE_NOEUD}> ? : "
        read type_install

        if [[ "X-$type_install" != "X-" ]]; then
            if [[ "$type_install" == "master" ]]; then
                #echo "export K8S_TYPE_NOEUD"
                export K8S_TYPE_NOEUD="master"
                export K8S_MASTER_KUBERNETES="$(hostname).local"
            elif [[ "$type_install" == "slave" ]]; then
                #echo "export K8S_TYPE_NOEUD"
                export K8S_TYPE_NOEUD="slave"
                echo -n "nom de la machine master (ex:machinexx.local) <$K8S> : "
                read master
                if [[ "X-$master" != "X-" ]]; then
                    #echo "export K8S_MASTER_KUBERNETES"
                    export K8S_MASTER_KUBERNETES=$master
                fi
            else
                echo "saisie incorrecte !"
            fi
        fi
        echo -n "nom du namespace a utiliser <$K8S_NAMESPACE> : "
        read namespace
        if [[ "X-$namespace" != "X-" ]]; then
            export K8S_NAMESPACE=$namespace
        fi

        echo "type install      : $K8S_TYPE_NOEUD"
        echo "master Kubernetes : $K8S_MASTER_KUBERNETES"
        echo "master namespace  : $K8S_NAMESPACE"

        echo -n "est-ce que ces donnees sont exactes : (o/N) : "
        read valid
        if [[  "X-$valid" == "X-o" || "X-$valid" == "X-O" ]]; then
            break
        fi
    done

    #echo "export K8S_SCRIPT_INITIALISATION"
    export K8S_SCRIPT_INITIALISATION="OK"
    echo "export K8S_TYPE_NOEUD=${K8S_TYPE_NOEUD}" >> ~/.bashrc
    echo "export K8S_MASTER_KUBERNETES=${K8S_MASTER_KUBERNETES}" >> ~/.bashrc
    echo "export K8S_NAMESPACE=${K8S_NAMESPACE}" >> ~/.bashrc
    echo "export K8S_SCRIPT_INITIALISATION=${K8S_SCRIPT_INITIALISATION}" >> ~/.bashrc
    echo "initialisations => fin"
fi

