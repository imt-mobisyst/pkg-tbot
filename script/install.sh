#!/usr/bin/env bash

# Dependencies
#----------------------------
sudo apt update
sudo apt install -y git sshfs curl code build-essential


# Clonage
#----------------------------
cd
git config --global http.sslVerify false
git clone https://bitbucket.org/imt-mobisyst/mb6-tbot tbot
cd ~/tbot
#git checkout dev-guillaume


# ROS et Docker
#----------------------------
bash script/install-ros.sh
bash script/install-docker.sh


# Somes Packages
#----------------------------
# tbot dpds :
sudo apt install -y \
    ros-noetic-depthimage-to-laserscan \
    ros-noetic-joy \
    ros-noetic-urg-node \
    ros-noetic-urdf
# gazebo dpds :
sudo apt install -y \
    ros-noetic-gazebo-ros \
    ros-noetic-gazebo-plugins \
    ros-noetic-depth-image-proc


# Genrations
#----------------------------
bash script/generate-docker-images.sh


#sudo usermod -a -G dialout $USER
#roscore > roscore.log &
#rosrun kobuki_ftdi create_udev_rules

#bash src/tbot/script/install_simulation.sh
#catkin_make

echo ">> TBOT (on branch: master) installed in ~/tbot <<"
