#!/bin/bash -e

function aide(){
    echo "syntaxe :"
    echo "$0 <variable=valeur>"
    exit -1
}

if [[ ${#} ne 1 ]]; then
    echo "ERREUR : mauvais nombre de parametres"
    aide
fi

if [[ "x-$1" == "X-" ]]; then
    echo "ERREUR : manque parametre !"
    aide
fi

variable=$(echo $1 | cut -d'=' -f 1)
valeur=$(echo $1 | cut -d'=' -f 2)

echo "variable = $variable"
echo "valeur   = $valeur"
