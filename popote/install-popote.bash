#!/bin/bash -e

# installation de kubectl-convert si necessaire)
# testConvert=$(whereis kubectl-convert | grep /usr/local/bin | wc -l)
# if [[ $testConvert == 0 ]]; then 
#     echo "installation de kubectl-convert"
#     # 1 Download the latest release with the command:
#     curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl-convert"
#     # 2 Validate the binary (optional)
#     curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl-convert.sha256"
#     echo "$(cat kubectl-convert.sha256) kubectl-convert" | sha256sum --check
#     #Validate the kubectl-convert binary against the checksum file: (reponse attendue => kubectl-convert: Réussi)
#     echo "$(cat kubectl-convert.sha256) kubectl-convert" | sha256sum --check
#     #l'executable est dans le chemin courant ; vous pouvez eventuellement le deplacer vers ver /usr/local/bin pour qu'il soit utilisable partout
#     sudo mv kubectl-convert /usr/local/bin/
# else
#     echo "kubectl-convert deja installé"
# fi

# test si les images docker popote existent
while :
do
    images-popote=$(docker images | grep popote | wc -l)
    if [[ images-popote == 0 ]]; then
        echo "Les images popote n'existent pas, il faut les creer !"
        mkdir popote
        cd popote
        wget https://github.com/BrunoFroger/popote_vueJS_K8S/releases/latest > wget.log 2>&1 
        rm latest
        archive="$(cat wget.log | grep release | tail -1 | awk -F' ' '{print $NF}')"
        echo "version = $version"
        zipFile=$(echo "$archive.zip" | sed 's/releases/archive/g' | sed 's/tag/tags/g')
        echo "zipFile = $zipFile"
        rm wget.log
        fichier="$(echo $zipFile | awk -F'/' '{print $NF}')"
        rm $fichier
        wget $zipFile
        echo "fichier = $fichier"
        unzip $fichier
        rm $fichier
        cd popote_vueJS_K8S
        docker compose build
    else    
        echo "les images docker de popote existent déjà"
        break;
    fi
done


#creation du namespace popote si necessaire
testPopote=$(kubectl get namespaces | grep popote | wc -l)
if [[ $testPopote == 0 ]]; then 
    echo "création du namespace popote"
    kubectl create namespace popote
else
    echo "namespace popote existe deja"
fi

# deployment du pod multicontaineur de popote
kubectl apply -f deployment-monopod.yaml

