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
    commande=$(whiptail --menu "choissez l'action que vous voulez réaliser : " 15 80 7 \
        "Install" "installer Kubernetes" \
        "Tools" "installer les add-on" \
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
            titre="installation d'applications"
            message="Voulez vous installer/desinstaller des applications dans le cluster Kubernetes ?"
            execute_commande "$titre" "$message"
            if [ $? -eq 0 ]; then
                . ./19-install-applications.bash
            fi
        elif [[ "$commande" == "Tools" ]]; then
            titre="installation des Add-on"
            message="Voulez vous installer/desinstaller des add-on dans le cluster Kubernetes ?"
            execute_commande "$titre" "$message"
            if [ $? -eq 0 ]; then
                . ./19-install-add-on.bash
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
            titre="join slave => master"
            message="Voulez vous générer la commande join ?"
            execute_commande "$titre" "$message"
            if [ $? -eq 0 ]; then
                commande=$(. ./75-get-join-commande.bash)
                whiptail --msgbox --title "commande join" "$commande" 16 80
            fi
        elif [[ "$commande" == "Reset" ]]; then
            titre="Reset kubadm"
            message="A T T E N T I O N \nCeci va desactiver kubeadm, si vous etes sur master, cela rendra indisponible le cluster, sur un esclave, cela le desolidarisera du cluster (utile pour joinde un nouveau cluster)"
            execute_commande "$titre" "$message"
            if [ $? -eq 0 ]; then
                echo "TODO lancer kubeadm reset"
                # TODO verifier si pas sur master 
                # commande=$(. ./98-reset-kubeadm.bash)
                # whiptail --msgbox --title "info" "kubeadm est desactivé sur le noeud $noeud " 10 50
            fi
        else
            whiptail --msgbox --title "erreur" "commande <$commande> pas implementée" 10 50
        fi
    else
        whiptail --msgbox--title "erreur" "saisie incorrecte !" 10 50
    fi
done