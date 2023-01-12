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

echo "# Ubuntu 22.04"
echo "#----------------------------"
bash ./script/prepare-22.04.sh

echo "# ROS et Kobuki"
echo "#----------------------------"
#bash ./script/install-ros1+2.sh
#bash ./script/install-docker.sh
bash ./script/install-ros2.sh
bash ./script/install-Kobuki_ros.sh

echo "# Extra equipments"
echo "#----------------------------"
bash ./script/install-extra.sh
# bash ./script/install-gazebo.sh

echo "# And finally build it"
echo "#----------------------------"
bash ./script/build.sh

# Configure user bash:
cat >> ~/.bashrc << EOF

# IMT MobiSyst configuration:
source ~/ros2_ws/pkg-tbot/script/run-commands.bash

EOF

echo "#---------------------------------------------------"
echo "# Its cool (normally) you can resart..."
echo "#---------------------------------------------------"
