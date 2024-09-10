#!/bin/bash


echo "*************************************"
echo "*                                   *"
echo "*      lancement des pods           *"
echo "*       individuellement            *"
echo "*                                   *"
echo "*************************************"

kubectl delete deployments.apps deployment-backend deployment-mariadb deployment-frontend deployment-nginx

echo "====================================="
echo "lancement de mariadb"
kubectl apply -f deployment-mariadb.yaml
sleep 5
podId=$(kubectl get pods | grep mariadb | awk -F ' ' '{print $1}')
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
    if [[ ${cpt} -gt 2 ]]; then
        echo "delai pour demarrer dépassé"
        exit -1
    fi
done
echo ""
echo "mariadb démarré avec succès"
echo "====================================="
