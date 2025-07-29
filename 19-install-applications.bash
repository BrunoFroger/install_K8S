#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       installation des applications"
echo "*"
echo "*************************************************"


#liste_applications="hello popote etherpad"
liste_applications="hello popote kube-web-view"

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
    nomApplication=$(whiptail --menu "choisissez quelle application vous voulez installer : " 15 80 $nbApp ${whiptailContenu} 3>&1 1>&2 2>&3)
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

# echo " A FINIR DE DEVELLOPER"
# read



# while :
# do

#     if [[ "X-$K8S_HELLO_NODE_INSTALLED" != "X-" ]] then 
#         applicationHelloNode="installée"
#     else
#         applicationHelloNode=""
#     fi 
#     if [[ "X-$K8S_POPOTE_INSTALLED" != "X-" ]] then 
#         applicationPopote="installée"
#     else
#         applicationPopote=""    
#     fi 
#     if [[ "X-$K8S_ETHERPAD_INSTALLED" != "X-" ]] then 
#         applicationEtherpad="installée"
#     else
#         applicationEtherpad=""    
#     fi 

#     nomApplication=$(whiptail --menu "choisissez quelle application vous voulez installer : " 15 60 5 \
#         "hello" "$applicationHelloNode " \
#         "popote" "$applicationPopote " \
#         "etherpad" "$applicationEtherpad " \
#         "quitter" "" \
#         3>&1 1>&2 2>&3)

#     if [[ "X-$nomApplication" != "X-" ]]; then
#         if [[ "$nomApplication" == "quitter" ]]; then
#             break;
#         elif [[ "$nomApplication" == "hello" ]]; then
#             if [[ "X-$applicationHelloNode" == "X-" ]]; then 
#                 source ./30-install-hello.bash
#             else
#                 source ./31-desinstall-hello.bash
#             fi

#         elif [[ "$nomApplication" == "popote" ]]; then
#             if [[ "X-$applicationPopote" == "X-" ]]; then 
#                 source ./30-install-popote.bash
#             else
#                 source ./31-desinstall-popote.bash
#             fi

#         elif [[ "$nomApplication" == "etherpad" ]]; then
#             if [[ "X-$applicationEtherpad" == "X-" ]]; then 
#                 source ./30-install-etherpad.bash
#             else
#                 source ./31-desinstall-etherpad.bash
#             fi

#         else
#             echo "saisie incorrecte !"
#         fi
#     fi
# done

echo "installation des applications => fin"

