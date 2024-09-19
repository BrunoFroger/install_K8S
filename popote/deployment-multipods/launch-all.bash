#!/bin/bash


echo "*************************************"
echo "*                                   *"
echo "*      lancement des pods           *"
echo "*       individuellement            *"
echo "*                                   *"
echo "*************************************"

if [[ $# -eq 0 ]]; then
    echo "manque identification du tag"
    exit -1
fi
TAG=$1

echo "suppression des pods existant : "
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
sed "s^{{IMAGE}}^fbruno/popote_vuejs_k8s-tags-${TAG}-${module}:latest^" deployment-${module}-copy.yaml > deployment-${module}.yaml
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
sed "s^{{IMAGE}}^fbruno/popote_vuejs_k8s-tags-${TAG}-${module}:latest^" deployment-${module}-copy.yaml > deployment-${module}.yaml
echo "lancement de ${module}"
POD_MARIADB=$(kubectl get pods | grep mariadb | head -1 | awk -F ' ' '{print $1}') ; echo "pod mariadb = $POD_MARIADB"
IP_MARIADB=$(kubectl describe pods $POD_MARIADB | egrep "^IP:" | tail -1 | awk -F ' ' '{print $NF}'); echo "IP mariadb = $IP_MARIADB"
sed -i "s/{{IP_MARIADB}}/${IP_MARIADB}/" deployment-${module}.yaml
kubectl apply -f deployment-${module}.yaml
sleep 5
podId=$(kubectl get pods | grep ${module} | awk -F ' ' '{print $1}')
echo "podId de $module = $podId"
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

echo "====================================="
module="frontend"
sed "s^{{IMAGE}}^fbruno/popote_vuejs_k8s-tags-${TAG}-${module}:latest^" deployment-${module}-copy.yaml > deployment-${module}.yaml
echo "lancement de ${module}"
POD_BACKEND=$(kubectl get pods | grep backend | head -1 | awk -F ' ' '{print $1}') ; echo "pod mariadb = $POD_BACKEND"
IP_BACKEND=$(kubectl describe pods $POD_BACKEND | egrep "^IP:" | tail -1 | awk -F ' ' '{print $NF}'); echo "IP mariadb = $IP_BACKEND"
sed -i "s/{{IP_MARIADB}}/${IP_BACKEND}/" deployment-${module}.yaml
kubectl apply -f deployment-${module}.yaml
sleep 5
podId=$(kubectl get pods | grep ${module} | awk -F ' ' '{print $1}')
echo "podId de $module = $podId"
cpt=0
while :
do
    # definir dans la ligne ci dessous les condiftion de fin d'initialisation
    result=$(kubectl logs ${podId} | grep "webpack" | grep "compiled successfully" | wc -l ) 
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
module="nginx"
sed "s^{{IMAGE}}^fbruno/popote_vuejs_k8s-tags-${TAG}-${module}:latest^" deployment-${module}-copy.yaml > deployment-${module}.yaml
echo "lancement de ${module}"
POD_FRONTEND=$(kubectl get pods | grep backend | head -1 | awk -F ' ' '{print $1}') ; echo "pod mariadb = $POD_FRONTEND"
IP_FRONTEND=$(kubectl describe pods $POD_FRONTEND | egrep "^IP:" | tail -1 | awk -F ' ' '{print $NF}'); echo "IP mariadb = $IP_FRONTEND"
sed -i "s/{{IP_MARIADB}}/${IP_FRONTEND}/" deployment-${module}.yaml
kubectl apply -f deployment-${module}.yaml
sleep 5
podId=$(kubectl get pods | grep ${module} | awk -F ' ' '{print $1}')
echo "podId de $module = $podId"
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

