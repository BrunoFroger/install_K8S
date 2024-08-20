#!/bin/bash -e

function aide() {
    echo "syntaxe :"
    echo "$0 <repertoire du fichier d'init kubeadm>"
}


echo "cette commande génère la ligne de commande a utiliser pour joindre une machine au cluser de ce master"

if [[ "x-$1" == "x-" ]]; then
    echo "erreur : manque parametre"
    aide
    exit -1
fi


echo "vous etes sur la machine : " $(hosname)
echo "le répertoire sur master contenant le fichier spécifiant la commande est : " 
cd $1