#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       installation de l'application"
echo "*                 Kubernetes Web View"
echo "*"
echo "*************************************************"

status="KO"

echo "essai installation de kube-web-view"

change-namespace.bash default
mkdir kube-web-view
cd kube-web-view
if [[ $(kubectl get pods 2> /dev/null | grep -v NAME | grep kube-web-view | wc -l) == 0 ]]; then
    if [ ! -d "kube-web-view" ]; then
        git clone https://codeberg.org/hjacobs/kube-web-view
    fi
    kubectl apply -k kube-web-view/deploy

    echo "installation de l'application kube-web-view ok"
    status="OK"
else
    echo "l'application kube-web-view est deja deployée"
fi
cd ..

source set-bash-variable.bash K8S_KUBEWEBVIEW_INSTALLED="${status}"