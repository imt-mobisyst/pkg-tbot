#!/usr/bin/env bash

echo "# Install realsense2"
echo "#----------------------------"

# [doc](https://docs.ros.org/en/foxy/Installation.html)

echo "## Dependencies"
echo "##----------------------------"

sudo apt update
sudo apt install -y curl gnupg2 lsb-release
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
 -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

echo "## And go (ROS2 - foxy)"
echo "##----------------------------"

sudo apt update
sudo apt install -y ros-foxy-ros-base ros-foxy-demo-nodes-py ros-foxy-ros1-bridge # sudo apt install ros-humble-descktop # on 2022 machine...
echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
source ~/.bashrc
