#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       install ingress-nginx-controller"
echo "*"
echo "*************************************************"


echo "-----------------------------"
echo "       a developper"
echo "-----------------------------"

cd k8sbfr-my-ingress

echo "creation du namespace ingress-nginx, si necessaire"
if [[ $(kubectl get namespaces 2> /dev/null | grep ingress-nginx | wc -l) == 0 ]]; then
    echo "creation du namespace en cours ....."
    kubectl create namespace ingress-nginx
fi

echo "essai installation de ingress-controller"
if [[ $(kubectl get deployements.app 2> /dev/null | grep -v NAME | grep ingress-nginx-controller | wc -l) == 0 ]]; then
    # installation ingress controleur
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.2/deploy/static/provider/cloud/deploy.yaml
    # attendre fin d'install (running)
    kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=120s
    echo "installation de ingress-nginx-controleur ok"
else
    echo "lingress-nginx-controleur est deja deployé"
fi
echo "Appuyez sur enter pour continuer"
read

cd ..