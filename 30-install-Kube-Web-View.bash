#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       installation de l'application"
echo "*                 Kubernetes Web View"
echo "*"
echo "*************************************************"

status="KO"

echo "essai installation de Kube-Web-View"

change-namespace.bash default
mkdir Kube-Web-View
cd Kube-Web-View
if [[ $(kubectl get pods 2> /dev/null | grep -v NAME | grep Kube-Web-View | wc -l) == 0 ]]; then
    if [ ! -d "kube-web-view" ]; then
        git clone https://codeberg.org/hjacobs/kube-web-view
    fi
    kubectl apply -k kube-web-view/deploy

    echo "installation de l'application Kube-Web-View ok"
    status="OK"
else
    echo "l'application Kube-Web-View est deja deployée"
fi
cd ..

source set-bash-variable.bash K8S_KUBEWEBVIEW="${status}"