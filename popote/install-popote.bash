#!/bin/bash

# test si les images docker popote existent
while :
do
    imagesPopote=$(docker images | grep "fbruno/popote" | wc -l)
    if [[ $imagesPopote == 0 ]]; then
        echo "Les images popote n'existent pas, il faut les creer !"
        mkdir popote_files
        cd popote_files
        wget https://github.com/BrunoFroger/popote_vueJS_K8S/releases/latest > wget.log 2>&1 
        #rm latest
        archive="$(cat wget.log | grep release | tail -1 | awk -F' ' '{print $NF}')"
        #echo "archive = $archive"
        version=$(echo $archive | awk -F'/' '{print $NF}')
        #echo "version = $version"
        zipFile=$(echo "$archive.zip" | sed 's/releases/archive/g' | sed 's/tag/tags/g')
        #echo "zipFile = $zipFile"
        rm wget.log
        fichier="$(echo $zipFile | awk -F'/' '{print $NF}')"
        #echo "fichier = $fichier"
        wget $zipFile
        unzip $fichier
        rm $fichier
        cd popote_vueJS_K8S-tags-$version
        echo "construction des images docker popote en cours ....."
        docker compose build


#TODO

        cd ..
        rm -rf popote_files
    else    
        echo "les images docker de popote existent"
        break;
    fi
done

# push images sur DockerHub
echo "conexion au docker hub "
echo "saisissez le mot de passe : "
docker login -u fbruno

for image in "mariadb" "nginx" "backend" "frontend"
do
    # test si l'image existe sur DockerHub
    if [[ $(docker search popote | grep ${image} | wc -l) == 0 ]]; then
        echo "push de l'image ${image} sur DockerHub"
        # push images in DockerHub repository
        docker image tag popote_vuejs_k8s-tags-10-${image}:latest fbruno/popote_vuejs_k8s-tags-10-${image}:latest
        docker image push fbruno/popote_vuejs_k8s-tags-10-${image}:latest
    else 
        echo "l'image ${image} existe deja sur DokerHub"
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
#TODO tester si deployment deja operation, si oui, le supprimer avant de le relancer
pwd
kubectl apply -f deployment-monopod.yaml

