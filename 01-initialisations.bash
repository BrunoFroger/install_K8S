#!/bin/bash 

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

        # if [[ "X-$K8S_TYPE_NOEUD" != "X-" ]]; then
        #     type_install=$K8S_TYPE_NOEUD
        # fi

        if [[ "X-$type_install" != "X-" ]]; then
            if [[ "$type_install" == "master" ]]; then
                source set-bash-variable.bash K8S_TYPE_NOEUD="master"
                source set-bash-variable.bash K8S_MASTER_KUBERNETES="$(hostname).local"
            elif [[ "$type_install" == "slave" ]]; then
                source set-bash-variable.bash K8S_TYPE_NOEUD="slave"
                echo -n "nom de la machine master (ex:machinexx.local) <$K8S_MASTER_KUBERNETES> : "
                read master
                if [[ "X-$master" != "X-" ]]; then
                    source set-bash-variable.bash K8S_MASTER_KUBERNETES=$master
                fi
            else
                echo "saisie incorrecte !"
            fi
        fi
        echo -n "nom du namespace a utiliser <$K8S_NAMESPACE> : "
        read namespace
        if [[ "X-$namespace" != "X-" ]]; then
            source set-bash-variable.bash K8S_NAMESPACE=$namespace
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

    source set-bash-variable.bash K8S_SCRIPT_INITIALISATION="OK"
    echo "initialisations => fin"
fi

