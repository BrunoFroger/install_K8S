#!/bin/bash

if [ ! -d "${HOME}/bin" ];then
    echo "Création du repertoire local ~/bin ";
    mkdir ${HOME}/bin
fi

listeFichiers=$(ls *bash | grep -v cree-liens)

for fichier in $listeFichiers
do
    # echo "check de $fichier"
    if [ -f ${HOME}/bin/${fichier} ]; then
        rm ${HOME}/bin/${fichier}
    fi
    ln -s ${PWD}/${fichier} ${HOME}/bin/${fichier}
done