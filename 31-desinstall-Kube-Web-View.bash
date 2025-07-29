#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       desinstall Kubernetes Web View"
echo "*"
echo "*************************************************"


if (whiptail --title "Confirmation Oui / Non" --yesno "voulez vous réellement desinstaller Kube-Web-View ?" 10 60) then

    change-namespace.bash Kube-Web-View

    if [ -d "Kube-Web-View" ]; then
        echo "Le dossier Kube-Web-View existe."
        cd Kube-Web-View
        kubectl delete deployments.apps kube-web-view
        rm -rf kube-web-view 
    else
        echo "Le dossier Kube-Web-View n'existe pas."
    fi
    source set-bash-variable.bash K8S_KUBEWEBVIEW=""
    cd ..
fi