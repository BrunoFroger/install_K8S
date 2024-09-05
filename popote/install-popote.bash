#!/bin/bash

# test si les images docker popote existent
if [[ "X-$1" == "X---build" ]]; then
    imagesPopote=0
    $1=""
    echo "On force la reconstruction des images popote"
else
    imagesPopote=$(docker images | grep "fbruno/popote" | wc -l)
fi
if [[ $imagesPopote == 0 ]]; then
    echo "Les images popote n'existent pas, il faut les creer !"
    mkdir popote_files
    rm -rf popote_files
    cd popote_files
    wget https://github.com/BrunoFroger/popote_vueJS_K8S/releases/latest > wget.log 2>&1 
    rm latest
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
    echo on efface les anciennes images popote locale
    while :
    do
        if [[ $(docker images | grep popote_vuejs_k8s-tags- | wc -l) > 0 ]]; then
            image=$(docker images | grep popote_vuejs_k8s-tags- | awk -F' ' '{print $1}')
            echo "on efface l'image $image"
            docker rmi $image
        else
            break;
        fi
    done
    cd popote_vueJS_K8S-tags-$version
    echo "construction des images docker popote en cours ....."
    docker compose build --no-cache

    cd ..   # on sort du repertoire popte_vueJS_K8S-tags-version
    echo "on efface le repertoire popote_files"
    cd ..   # on sort du repertoire popote_files
    rm -rf popote_files
else    
    echo "les images docker de popote existent"
    break;
fi

# push images sur DockerHub
if [[ $(docker info | grep Username | wc -l) == 0 ]]; then
    echo "login sur DockerHub : "
    read loginDocker
    echo "conexion au docker hub "
    echo "saisissez le mot de passe : "
    docker login -u ${loginDocker}
else
    loginDocker=$(docker info | grep Username | cut -d':' -f 2)
    echo "vous etes connecté sur dockerHub avec le login ${loginDocker}"
fi

for image in "mariadb" "nginx" "backend" "frontend"
do
    # test si l'image existe sur DockerHub
    if [[ $(docker search popote | grep ${image} | wc -l) == 0 ]]; then
        pushImage=$(docker images | grep $image | awk -F' ' '{print $1}')
        echo "push de l'image ${pushImage} sur DockerHub/${loginDocker}"
        # push images in DockerHub repository
        docker image tag ${pushImage}:latest ${loginDocker}/${pushImage}:latest
        docker image push ${loginDocker}/${pushImage}:latest
    else 
        echo "l'image ${pushImage} existe deja sur DokerHub"
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
if [[ $(kubectl get deployments.apps deployment-popote-monopod | wc -l) != 0 ]]; then
    echo "le deployment exste deja on le supprime"
    kubectl delete deployments.apps deployment-popote-monopod 
fi
echo "pwd = $(pwd)"
#creation du persistant volume pour mariadb
kubectl apply -f mariadb-pv.yaml
kubectl apply -f mariadb-pvc.yaml
kubectl apply -f mariadb-config.yaml

cp deployment-monopod-copy.yaml deployment-monopod.yaml
# modification du fichier deployment.yaml avec bon nom d'image
for image in "mariadb" "nginx" "backend" "frontend"
do
    # test si l'image existe sur DockerHub
    pullImage=$(docker search popote | grep ${image} | awk -F' ' '{print $1}')
    cible="IMAGE-$image"
    echo "remplacemnt de <$cible> par <$pullImage>"
    sed -i 's/${cible}/${pullImage}/g' deployment-monopod.yaml
done

kubectl apply -f deployment-monopod.yaml

