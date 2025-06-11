#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       desinstall ingress-nginx-controller"
echo "*"
echo "*************************************************"


if (whiptail --title "Confirmation Oui / Non" --yesno "voulez vous réellement desinstaller k8sbfr-my-ingress ?" 10 60) then

    kubectl delete deployments.apps ingress-nginx-controller
    kubectl delete services ingress-nginx-controller ingress-nginx-controller-admission
    kubectl delete jobs.batch ingress-nginx-admission-create ingress-nginx-admission-patch 
    change-namespace.bash default
    kubectl delete namespace ingress-nginx

fi