#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       installation des applications"
echo "*"
echo "*************************************************"


#liste_applications="hello popote etherpad"
liste_applications="hello popote kubeWebView"

echo "Test installation de Wiptail necessaire (interface graphique pour bash)"
testWhiptail=$(whiptail -v | cut -d " " -f 2)
if [[ "X-$testWhiptail" != "X-(newt):" ]]; then 
    sudo apt install -y whiptail
fi


while :
do
    nbApp=1
    whiptailContenu=""
    for application in $liste_applications 
    do
        applicationInstallee=$(env | grep INSTALLED | grep -i ${application} | cut -d "=" -f2)
        if [[ "X-$applicationInstallee" == "X-OK" ]]; then
            applicationInstallee='Installée'
        else
            applicationInstallee=''
        fi
        ((nbApp++))
        whiptailContenu=${whiptailContenu}'"'${application}'" "'${applicationInstallee}'" '
    done
    whiptailContenu=${whiptailContenu}'"Quitter" ""'
    texte1="choisissez quelle application vous"
    texte2="voulez installer/desinstaller :" 
    COLUMNS=$(tput cols) 
    decal=$(((${COLUMNS}-${#texte1})/2))
    echo "decal : $decal"
    decalage=$(printf "%*s" $decal)
    echo "taille texte1 : ${#texte1}"
    echo "COLUMNS : $COLUMNS"
    echo "decalage : <$decalage>"
    echo "taille decalage : ${#decalage}"
    message="$(printf"${decalage}${texte1}\n${decalage}${texte2}")"
    echo "message : $message"
    nomApplication=$(whiptail --menu "$message" 15 80 $nbApp ${whiptailContenu} 3>&1 1>&2 2>&3)
    nomApplication=$(echo $nomApplication | cut -d'"' -f2)

    if [[ "X-$nomApplication" != "X-" ]]; then
        if [[ "X-$nomApplication" == "X-Quitter" ]]; then
            break;
        else
            # echo "on traite l'application <$nomApplication>"
            applicationInstallee=$(env | grep INSTALLED | grep -i ${nomApplication} | cut -d "=" -f2)
            if [[ "X-$applicationInstallee" == "X-OK" ]]; then
                # echo "desinstallation de l'application ${nomApplication}"
                cde="./31-desinstall-${nomApplication}.bash"
            else
                # echo "installation de l'application ${nomApplication}"
                cde="./30-install-${nomApplication}.bash"
            fi
            echo "execution de la commande : <$cde>"
            source $cde
        fi
    else
        echo "aucune application selectionnée : $nomApplication"
    fi
    # read
done

echo "installation des applications => fin"

