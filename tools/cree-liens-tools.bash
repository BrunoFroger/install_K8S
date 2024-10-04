#!/bin/bash

# test si le repertoire bin du user existe
if [ ! -d "${HOME}/bin" ];then
    echo "Création du repertoire local ~/bin ";
    mkdir ${HOME}/bin
fi

# ajout si necessaire du repertoire bin dans le path
if [ $(echo $PATH | sed "s/:/\n/g" | grep ${HOME}/bin | wc -l) -eq 0 ]; then
    echo "vous devez ajouter ${HOME}/bin au PATH de votre "
    echo "et relancer ce script"
    exit
fi

cptFichiers=0
cptUpdates=0
listeFichiers=$(ls *bash | grep -v cree-liens | tr '\n' ' ')
for fichier in $listeFichiers
do
    # echo "check de $fichier"
    ((cptFichiers++))
    if [ -f ${HOME}/bin/${fichier} ]; then
        rm ${HOME}/bin/${fichier}
        ((cptUpdates++))
    fi
    ln -s ${PWD}/${fichier} ${HOME}/bin/${fichier}
done
echo "$((${cptFichiers}-${cptUpdates})) nouveaux fichiers"