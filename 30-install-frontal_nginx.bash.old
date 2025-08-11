#!/bin/bash -e


echo "*************************************************"
echo "*"
echo "*       installation de nginx ...."
echo "*"
echo "*************************************************"

if [[ "X-$K8S_FRONTAL_NGINX_INSTALLED" == "X-OK" ]]; then
  echo "installation nginx déjà réalisée"
else 
  cd k8sbfr-nginx
  kubectl apply -f nginx-configmap.yaml
  kubectl apply -f nginx-deployment.yaml
  kubectl apply -f nginx-service.yaml

  echo "-------------------------------------------------"
  source set-bash-variable.bash K8S_FRONTAL_NGINX_INSTALLED="OK"
  echo "installation de nginx => fin"
  cd ..
fi