# Install instruction on Rasbery-Pi


Version Rasbery-Pi3 with Ubuntu 20.04.


# Links

A voir pour creer une image Pi3 et Pi4 à notre image: [custom-raspberry-pi-image](https://opensource.com/article/21/7/custom-raspberry-pi-image). Cependant,l'*Imager* de rasberry fait de base pas mal le taff.

A voir pour installer Docker sur [docs.docker.com](https://docs.docker.com/engine/install/ubuntu/).


### Tuto Pi3 

Preparer une Pi from scratch:

Installer Raspberry pi imager 

Dans imager: 

1. sélectionner une image Ubuntu Server 20.04 lts 64bit (other general-purpose OS).
2. selectionner la carte SD
3. dans paramétres: 
    - hostname: pibot-00.local
    - enable SSH with password auth.
    - set username/passord: bot/bot 
    - set lan: Pirate-INE/pine0kio
4. ecrire la carte SD


Configure the network (in `network-config` file)

```
wifis:
  wlan0:
    dhcp4: true
    optional: true
    access-points:
      "Pirate-INE":
        password: "pine0kio"
```

First log: (ubuntu:ubuntu)

```sh
sudo su
timedatectl
timedatectl set-timezone Europe/Paris
timedatectl set-time "2022-07-07 12:00:30"
timedatectl
apt update
apt upgarde -y
sudo apt autoremove -y
```

Configure simple access: (ubuntu:ubuntu)
Modify address resolution configuration (allowing .local) by installing avahi deamon
and create bot:bot user.

```sh
sudo su
apt install -y avahi-deamon # for .local
echo 'tbot-00' > /etc/hostname       # set on tbot00 (XX from 01 to 99)
adduser bot              # with bot password
usermod -a -G sudo bot
usermod -a -G dialout bot
apt install -y git curl sshfs build-essential
```

You can normally reboot and log from network:

```sh
sudo shutdown -r now
```

Second log: (bot@tbot-00.local)

```sh
sudo timedatectl set-time "2022-07-07 12:00:30"
sudo userdel -r ubuntu
```

Then ROS (base version): (http://wiki.ros.org/noetic/Installation/Ubuntu)

```sh
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update
sudo apt install -y ros-noetic-ros-base
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
sudo rosdep init
rosdep update
```


### How do I get set up?

* Summary of set up
* Configuration
* Dependencies
* Database configuration
* How to run tests
* Deployment instructions

### Contribution guidelines

* Writing tests
* Code review
* Other guidelines

### Who do I talk to?

* Repo owner or admin
* Other community or team contact

## Nouveau sur Git

- **Git** est une solution décentralisée de gestion de version. Ça première utilité est de permettre à plusieurs contributeurs de travailler dans un même répertoire de travail, chacun sur ça machine. Il permet de garder localement un historique des modifications, de partager ces modifications via un *repo* commun sur un serveur, de faciliter les fusions de modification (à condition de privilégier le format texte), le tous en toute sécurité.

- **GitServer**, as *Bitbucket*, *GitHub*, [framagit](https://framagit.org) or private one (*[gvipers](gvipers.imt-lille-douai.fr)* at IMT Lille Douai) proposes a solution based on *git* to share a private or public commun repositorie on the cloud and offering some manadgment services.

First simple usages of those servers are to download a spesific shared file or the entire repository as a *zip* archive or to edit somme file directly on web (mainly Markdown Document).
But, the most commun usage is to clone the entire distant repository on your own machine.

- **Markdown Documents** est un format texte le plus simple possible et directement interprétable sur tout serveur communautaire *git* qui se respecte sur la philosophie: **What you see is what you get**
	* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)
	* [GhostWriter](https://wereturtle.github.io/ghostwriter/): un éditeur léger et multi-plateforme

- Going futher on Git:
	* [Learn Git](https://try.github.io/)
	* [GitForWindows](https://gitforwindows.org/) a simple IDE for Windows.
