#!/usr/bin/env bash

# Clonage
#----------------------------
cd
git config --global http.sslVerify false
git clone https://bitbucket.org/imt-mobisyst/mb6-tbot tbot
cd ~/tbot
#git checkout dev-guillaume

# Genrations
#----------------------------
bash script/install-docker.sh
bash script/generate-docker-images.sh

#sudo usermod -a -G dialout $USER
#roscore > roscore.log &
#rosrun kobuki_ftdi create_udev_rules

#bash src/tbot/script/install_simulation.sh
#catkin_make

echo ">> TBOT (on branch: master) installed in ~/tbot <<"
