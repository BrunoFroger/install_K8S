#!/bin/bash -e


echo "*************************************************"
echo "*"
echo "*       installation de kubeadm ...."
echo "*"
echo "*************************************************"


if [[ "X-$K8S_SCRIPT_INSTALL_KUBEADM" == "X-OK" ]]; then
  echo "installation kubeadm déjà réalisée"
else 
    echo "-------------------------------------------------"
    echo "kubeadm => desactivation du swap"
    sudo swapoff -a && sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

    echo "-------------------------------------------------"
    echo "kubeadm => installation de kubeadm"
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl gpg
    sudo mkdir -p -m 755 /etc/apt/keyrings
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update
    sudo apt-get install -y kubelet kubeadm kubectl
    sudo apt-mark hold kubelet kubeadm kubectl
    sudo apt-get update
    sudo apt-get -y upgrade

    echo "-------------------------------------------------"
    echo "kubeadm => initialisation/joindre un cluster"
    . ./14-install-master-slave.bash

    echo "-------------------------------------------------"
    echo "kubeadm => utilisation kubeadm/kubectl par utilisateur non root"
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

    echo "-------------------------------------------------"
    echo "kubeadm => declaration --cri-socket cri-dockerd"
    sudo kubeadm config images pull --cri-socket /run/cri-dockerd.sock 

    echo "-------------------------------------------------"
    echo "kubeadm => ajout d'un add-on reseau (calico)"
    kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.1/manifests/tigera-operator.yaml 
    kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.1/manifests/custom-resources.yaml 

    # echo "-------------------------------------------------"
    # echo "kubeadm => initialisation du namespace $K8S_NAMESPACE"
    # . ./20-change-namespace.bash $K8S_NAMESPACE



    echo "-------------------------------------------------"
    export K8S_SCRIPT_INSTALL_KUBEADM="OK"
    echo "installation de kubeadm => fin"

fi