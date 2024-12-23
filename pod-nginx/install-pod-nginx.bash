#!/bin/bash -e

kubectl config set-context --current --namespace=ingress-nginx

# Installons le gestionnaire d’Ingress Nginx
#kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/baremetal/deploy.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml

# patchons le déploiement du contrôleur nginx 
kubectl patch deployment ingress-nginx-controller -n ingress-nginx -p '{"spec":{"template":{"spec":{"hostNetwork":true}}}}'

#kubectl apply -f ./nginx-deployment.yaml

# activation du port forward pour acceder a ce site
kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 8080:80
# kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 80:80

# test 
echo "test : doit afficher 'Itworks!'"
curl --resolve k8sbfr.zapto.org:8080:127.0.0.1 http://k8sbfr.zapto.org:8080
# curl --resolve k8sbfr.zapto.org:80:127.0.0.1 http://k8sbfr.zapto.org
echo ""