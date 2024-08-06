#!/bin/bash


if [[ "X-$K8S_TYPE_NOEUD" == "X-master" ]]; then
    echo "installation du noeud master ... "
    cde="sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --cri-socket=unix:///var/run/cri-dockerd.sock"
elif [[ "X-$K8S_TYPE_NOEUD" == "X-slave" ]]; then
        echo "installation d'un noeud esclave ... "
        #token=$(kubeadm token create)
        token=ewl9xe.aack7rb9qsoq4tal
        echo "token = $token"
        cde="sudo kubeadm join $K8S_MASTER_KUBERNETES:6443 \
            --token ewl9xe.aack7rb9qsoq4tal \
            --ignore-preflight-errors=all \
            --discovery-token-unsafe-skip-ca-verification \
            --cri-socket=unix:///var/run/cri-dockerd.sock"
else
    echo "type de noeud ($K8S_TYPE_NOEUD) inconnu"
fi

echo "commande executee : $cde"
$($cde)
result=$?
echo "le resultat de la commande est $result"
if [[ "$result" == "0" ]]; then
    echo "commande executée avec succès .... on continue"
else
    echo "commande init/join en erreur .... que faire ?"
    read -p "Appuyer sur une touche pour continuer ou ^C pour arreter : "
fi