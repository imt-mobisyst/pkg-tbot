#!/usr/bin/env bash

echo "# Dependencies"
echo "#----------------------------""
sudo apt update
sudo apt install -y git sshfs curl code build-essential


echo "# Clonage"
echo "#----------------------------"
cd
git config --global http.sslVerify false
git clone https://bitbucket.org/imt-mobisyst/mb6-tbot tbot
cd ~/tbot
#git checkout dev-guillaume


echo "# ROS et Docker"
echo "#----------------------------"
bash script/install-ros.sh
bash script/install-docker.sh


echo "# Somes Packages"
echo "#----------------------------"
# tbot dpds :
sudo apt install -y \
  ros-noetic-depthimage-to-laserscan \
  ros-noetic-joy \
  ros-noetic-urg-node \
  ros-noetic-urdf
# gazebo dpds :
# sudo apt install -y \
#   ros-noetic-gazebo-ros \
#   ros-noetic-gazebo-plugins \
#   ros-noetic-depth-image-proc


echo "# Genrations"
echo "#----------------------------"
bash script/generate-docker-images.sh

#sudo usermod -a -G dialout $USER
#roscore > roscore.log &
#rosrun kobuki_ftdi create_udev_rules

#bash src/tbot/script/install_simulation.sh
#catkin_make

echo ">> TBOT (on branch: master) installed in ~/tbot <<"
