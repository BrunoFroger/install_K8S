#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       desinstall Kubernetes Web View"
echo "*"
echo "*************************************************"


if (whiptail --title "Confirmation Oui / Non" --yesno "voulez vous réellement desinstaller Kube-Web-View ?" 10 60) then

    change-namespace.bash default

    if [ -d "kube-web-view" ]; then
        echo "Le dossier kube-web-view existe."
        cd kube-web-view
        kubectl delete deployments.apps kube-web-view
        kubectl delete services kube-web-view
        rm -rf kube-web-view 
    else
        echo "Le dossier Kube-Web-View n'existe pas."
    fi
    unset K8S_KUBEWEBVIEW_INSTALLED
    cd ..
fi