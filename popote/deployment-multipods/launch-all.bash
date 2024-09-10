#!/bin/bash


echo "*************************************"
echo "*                                   *"
echo "*      lancement des pods           *"
echo "*       individuellement            *"
echo "*                                   *"
echo "*************************************"


echo "====================================="
echo "lancement de mariadb"
kubectl apply -f deployment-mariadb.yaml
podId=$(kubectl get pods | grep mariadb | awk -F ' ' '{print $1}')
while :
do
    result=$(kubectl logs ${podId} | tail -2 | head -1 | grep "ready for connections" | wc -l)
    if [[ result == 1 ]]; then 
        break
    else
        echo ".\c"
    fi
    sleep 5
done
echo "mariadb démarré avec succès
echo "====================================="
