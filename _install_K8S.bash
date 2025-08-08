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

execute_commande () {
    return $(whiptail --yesno --title "$1" "$2" 10 50 3>&1 1>&2 2>&3)
}

while :
do
    commande=$(whiptail --menu "choissez l'action que vous voulez réaliser : " 15 60 6 \
        "Install" "installer Kubernetes" \
        "Applications" "installer applications" \
        "Reset" "reset kubadm" \
        "Join" "get join commande pour node" \
        "Worker" "set node worker" \
        "Quitter" "" \
        3>&1 1>&2 2>&3)

    echo $commande
    if [[ "X-$commande" != "X-" ]]; then
        if [[ "$commande" == "Quitter" ]]; then
            break;
        elif [[ "$commande" == "Install" ]]; then
            titre="install kubernetes"
            message="Voulez vous installer Kubernetes ?"
            # TODO
        elif [[ "$commande" == "Worker" ]]; then
            titre="set Worker"
            message="Voulez vous configurer les noeuds slave en worker ?"
            execute_commande "$titre" "$message"
            if [ $? -eq 1 ]; then
                . ./76-set-all-slaves-worker.bash
            fi
        else
            whiptail --msgbox --title "erreur" "commande inconnue" 10 50
        fi
    else
        whiptail --msgbox--title "erreur" "saisie incorrecte !" 10 50
    fi
done