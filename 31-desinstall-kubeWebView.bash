#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       desinstall Kubernetes Web View"
echo "*"
echo "*************************************************"


if (whiptail --title "Confirmation Oui / Non" --yesno "voulez vous réellement desinstaller Kube-Web-View ?" 10 60) then

    change-namespace.bash default

    if [ -d "k8sbfr-kube-web-view" ]; then
        echo "Le dossier k8sbfr-kube-web-view existe."
        cd k8sbfr-kube-web-view
        kubectl delete deployments.apps kube-web-view
        kubectl delete services kube-web-view
        pod_name=$(kubectl get pods | grep kube-web-view | awk '{print $1}')
        echo "attendre fin execution pod : ${pod_name}"
        kubectl wait --for=delete pod/${pod_name} --timeout=300s
        rm -rf kube-web-view 
        cd ..
    else
        echo "Le dossier k8sbfr-kube-web-view n'existe pas."
    fi
    unset K8S_KUBEWEBVIEW_INSTALLED
fi
