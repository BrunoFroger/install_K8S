#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       install ingress-nginx-controller"
echo "*"
echo "*************************************************"


echo "-----------------------------"
echo "       a developper"
echo "-----------------------------"

echo "creation du namespace ingress-nginx, si necessaire"
if [[ $(kubectl get namespaces 2> /dev/null | grep ingress-nginx | wc -l) == 0 ]]; then
    echo "creation du namespace en cours ....."
    kubectl create namespace ingress-nginx
fi
change-namespace.bash ingress-nginx

echo "essai installation de ingress-controller"
if [[ $(kubectl get deployements.app 2> /dev/null | grep -v NAME | grep ingress-nginx-controller | wc -l) == 0 ]]; then
    # installation ingress controleur
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.2/deploy/static/provider/cloud/deploy.yaml
    # attendre fin d'install (running)
    #  TODO
    # commande de modification du fichier yaml de service pour ajouter externalIP: $externalIP
    # kubectl -n ingress-nginx patch svc ingress-nginx-controller --type=json \
    #     -p='[{"op": "add", "path": "/spec/-", "value": "externalIPs: 192.168.1.25"}]'
    # kubectl get svc ingress-nginx-controller -o yaml | sed -s 
    kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=120s
    externalIp=$(ifconfig eno1 | grep "inet "| awk '{ print $2 }')
    echo "l'adresse IP externe utilisée est : $externalIp"
    kubectl get services ingress-nginx-controller -o yaml > k8sbfr-service-ingress-nginx-controller.yaml
    awk '/type: LoadBalancer/ { print ""; next} {print} k8sbfr-service-ingress-nginx-controller.yaml > k8sbfr-service-ingress-nginx-controller1.yaml
    awk -v extIp=$externalIp '/spec:/ { print; print "  externalIPs:"; print  "    - " extIp; next }1' k8sbfr-service-ingress-nginx-controller1.yaml | kubectl apply -f -
    rm k8sbfr-service-ingress-nginx-controller*.yaml
    echo "installation de ingress-nginx-controleur ok"
else
    echo "lingress-nginx-controleur est deja deployé"
fi
