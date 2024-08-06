#!/bin/bash


if [[ "X-$K8S_TYPE_NOEUD" == "X-master" ]]; then
    echo "installation du noeud master ... "
    cde="sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --cri-socket=unix:///var/run/cri-dockerd.sock"
    echo "commande executee : $cde"
    $($cde)
elif [[ "X-$K8S_TYPE_NOEUD" == "X-slave" ]]; then
        echo "installation d'un noeud esclave ... "
        #token=$(kubeadm token create)
        token=ewl9xe.aack7rb9qsoq4tal
        echo "token = $token"
        cde="sudo kubeadm join $K8S_MASTER_KUBERNETES:6443 --token ewl9xe.aack7rb9qsoq4tal --discovery-token-unsafe-skip-ca-verification --cri-socket=unix:///var/run/cri-dockerd.sock"
        echo "commande executéé : $cde"
        $($cde)
else
    echo "type de noeud ($K8S_TYPE_NOEUD) inconnu"
fi
