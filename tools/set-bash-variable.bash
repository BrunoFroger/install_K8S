#!/bin/bash -e

function aide(){
    echo "syntaxe :"
    echo "$(basename $0) <variable=valeur>"
    exit -1
}

touch ~/.bashrc

if [[ ${#} -ne 1 ]]; then
    echo "ERREUR : mauvais nombre de parametres"
    aide
fi

if [[ "x-$1" == "X-" ]]; then
    echo "ERREUR : manque parametre !"
    aide
fi

variable=$(echo $1 | cut -d'=' -f 1)
valeur=$(echo $1 | cut -d'=' -f 2)

#echo "variable = $variable"
#echo "valeur   = $valeur"

testExist=$(env | grep $variable)

if [[ "X-$testExist" == "X-" ]]; then
    echo "la variable n'existe pas on la crée"
    export $variable=$valeur
    echo "on ajoute la creation de la variable dans bashrc"
    exportBashExist=$(cat ~/.bashrc | grep $1 | wc -l)
    if [[ $exportBashExist == 0 ]]; then 
        echo "export $1" >> ~/.bashrc
    fi
else
    echo "la variable $variable existe deja"
    testValeur=$(env | grep $variable | cut -d'=' -f2)
    # on supprime et recree sa definition dans bashrc
    sed -i "/$variable/d" ~/.bashrc
    echo "export $1" >> ~/.bashrc
    echo "testValeur = $testValeur"
    export $1
fi