#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       desinstallation de l'application"
echo "*                 hello-node"
echo "*"
echo "*************************************************"

if (whiptail --title "Confirmation Oui / Non" --yesno "voulez vous réellement desinstaller hello-node ?" 10 60) then

    kubectl config set-context --current --namespace=k8sbfr-hello-node
    kubectl delete services k8sbfr-hello-node -wait
    kubectl delete deployment k8sbfr-hello-node -wait
    kubectl config set-context --current --namespace=default
    kubectl delete namespace k8sbfr-hello-node -wait

    unset K8S_HELLO_NODE_INSTALLED
    echo "hello-node desinstallé"
    echo "appuyez sur enter pour continuer"
    read
fi
