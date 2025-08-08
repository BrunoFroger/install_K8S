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
    commande=$(whiptail --menu "choissez l'action que vous voulez réaliser : " 15 80 6 \
        "Install" "installer Kubernetes" \
        "Applications" "installer applications" \
        "Reset" "reset kubadm (avant de faire un join si deja associé)" \
        "Join" "get join commande pour node" \
        "Worker" "set node worker" \
        "Quitter" "" \
        3>&1 1>&2 2>&3)

    echo $commande
    if [[ "X-$commande" != "X-" ]]; then
        if [[ "$commande" == "Quitter" ]]; then
            break;
        elif [[ "$commande" == "Applications" ]]; then
            titre="install applications"
            message="Voulez vous installer/desinstaller des applications dans le cluster Kubernetes ?"
            execute_commande "$titre" "$message"
            if [ $? -eq 0 ]; then
                . ./19-install-applications.bash
            fi
        elif [[ "$commande" == "Worker" ]]; then
            titre="set Worker"
            message="Voulez vous configurer les noeuds slave en worker ?"
            execute_commande "$titre" "$message"
            if [ $? -eq 0 ]; then
                . ./76-set-all-slaves-worker.bash
                whiptail --msgbox --title "info" "Tous les esclaves sont workers" 10 50
            fi
        elif [[ "$commande" == "Join" ]]; then
            titre="set Worker"
            message="Voulez vous générer la commande join ?"
            execute_commande "$titre" "$message"
            if [ $? -eq 0 ]; then
                commande=$(. ./75-get-join-commande)
                whiptail --msgbox --title "commande join" "$commande" 10 50
            fi
        else
            whiptail --msgbox --title "erreur" "commande <$commande> pas implementée" 10 50
        fi
    else
        whiptail --msgbox--title "erreur" "saisie incorrecte !" 10 50
    fi
done