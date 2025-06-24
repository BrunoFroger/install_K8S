#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       installation des applications"
echo "*"
echo "*************************************************"

liste_applications="hello popote etherpad"
nbApp=1
whiptailContenu=""
for application in $liste_applications 
do
    echo "traitement de l'application : ${application}"
    applicationInstallee=$(env | grep INSTALLED | grep -i ${application} | cut -d "=" -f2)
    #applicationInstallee="$(env | grep -i ${application} | grep OK)"
    echo "$application installée ? => $applicationInstallee" 
    ((nbApp++))
    whiptailContenu+=$(echo -e "$application $applicationInstallee  \n")
done
echo "nb application = $nbApp"
echo $whiptailContenu
echo " A FINIR DE DEVELLOPER"
read


echo "Test installation de Wiptail necessaire (interface graphique pour bash)"
testWhiptail=$(whiptail -v | cut -d " " -f 2)
if [[ "X-$testWhiptail" != "X-(newt):" ]]; then 
    sudo apt install -y whiptail
fi



while :
do

    if [[ "X-$K8S_HELLO_NODE_INSTALLED" != "X-" ]] then 
        applicationHelloNode="installée"
    else
        applicationHelloNode=""
    fi 
    if [[ "X-$K8S_POPOTE_INSTALLED" != "X-" ]] then 
        applicationPopote="installée"
    else
        applicationPopote=""    
    fi 
    if [[ "X-$K8S_ETHERPAD_INSTALLED" != "X-" ]] then 
        applicationEtherpad="installée"
    else
        applicationEtherpad=""    
    fi 

    nomApplication=$(whiptail --menu "choisissez quelle application vous voulez installer : " 15 60 5 \
        "hello node" "$applicationHelloNode " \
        "popote" "$applicationPopote " \
        "etherpad" "$applicationEtherpad " \
        "quitter" "" \
        3>&1 1>&2 2>&3)

    if [[ "X-$nomApplication" != "X-" ]]; then
        if [[ "$nomApplication" == "quitter" ]]; then
            break;
        elif [[ "$nomApplication" == "hello node" ]]; then
            if [[ "X-$applicationHelloNode" == "X-" ]]; then 
                source ./30-install-hello-node.bash
            else
                source ./31-desinstall-hello-node.bash
            fi

        elif [[ "$nomApplication" == "popote" ]]; then
            if [[ "X-$applicationPopote" == "X-" ]]; then 
                source ./30-install-popote.bash
            else
                source ./31-desinstall-popote.bash
            fi

        elif [[ "$nomApplication" == "etherpad" ]]; then
            if [[ "X-$applicationEtherpad" == "X-" ]]; then 
                source ./30-install-etherpad.bash
            else
                source ./31-desinstall-etherpad.bash
            fi

        else
            echo "saisie incorrecte !"
        fi
    fi
done

source set-bash-variable.bash K8S_SCRIPT_INITIALISATION="OK"
echo "installation des applications => fin"

