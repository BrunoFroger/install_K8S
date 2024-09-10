#!/bin/bash


echo "*************************************"
echo "*                                   *"
echo "*      lancement des pods           *"
echo "*       individuellement            *"
echo "*                                   *"
echo "*************************************"

kubectl delete deployments.apps deployment-backend deployment-mariadb deployment-frontend deployment-nginx

echo "====================================="
module="mariadb"
echo "lancement de ${module}"
kubectl apply -f deployment-${module}.yaml
sleep 5
podId=$(kubectl get pods | grep ${module} | awk -F ' ' '{print $1}')
cpt=0
while :
do
    result=$(kubectl logs ${podId} | tail -2 | head -1 | grep "ready for connections" | wc -l ) 
    if [[ "X-${result}" == "X-1" ]]; then 
        break
    else
        echo -n "."
    fi
    sleep 5
    ((cpt++))
    if [[ ${cpt} -gt 10 ]]; then
        echo "delai pour demarrer dépassé"
        exit -1
    fi
done
echo ""
echo "${module} démarré avec succès"
echo "====================================="


echo "====================================="
module="backend"
echo "lancement de ${module}"
kubectl apply -f deployment-${module}.yaml
sleep 5
podId=$(kubectl get pods | grep ${module} | awk -F ' ' '{print $1}')
cpt=0
while :
do
    result=$(kubectl logs ${podId} | tail -2 | head -1 | grep "TODO : a definir" | wc -l ) 
    if [[ "X-${result}" == "X-1" ]]; then 
        break
    else
        echo -n "."
    fi
    sleep 5
    ((cpt++))
    if [[ ${cpt} -gt 10 ]]; then
        echo "delai pour demarrer dépassé"
        exit -1
    fi
done
echo ""
echo "mariadb démarré avec succès"
echo "====================================="