#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       installation de l'application"
echo "*                 Kubernetes Web View"
echo "*"
echo "*************************************************"

status="KO"

echo "essai installation de Kube-Web-View"

echo "creation du namespace k8sbfr-Kube-Web-View, si necessaire"
cd k8sbfr-Kube-Web-View
if [[ $(kubectl get namespaces 2> /dev/null | grep k8sbfr-Kube-Web-View | wc -l) == 0 ]]; then
    echo "creation du namespace en cours ....."
    kubectl create namespace k8sbfr-Kube-Web-View
fi

echo "changement de namespace vers k8sbfr-Kube-Web-View"
kubectl config set-context --current --namespace=k8sbfr-Kube-Web-View

mkdir Kube-Web-View
cd Kube-Web-View
if [[ $(kubectl get pods 2> /dev/null | grep -v NAME | grep KubernetesWebView | wc -l) == 0 ]]; then
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