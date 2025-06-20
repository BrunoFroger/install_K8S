#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       installation de l'application"
echo "*                 etherpad"
echo "*"
echo "*************************************************"

status="KO"

echo "creation du namespace k8sbfr-etherpad, si necessaire"
cd k8sbfr-etherpad
if [[ $(kubectl get namespaces 2> /dev/null | grep k8sbfr-etherpad | wc -l) == 0 ]]; then
    echo "creation du namespace en cours ....."
    kubectl create namespace k8sbfr-etherpad
fi

echo "changement de namespace vers k8sbfr-etherpad"
kubectl config set-context --current --namespace=k8sbfr-etherpad

echo "essai installation de etherpad"
if [[ $(kubectl get pods 2> /dev/null | grep -v NAME | grep etherpad | wc -l) == 0 ]]; then
    docker pull etherpad/etherpad
    echo "creation du deployement etherpad, veuillez patienter ....."
    kubectl apply -f etherpadDeployment.yaml
    kubectl wait --for=condition=Available pod/etherpad --timeout=120s

    echo "creation du configMap, veuillez patienter ....."
    kubectl apply -f etherpadconfigMap.yaml

    echo "creation du service, veuillez patienter ....."
    kubectl apply -f etherpadServiceClusterIP.yaml

    echo "creation de l'ingress, veuillez patienter ....."
    kubectl apply -f etherpadIngress.yaml

    echo "installation de l'application etherpad ok"
    status="OK"
else
    echo "l'application etherpad est deja deployée"
fi
cd ..

source set-bash-variable.bash K8S_HELLO_NODE_INSTALLED="${status}"