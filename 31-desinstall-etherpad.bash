#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       desinstallation de l'application"
echo "*                 etherpad"
echo "*"
echo "*************************************************"


if (whiptail --title "Confirmation Oui / Non" --yesno "voulez vous réellement desinstaller etherpad ?" 10 60) then

    echo "changement de namespace vers k8sbfr-etherpad"
    kubectl config set-context --current --namespace=k8sbfr-etherpad

    echo "creation du configMap, veuillez patienter ....."
    kubectl delete configMap etherpad-config

    echo "suppression du pod etherpad, veuillez patienter ....."
    kubectl delete pods etherpad

    echo "suppression du service, veuillez patienter ....."
    kubectl delete services etherpad-cip

    echo "creation de l'ingress, veuillez patienter ....."
    kubectl delete ingress etherpad

    change-namespace.bash default
    kubectl delete namespace k8sbfr-etherpad --wait

    echo "suppression de l'application etherpad ok"
    status="OK"
fi
cd ..

source set-bash-variable.bash K8S_ETHERPAD="${status}"