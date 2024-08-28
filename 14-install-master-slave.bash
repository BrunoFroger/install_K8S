#!/bin/bash -e

while :
do
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
        # echo "installation d'un noeud esclave ... "
        echo "Connectez vous sur le master et executer les commandes suivantes :"
        echo "   - cd <repertoire contenant le fichier install_K8S.out.log (repertoire depuis lequel vous avez réalisé l'installation du master) "
        echo "   - ./75-get-join-commande.bash"
        echo "copier le resultat de cette commande ci-dessous :"
        read cdeJoin
        $($cdeJoin)
    else
        echo "type de noeud ($K8S_TYPE_NOEUD) inconnu"
    fi

    result=$?
    #echo "le resultat de la commande est $result"
    if [[ "$result" == "0" ]]; then
        echo "commande init/join executée avec succès .... on continue"
    else
        echo "commande init/join en erreur .... que faire ?"
        echo -n "Appuyer sur une touche pour continuer ou R pour recommencer ou ^C pour arreter : (return/R/^C) "; read saisie
    fi
    if [[ "X-$saisie" != "X-R" &&  "X-$saisie" == "X-r" ]]; then break;fi
done