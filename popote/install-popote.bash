#!/bin/bash -e

# installation de kubectl-convert a decommenter si necessaire)
# 1 Download the latest release with the command:
#curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl-convert"
# 2 Validate the binary (optional)
#curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl-convert.sha256"
#echo "$(cat kubectl-convert.sha256) kubectl-convert" | sha256sum --check
#Validate the kubectl-convert binary against the checksum file: (reponse attendue => kubectl-convert: Réussi)
#echo "$(cat kubectl-convert.sha256) kubectl-convert" | sha256sum --check
#l'executable est dans le chemin courant ; vous pouvez eventuellement le deplacer vers ver /usr/local/bin pour qu'il soit utilisable partout
#sudo mv kubectl-convert /usr/local/bin/

#creation du namespace popote si necessaire
testPopote=$(kubectl get namespaces | grep popote | wc -l)
if [[ $testpopote == 0 ]]; then 
    echo "création du namespace popote"
    kubectl create namespace popote
else
    echo "namespace popote existe deja"
fi

# deployment du pod multicontaineur de popote
#kubectl create deployment deployment-monopod.yaml -n popote

