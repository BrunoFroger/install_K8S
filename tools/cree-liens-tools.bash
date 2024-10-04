#!/bin/bash

# test si le repertoire bin du user existe
if [ ! -d "${HOME}/bin" ];then
    echo "Création du repertoire local ~/bin ";
    mkdir ${HOME}/bin
fi

# ajout si necessaire du repertoire bin dans le path
if [ $(echo $PATH | sed "s/:/\n/g" | grep ${HOME}/bin | wc -l) -eq 0 ]; then
    echo "vous devez ajouter ${HOME}/bin au PATH de votre "
    exit
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