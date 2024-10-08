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
    dashboardUrl="https://localhost:8443"
else
    echo "installation de la version standard"
    kubectl proxy --port=8001&
    dashboardUrl="http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard-kong-proxy:443/proxy/"
fi


echo "-------------------------------------------------"
echo "creation user admin du dashboard"
kubectl apply -f dashboard-adminuser.yaml
kubectl apply -f clusterRoleBinding-dashboard.yaml 
kubectl apply -f secret-longLifeBearer-token-dashboard.yaml

echo ${dashbord-url} > dashbord-url.log
echo "pour acceder au desktop ${dashboad-url}"
echo "cette url est stockée dans le fichier dashboard-url.log"
echo "pour vous connecter et recuperer le token de connexion tapez la commande : kubectl get secret admin-user -n kubernetes-dashboard -o jsonpath={".data.token"} | base64 -d"


echo "-------------------------------------------------"
echo "creation d"