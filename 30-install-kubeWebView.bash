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
if [ ! -d "k8s-kube-web-view" ]; then
    mkdir k8s-kube-web-view
fi
cd k8s-kube-web-view
if [[ $(kubectl get pods 2> /dev/null | grep -v NAME | grep kube-web-view | wc -l) == 0 ]]; then
    if [ ! -d "kube-web-view" ]; then
        git clone https://codeberg.org/hjacobs/kube-web-view
    fi
    kubectl apply -k kube-web-view/deploy

    KUBE-WEB-VIEW-IP=$(kubectl describe svc kube-web-view | grep "IPs:" | awk '{ print $2 }')

    echo "installation de l'application kube-web-view ok"
    echo "vous pouvez acceder a l'interface Web avec l'adresse http://${KUBE-WEB-VIEW-IP}"
    echo "#!/bin/bash \
            firefox ${KUBE-WEB-VIEW-IP} &" > launch_kubewebview.bash
    chmod +x launch_kubewebview.bash
    status="OK"
else
    echo "l'application kube-web-view est deja deployée"
fi
cd ..

source set-bash-variable.bash K8S_KUBEWEBVIEW_INSTALLED="${status}"
