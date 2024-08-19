#!/bin/bash -e


if [[ "X-$K8S_TYPE_NOEUD" == "X-master" ]]; then
    echo "installation du noeud master ... "
    sudo kubeadm init --pod-network-cidr=192.168.0.0/16 \
    --cri-socket=unix:///var/run/cri-dockerd.sock \
    > >(tee ./kubeadm-init.out.log) 2>./kubeadm-init.err.log
    echo "*******************************************************"
    echo "                                                      *"
    echo "          A T T E N T I O N                           *"
    echo "                                                      *"
    echo "* les informations pour connecter un noued a ce       *"
    echo "* cluster sont dans le fichier kubeadm-init.out.log   *" 
    echo " ne pas effacer ce fichier .....                      *" 
    echo "*******************************************************"
elif [[ "X-$K8S_TYPE_NOEUD" == "X-slave" ]]; then
        echo "installation d'un noeud esclave ... "
        echo "saisissez la commande kubeadm join donnée lors de la création du master (fichier kubeadm-init.out.log sur master) : "
        read cdeJoin
        sudo sudo ${cdeJoin} --cri-socket=unix:///var/run/cri-dockerd.sock
else
    echo "type de noeud ($K8S_TYPE_NOEUD) inconnu"
fi

result=$?
#echo "le resultat de la commande est $result"
if [[ "$result" == "0" ]]; then
    echo "commande init/join executée avec succès .... on continue"
else
    echo "commande init/join en erreur .... que faire ?"
    echo -n "Appuyer sur une touche pour continuer ou ^C pour arreter : "; read
fi