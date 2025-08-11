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
    # kubectl delete ingressClass k8sbfr-nginx
    change-namespace.bash default
    echo "Suppression du namespace en cours (peut prendre plusieurs minutes) ....."
    kubectl delete namespace ingress-nginx > /dev/null
    source set-bash-variable.bash K8S_INGRESS_NGINX=""
fi