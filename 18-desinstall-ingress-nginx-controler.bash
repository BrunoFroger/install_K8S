#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       desinstall ingress-nginx-controller"
echo "*"
echo "*************************************************"


if (whiptail --title "Confirmation Oui / Non" --yesno "voulez vous réellement desinstaller ingress-controller ?" 10 60) then

    change-namespace.bash ingress-nginx
    kubectl delete deployments.apps ingress-nginx-controller
    kubectl delete services ingress-nginx-controller ingress-nginx-controller-admission
    kubectl delete jobs.batch ingress-nginx-admission-create ingress-nginx-admission-patch 
    change-namespace.bash default
    echo "Suppression du namespace en cours ....."
    kubectl delete namespace ingress-nginx > /dev/null
fi