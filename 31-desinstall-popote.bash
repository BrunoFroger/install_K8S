#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       desinstallation de l'application"
echo "*                 popote"
echo "*"
echo "*************************************************"

if (whiptail --title "Confirmation Oui / Non" --yesno "voulez vous réellement desinstaller popote ?" 10 60) then

    echo "-----------------------------"
    echo "       a developper"
    echo "-----------------------------"

    change-namespace.bash default
    unset K8S_POPOTE_INSTALLED
    echo "popote desinstallé"
fi
