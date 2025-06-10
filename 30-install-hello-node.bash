#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       installation de l'application"
echo "*                 hello-node"
echo "*"
echo "*************************************************"

#creation du namespace k8sbfr-hello-node
cd k8sbfr-hello-node
kubectl create namespace k8sbfr-hello-node
kubectl config set-context --current --namespace=k8sbfr-hello-node

#creation du deployement k8sbfr-hello-node
kubectl create deployment k8sbfr-hello-node --image=registry.k8s.io/e2e-test-images/agnhost:2.39 -- /agnhost netexec --http-port=8080
        # - verifier sa creation avec : kubectl get deployments
kubectl wait --for=condition=Available deployment/k8sbfr-hello-node --timeout=120s

#exposer le service
kubectl apply -f svc-hello-node.yaml
    # - test local :
    #     - recuperer adresse ip de l'application avec "kubectl describe svc k8sbfr-hello-node"
    #     - adresse ip dans le champ EndPoints: sous forme ip:port
    #     - lancer un browser web avec cette adresse ip:port
    #     - le resultat doit donner date et heure
echo "installation de l'application hello-node ok"
read
cd ..


source set-bash-variable.bash K8S_HELLO_NODE_INSTALLED="OK"