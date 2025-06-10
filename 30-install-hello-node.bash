#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       installation de l'application"
echo "*                 hello-node"
echo "*"
echo "*************************************************"

echo "creation du namespace k8sbfr-hello-node, si necessaire"
cd k8sbfr-hello-node
if [[ $(kubectl get namespaces 2> /dev/null | grep k8sbfr-hello-node | wc -l) == 0 ]]; then
    kubectl create namespace k8sbfr-hello-node
fi
echo "changement de namespace vers k8sbfr-hello-node"
kubectl config set-context --current --namespace=k8sbfr-hello-node

echo "essai installation de hello-node"
if [[ $(kubectl get deployments.apps 2> /dev/null | grep -v NAME | grep k8sbfr-hello-node | wc -l) == 0 ]]; then
    echo "creation du deployement k8sbfr-hello-node, veuillez patienter ....."
    kubectl create deployment k8sbfr-hello-node --image=registry.k8s.io/e2e-test-images/agnhost:2.39 -- /agnhost netexec --http-port=8080
            # - verifier sa creation avec : kubectl get deployments
    echo "attendre fin installation deployement hello-node"
    kubectl wait --for=condition=Available deployment/k8sbfr-hello-node --timeout=120s

    echo "creation du service, veuillez patienter ....."
    kubectl apply -f svc-hello-node.yaml
        # - test local :
        #     - recuperer adresse ip de l'application avec "kubectl describe svc k8sbfr-hello-node"
        #     - adresse ip dans le champ EndPoints: sous forme ip:port
        #     - lancer un browser web avec cette adresse ip:port
        #     - le resultat doit donner date et heure
    echo "installation de l'application hello-node ok"
else
    echo "l'application hello-node est deja deployé"
fi
read
cd ..

source set-bash-variable.bash K8S_HELLO_NODE_INSTALLED="OK"