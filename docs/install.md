# Installation of tbot


/!\ In case of differences betwen ths information here and the elements in intall.sh script, consider that the script is up to date.


The `tbot` project requires several dependencies mostly relying on Docker and ROS
to load turtlebot-kobuki ROS driver in a virtual environment and add some usefull ROS packages (ros2-bridge, laser...). 

### Dependencies

TBot Requires an Ubuntu/ROS machine with Docker and some other dependencies.

**Classical Ubuntu packages :**

```sh
sudo apt update
sudo apt install -y git git-lfs openssh-server sshfs curl python3 python3-pip
```


### Get tbot

Clone this repo:

```sh
git clone https://bitbucket.org/imt-mobisyst/mb6-tbot tbot
cd tbot
```


### ROS and Docker

Installation procedure:

- [ROS](https://wiki.ros.org/noetic/Installation/Ubuntu) (script: [install-ros.sh](../script/install-ros.sh))
- [Docker](https://docs.docker.com/engine/install/ubuntu) (script: [install-docker.sh](../script/install-docker.sh))


### Some extra

**Tbot** can take advantage of different extra-dependancy, tically the realsence-camera, the kokuyo laser range, simulation configuration...
The install procedures and more information on [./install-extra.md](install-extra.md).

**In short:**

```sh
cd tbot
./script/install-extra.sh
```



























**Some ROS packages.**

Then it depends also on several packages not installed with the desktop version of ROS:

```bash
sudo apt update
# tbot dpds :
sudo apt install -y \
    ros-noetic-teleop-twist-keyboard \
    ros-noetic-depthimage-to-laserscan \
    ros-noetic-joy \
    ros-noetic-urg-node \
    ros-noetic-urdf
```

To finalize kobuki installation (http://wiki.ros.org/kobuki/Tutorials/Installation)

```bash
sudo usermod -a -G dialout $USER
roscore > roscore.log &
rosrun kobuki_ftdi create_udev_rules
```

This script normally allows udev to recgnize a connected kobuki and to install it on `/dev/kobuki` when the usb connector is plugged to the computer.

Restart the machine to have everything configured properly.


### Tbot

Clone this repo in your catkin directory:

```bash
cd $HOME/catkin_ws
mkdir src # If necessary
git clone https://bitbucket.org/imt-mobisyst/mb6-tbot src/mb6-tbot
```

Potentially the cloning process fail du to SSL verification. Try: 

```sh
git config --global http.sslverify false
```
or
```sh
export GIT_SSL_NO_VERIFY=1
```

Générate the docker-image: (script: [generate-docker-images](script/generate-docker-images.sh))

tbot includes 2 images: **mb6u16**, a généric ROS image on top of a Ubuntu 16.04 (xenial) and **mb6u16:kobuki** with kobuki packages.

```sh
sudo docker build --tag mb6u16 docker-image/mb6u16/
sudo docker build --tag mb6u16:kobuki docker-image/kobuki/
```

Authorize the user to launch docker images without passwords:

```sh
echo "$USER        ALL=(ALL:ALL) NOPASSWD: /usr/bin/docker run" > 36-tbot-docker
sudo chown root:root 36-tbot-docker
sudo mv 36-tbot-docker /etc/sudoers.d/
``

Then it is possoble to generate tbot packages:

Build-it: (2 or 3 times to solve somme recursive dependencies...)

```bash
catkin_make
```

(for a selection of packahes: `catkin_make --only-pkg-with-deps kobuki_safety_controller`)

**Extra:** 

**Tbot** takes advantage of different extra-dependancy, tically the Realsence-camera, the kokuyo laser range, simulation configuration...
The install procedures and more information on [./doc/install-extra.md](install-extra.md).

**In short:**

```sh
cd tbot
./script/install-extra
```
