#!/usr/bin/env bash

echo "## ROS 2 repos"
echo "##------------------------"

sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update
sudo apt upgrade -y

sudo apt install -y \
    ros-iron-desktop \
    ros-dev-tools

echo "## ROS2 advanced deps"
sudo apt install -y \
    ros-iron-slam-toolbox \
    ros-iron-navigation2 \
    ros-iron-nav2-bringup \
    ros-iron-xacro \
    ros-iron-joint-state-publisher-gui \
    ros-iron-gazebo-ros \
    ros-iron-gazebo-ros-pkgs \
    ros-iron-gazebo-dev \
    ros-iron-gazebo-msgs \
    ros-iron-gazebo-plugins \