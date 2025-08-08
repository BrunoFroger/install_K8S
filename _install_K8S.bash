#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       installation Kubernetes"
echo "*         et ses applications"
echo "*"
echo "*************************************************"


echo "Test installation de Wiptail necessaire (interface graphique pour bash)"
testWhiptail=$(whiptail -v | cut -d " " -f 2)
if [[ "X-$testWhiptail" != "X-(newt):" ]]; then 
    sudo apt install -y whiptail
fi

commande=$(whiptail --menu "choissez l'action que vous voulez réaliser : " 15 60 6 \
    "Install" "installer Kubernetes" \
    "Applications" "installer applications" \
    "Reset" "reset kubadm" \
    "Join" "get join commande pour node" \
    "Worker" "set node worker" \
    "Quitter" "" \
    3>&1 1>&2 2>&3)

while :
do
    echo $commande
    if [[ "X-$commande" != "X-" ]]; then
        if [[ "$commande" == "Quitter" ]]; then
            break;
        elif [[ "$commande" == "Worker" ]]; then
            . ./76-set-all-slaves-worker.bash
        fi
    else
        echo "saisie incorrecte !"
    fi
done