#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       installation de l'application"
echo "*                 popote"
echo "*"
echo "*************************************************"


echo "creation du namespace popote, si necessaire"
cd popote
if [[ $(kubectl get namespaces 2> /dev/null | grep popote | wc -l) == 0 ]]; then
    echo "creation du namespace en cours ....."
    kubectl create namespace popote
fi

echo "changement de namespace vers popote"
kubectl config set-context --current --namespace=popote


echo "-----------------------------"
echo "       a developper"
echo "-----------------------------"


echo "essai installation de popote"
if [[ $(kubectl get deployments.apps 2> /dev/null | grep -v NAME | grep deployment-monopod | wc -l) == 0 ]]; then
    kubectl apply -f deployment-monopod.yaml
    kubectl expose deployment deployment-popote-monopod --type=LoadBalancer

echo "installation de l'application popote"
read

source set-bash-variable.bash K8S_POPOTE_INSTALLED="OK"
