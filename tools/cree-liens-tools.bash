#!/bin/bash

if [ ! -d "${HOME}/bin" ];then
    echo "Création du repertoire local ~/bin ";
    mkdir ${HOME}/bin
fi

listeFichiers=$(ls *bash | grep -v cree-liens)

for fichier in $listeFichiers
do
    echo "check de $fichier"
    if [ ! -f ${HOME}/bin/${fichier} ]; then
        echo "creation du lien pour ${fichier} vers ${HOME}/bin/${fichier}"
        ln -s ${fichier} ${HOME}/bin/${fichier}
    fi
done