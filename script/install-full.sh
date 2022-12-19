#!/usr/bin/env bash

echo "# Clonage"
echo "#----------------------------"
sudo apt update
sudo apt install -y git

# Make ROS workspace:
cd
mkdir ros2_ws
cd ros2_ws

git clone https://bitbucket.org/imt-mobisyst/mb6-tbot pkg-tbot
cd pkg-tbot

echo "# Ubuntu 20.04"
echo "#----------------------------"
bash ./script/prepare-ubuntu20.04.sh

echo "# ROS et Docker"
echo "#----------------------------"
bash ./script/install-ros.sh
bash ./script/install-docker.sh

echo "# Extra equipments"
echo "#----------------------------"
bash ./script/install-extra.sh

echo "# And finally build it"
echo "#----------------------------"
bash ./script/build.sh

# Make Gazebo :
bash ./script/install-gazebo.sh

# Configure user bash:
bash ./script/configure-bashrc.sh
