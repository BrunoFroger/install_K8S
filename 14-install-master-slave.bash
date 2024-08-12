#!/bin/bash -e


if [[ "X-$K8S_TYPE_NOEUD" == "X-master" ]]; then
    echo "installation du noeud master ... "
    sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --cri-socket=unix:///var/run/cri-dockerd.sock
elif [[ "X-$K8S_TYPE_NOEUD" == "X-slave" ]]; then
        echo "installation d'un noeud esclave ... "
        echo "saisissez le token du master (kubeadm token create) et recopiez le ici : "
        read token
        #token=ewl9xe.aack7rb9qsoq4tal
        echo "token = $token"
        sudo kubeadm join ${K8S_MASTER_KUBERNETES}:6443 \
            --token ${token} \
            --ignore-preflight-errors=all \
            --discovery-token-unsafe-skip-ca-verification \
            --cri-socket=unix:///var/run/cri-dockerd.sock
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