#!/bin/bash -e


echo "*************************************************"
echo "*"
echo "*       installation de Desktop Kubernetes ...."
echo "*"
echo "*************************************************"


echo "-------------------------------------------------"
echo "installation de helm"
sudo snap install helm --classic

echo "-------------------------------------------------"
echo "installation du dashboard"
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard

echo "installation avec kong (installé préalablement) ou standard (par defaut) ? (k/s)"
read mode
if [[ "XX-$mode" == "X-k" ]]; then
    echo "installation de la version avec kong"
    kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443
    dashboard-url="https://localhost:8443"
else
    echo "installation de la version standard"
    kubectl proxy --port=8001
    echo "accès au dashboard avec : http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard-kong-proxy:443/proxy/"
    dashboard-url="http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard-kong-proxy:443/proxy/"
fi

echo "pour acceder au desktop ${dashboad-url}"