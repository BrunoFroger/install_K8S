#!/bin/bash


echo "*************************************"
echo "*                                   *"
echo "*      lancement des pods           *"
echo "*       individuellement            *"
echo "*                                   *"
echo "*************************************"

echo -n "suppression des pods existant : "
kubectl delete deployments.apps deployment-backend deployment-mariadb deployment-frontend deployment-nginx
while :
do
    if [[ $(kubectl get pods | wc -l ) -le 1 ]]; then
        echo ""
        break;
    fi
    echo -n "."
    sleep 2    
done
echo " => done"

echo "====================================="
module="mariadb"
echo "lancement de ${module}"
kubectl apply -f deployment-${module}.yaml
sleep 5
podId=$(kubectl get pods | grep ${module} | awk -F ' ' '{print $1}')
cpt=0
while :
do
    # definir dans la ligne ci dessous les condiftion de fin d'initialisation
    result=$(kubectl logs ${podId} | tail -2 | head -1 | grep "ready for connections" | wc -l ) 
    if [[ "X-${result}" == "X-1" ]]; then 
        break
    else
        echo -n "."
    fi
    sleep 2
    ((cpt++))
    if [[ ${cpt} -gt 30 ]]; then
        echo "delai pour demarrer ${module} dépassé"
        exit -1
    fi
done
echo ""
echo "${module} démarré avec succès"
echo "====================================="

echo "====================================="
module="backend"
echo "lancement de ${module}"
cp deployment-${module}-copy.yaml deployment-${module}.yaml
POD_MARIADB=$(kubectl get pods | grep mariadb | head -1 | awk -F ' ' '{print $1}') ; echo $POD_MARIADB
IP_MARIADB=$(kubectl describe pods $POD_MARIADB | egrep "^IP:" | tail -1 | awk -F ' ' '{print $NF}'); echo $IP_MARIADB
sed -i "s/{{IP_MARIADB}}/${IP_MARIADB}/" deployment-${module}.yaml
kubectl apply -f deployment-${module}.yaml
sleep 5
podId=$(kubectl get pods | grep ${module} | awk -F ' ' '{print $1}')
cpt=0
while :
do
    # definir dans la ligne ci dessous les condiftion de fin d'initialisation
    result=$(kubectl logs ${podId} | grep "Connecté à la base de données MySQL Popote !" | wc -l ) 
    if [[ "X-${result}" == "X-1" ]]; then 
        break
    else
        echo -n "."
    fi
    sleep 2
    ((cpt++))
    if [[ ${cpt} -gt 30 ]]; then
        echo "delai pour demarrer ${module} dépassé"
        exit -1
    fi
done
echo ""
echo "${module} démarré avec succès"
echo "====================================="

