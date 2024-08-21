#!/bin/bash -e

function aide() {
    echo "syntaxe :"
    echo "$0 <repertoire du fichier d'init kubeadm>"
}

master=$(hostname)
filename="kubeadm-init.out.log"

echo "cette commande (executée sur le master) génère la ligne de commande a utiliser sur un noeud pour joindre une machine au cluser de ce master"
echo "la commande générée doit etre executée sur le noeud a inclure dans le cluster"

if [[ "x-$1" == "x-" ]]; then
    echo "erreur : manque parametre indiquant le repertoire sur le master vers le fichier $filename"
    aide
    exit -1
else
    filedir=$1
fi

filename=${filedir}/${filename}

token=$(kubeadm token create)
#echo "le nouveau token est : $token"

#echo "vous etes sur la machine : $master"
#echo "le répertoire sur master contenant le fichier spécifiant la commande est : $filedir" 
cd $filedir
commande=$(tail -2 $filename) 
debut=$(echo $commande | cut -d' ' -f -4 )
fin=$(echo $commande | cut -d' ' -f 7- )
option="--cri-socket=unix:///var/run/cri-dockerd.sock"

#echo "debut = $debut"
#echo "fin   = $fin"

cde="$debut $token $fin $option"

echo "voici la commande a saisir pour joindre le cluster : "
echo $cde