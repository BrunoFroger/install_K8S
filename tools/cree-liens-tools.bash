#!/bin/bash

if [ ! -d "${HOME}/bin" ];then
    echo "Création du repertoire local ~/bin ";
    mkdir ${HOME}/bin
fi

listeFichiers=$(ls *bash | grep -v cree-liens)

for fichier in $listeFichiers
do
    echo "traitement de $fichier"
    if [ ! -f ${HOME}/bin/$fichier ]; then
        ln -s $fichier ${HOME}/bin/
    fi
done