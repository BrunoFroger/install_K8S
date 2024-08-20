# install_K8S (en construction)

# Présentation
Ce dépot est un exemple simpliste de ce qui peut etre fait pour créer un cluster Kubernetes (K8S).

# Pré-requis

Avant de vous lancer dans l'installation de votre cluster, voici quelques pré-requis :

- Avoir un minimum de connaissance dans les domaines suivants :
  - Réseau ()
  - Cloud (containerisation, virtualisation)
  - Développement logiciel (bash, ansible, ....)
- Disposer de 1 ou plusieurs machines qui serviront à l'expérimentation (noeuds), il est préférable d'avoir un minimum de 2 machines pour comprendre les notions de noeud et de répartition d'éxecution de process.
- disposer d'une connexion internet via un routeur (ex : Livebox)
- avoir un réseau local derriere ce routeur (prevoir un switch pour connecter les machines entre elles)
- le contenu de ces machines sera effacé définitivement (pensez a vos sauvegardes)
- une des machine sera considérée comme le maitre du cluster (master) et les autres comme esclaves (slaves)

# Etapes a réaliser avant de commencer a executer les scripts d'installation

Sur chacunes des machines :

- installer Linux (Ubuntu)
  - recuperer la distribution [ici](https://www.ubuntu-fr.org/download/) - flasher clé USB avec la distribution ; doc [ici](https://doc.ubuntu-fr.org/live_usb)  
  - brancher la machine cible sur le secteur  
  - raccorder 1 câble réseau sur le switch  
  - sélectionner boot sur clé USB dans le setup de la machine au démarrage  
  - démarrer ou redémarrer  
  - lancer l'installation  


paramètres à renseigner pour l'installation de linux :  

- sélectionner la langue (français)  
- sélectionner installer Ubuntu (écraser toute autre installation)
- valider clavier français (continuer)  
- pas de connexion réseau sans fil  
- mise à jour et autres logiciels : sélectionner installation minimale, avec téléchargement des mise à jour en cours d'installation  
- si une autre version était déjà installée la remplacer par la nouvelle  
- si demande changement sur les disques, valider  
- valider fuseau horaire sur Paris  
- renseignement "qui êtes-vous"
	- nom : exemple **master** ou **slave** suivant role de la machine  
  - nom ordinateur : exemple **K8Smaster** ou **K8SslaveXX** (XX numéro de la machine)  
  - nom utilisateur : exemple **master** ou **slave** 
  - password : exemple **K8S&master** ou **K8S&slave** 
- Lors du message installation terminée, retirer la clé USB et lancer le redémarrage.

Si lors de votre première connexion, la machine ne vous demande pas de mettre a jour le système ; 
il faudra forcer cette mise a jour globale après l'installation.
Pour cela ouvrez un terminal sur la machine et tapez les commandes suivantes :

```
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y openssh-server
```

creation de la cle ssh pour pouvoir se connecter a distance sur votre machine

A executer sur la machine cible

```
mkdir .ssh
cd .ssh
ssh-keygen -N "" -f id_rsa
service sshd restart
```

Executer ensuite sur la machine distante la commande suivante : ``ssh-copy-id <username>@<nomMachine.local>``
Si une clé existe déjà pour cette machine vous devez la supprimer dans le fichier **~/.ssh/

vous pouvez verifier que l'échange st opération si lorsque vous essayer de vous connecter en ssh depuis la machine distante sur votre noeud on ne vous demande plus de mot de passe (commande de connexion ``ssh <user>@<machine>``

# post-install

Pensez a verifier que la mise en veille de votre machine n'est pas activée (sinon, le mode veille bloquerait a celle ci) 

# Utilisation a distance a travers votre livebox

## parametrage du DNS dynamique

Pour acceder a des machines derriere votre livebox, vous devez définir une asresse DNS qui sera accessible depuis internet, pour cela il existe plussieurs site qui offre  ce genre de service (pour l'exemple j'ai utilise [no-ip](https://www.noip.com/))

Si vous n'en avez pas encore, créer vous un compte .....

Vous pouvez alors définir une adresse IP correspondant a votre livebox (vous devez le faire depuis une machine connectée a votre livebox)

Vous definisez ainsi un domaine de la forme **monapplication.zapto.org** qui definira le point d'entrée vers votre livebox

Il faut maintenant définir les accès a vos machines en configurant la livebox :

Connectez vous sur votre [livebox](http://livebox.local) depuis un navigateur

Passer en mode administrateur (saisir mot de masse en haut a droite et cliquer sur s'identifier)

**parametrage DHCP** : 
  - cliquer sur configuration avancée
  - aller sur onglet DHCP
  - dans le tableau selectionner chacune des machines de votre reseau et ajoutez les a ce tableau

au final, vous devriez avoir un tableau qui ressemble a :

| nom | adresse IP | adresse MAC | 
| ---| ---| --- |
| machine00 | 192.168.1.xx | xx:xx:xx:xx:xx:xx |
| machine01 | 192.168.1.yy | xx:xx:xx:xx:xx:xx |
| machine02 | 192.168.1.zz | xx:xx:xx:xx:xx:xx |

**parametrage NAT/PAT** : ce tableau permet de définir vers quelle machine le flux entrant sera envoyé en fonction du port 

au final vous devriez avoir un tableau qui ressemble a : 


| Application/service | port interne | port externe | protocole | appareil |
| ---| ---| --- | ---| --- |
| http | 80 | 80 | TCP | machinexx |
| https | 443 | 443 | TCP | machinexx |
| sshxx | 22 | xxxx | TCP | machinexx |
| sshxx | 22 | xxxx | TCP | machinexx |
| sshxx | 22 | xxxx | TCP | machinexx |

Chacune des lignes sshxx doit pointer sur des ports externes différents elles permettent de vous connecter depuis internet en ssh sur vos machine (ces lignes doivent etre supprimée en situation de production) ; vous pouvez alors vous connecter avec la commande ``ssh -p xxxx login@monapplication.zapto.org`` mondomaine ayant été défini plus haut sur le site de dns dynamique. 

# Installation Kubernetes

Ces étapes peuvent etres faites en local sur la machine ou via une machine distante connectée en ssh
Vous pouvez alors récupérer les scripts d'installation en téléchargant la derniere release du projet :

```
cd ~
mkdir -p projets/install_K8S
cd projets/install_K8S
wget https://github.com/BrunoFroger/install_K8S/archive/tags/<version>.zip
unzip <version>>.zip
cd install_K8S-<version>.zip
```
ci dessus remplacer version par la version que vous voulez télécharger

# execution de l'installation 

Pour lancer l'installatipn de kubernetes sur votre/vos machine(s) vous devez executer les commandes suivantes 


```
cd ~/projets/install_K8S-tags-<version>
. ./00install-kubernetes.bash
```

ATTENTION : ne pas oublier le point '.' avant le nom du script './00install-kubernetes.bash'

ce script vous demandera quelques informations :

- installation du master ou d'un esclave
- si installation d'un esclave il demandera le nom (ou adresse IP du master) si vous etes dans un reseau local derriere une livebox ou autre routeur du même genre, le nom devra peut etre complété par '.local' (ex master.local)
- il demande aussi le nom d'un namespace a creer pour installer ensuite vos applications
- entre chaque module, le script s'arrete pour vous demander de valider la suite

A la fin de l'execution de ces scripts, vus pouvez retrouver le resultat de l'excution dans les fichiers suivants (supprimé pour l'instant, a réactiver) :

- install_K8S.out.log => resultats des commandes executées
- install_K8S.err.log => erreurs rencontrées durant l'installation


l'installation du master génère automatiquement les fichiers suivants :

- kubeadm-init.out.log => log de la commande d'initialisation du master (sortie standard)
- kubeadm-init.err.log => log de la commande d'initialisation du master (sortie d'erreur)

# commandes utiles 

<table>
  <theader>
    <tr>
      <th>objet</th>
      <th>commande</th>
      <th>description</th>
    </tr>
  </theader>
  <tbody>
    <tr>
      <td rowspan="2">noeuds</td>
      <td>kubectl get nodes</td>
      <td>liste des noeuds</td>
    </tr>
    <tr>
      <td>kubectl describe node nom-du-noeud</td>
      <td>desciption d'un noeud</td>
    </tr>
    <tr>
      <td rowspan="3">namespaces</td>
      <td>kubectl get namespaces</td>
      <td>liste des namespaces</td>
    </tr>
    <tr>
      <td>kubectl create namespace nom-du-namespace</td>
      <td>creation d'un namespace</td>
    </tr>
    <tr>
      <td>kubectl describe namespace nom-du-namespace</td>
      <td>desciption d'un namespace</td>
    </tr>
    <tr>
      <td rowspan="4">pods</td>
      <td>kubectl get pods``</td>
      <td>liste des pods du namespace courant</td>
    </tr>
    <tr>
      <td>kubectl get pods -A``</td>
      <td>liste des pods de tous les namespaces</td>
    </tr>
    <tr>
      <td>kubectl get pods -n namespace</td>
      <td>liste des pods d'un namespace particulier</td>
    </tr>
    <tr>
      <td>kubectl describe pod nom-du-namespace</td>
      <td>desciption d'un pod</td>
    </tr>
  </tbody>
</table>
