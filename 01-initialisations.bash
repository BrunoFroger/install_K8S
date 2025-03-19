#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       initialisations"
echo "*"
echo "*************************************************"

if [[ "X-$K8S_SCRIPT_INITIALISATION" == "X-OK" ]]; then
    echo "Initialisations déjà réalisées"
else 
    echo "Test installation de Wiptail necessaire (interface graphique pour bash)"
    testWhiptail=$(whiptail -v | cut -d " " -f 2)
    if [[ "X-$testWhiptail" != "X-(newt):" ]]; then 
        sudo apt install -y whiptail
    fi
    while :
    do
        # echo -n "quel tye de noeud voulez vous installer (master/slave) <${K8S_TYPE_NOEUD}> ? : "
        # read type_install
        type_install=$(whiptail --menu "choisissez votre type installation : " 15 60 2 \
            "master" "" \
            "slave" "" \
            3>&1 1>&2 2>&3)

        # if [[ "X-$K8S_TYPE_NOEUD" != "X-" ]]; then
        #     type_install=$K8S_TYPE_NOEUD
        # fi

        if [[ "X-$type_install" != "X-" ]]; then
            if [[ "$type_install" == "master" ]]; then
                source set-bash-variable.bash K8S_TYPE_NOEUD="master"
                source set-bash-variable.bash K8S_MASTER_KUBERNETES="$(hostname).local"
            elif [[ "$type_install" == "slave" ]]; then
                source set-bash-variable.bash K8S_TYPE_NOEUD="slave"
                # echo -n "nom de la machine master (ex:machinexx.local) <$K8S_MASTER_KUBERNETES> : "
                # read master
                master=$(whiptail --inputbox "nom de la machine master (ex:machinexx.local) :" 10 50 "$K8S_MASTER_KUBERNETES" 3>&1 1>&2 2>&3)
                if [[ "X-$master" != "X-" ]]; then
                    source set-bash-variable.bash K8S_MASTER_KUBERNETES=$master
                fi
            else
                echo "saisie incorrecte !"
            fi
        fi
        # echo -n "nom du namespace a utiliser <$K8S_NAMESPACE> : "
        # read namespace
        namespace=$(whiptail --inputbox "nom du namespace a utiliser : " 10 50 "$K8S_NAMESPACE" 3>&1 1>&2 2>&3)
        if [[ "X-$namespace" != "X-" ]]; then
            source set-bash-variable.bash K8S_NAMESPACE=$namespace
        fi

        # echo "type install      : $K8S_TYPE_NOEUD"
        # echo "master Kubernetes : $K8S_MASTER_KUBERNETES"
        # echo "master namespace  : $K8S_NAMESPACE"

        # echo -n "est-ce que ces donnees sont exactes : (o/N) : "
        # read valid
        valid_install=$(whiptail --yesno "type install      : $K8S_TYPE_NOEUD\n\
master Kubernetes : $K8S_MASTER_KUBERNETES\n\
master namespace  : $K8S_NAMESPACE\n\n\n\
est-ce que ces donnees sont exactes :" 12 50 3>&1 1>&2 2>&3 ; echo $?)
        if [[  "X-$valid_install" == "X-0" ]]; then
            break
        fi
    done

    source set-bash-variable.bash K8S_SCRIPT_INITIALISATION="OK"
    echo "initialisations => fin"
fi

