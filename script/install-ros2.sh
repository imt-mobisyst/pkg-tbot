#!/usr/bin/env bash

echo "## Dependencies"
echo "##----------------------------"
sudo apt update
sudo apt install -y curl gnupg2 lsb-release

echo "## ROS 2 repos"
echo "##------------------------"

# Ros 2:
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
 -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

echo "## And go (ROS2 - foxy)"
echo "##--------------------------------------"

sudo apt update

#### Ros 2
sudo apt install -y ros-foxy-desktop ros-dev-tools ament-cmake-python #ros-foxy-ros-base for a more basic vertion, in Pi for instance... #ros-foxy-... # on 2022 machine...

echo "## ROS2 advanced deps"
sudo apt install -y \
    ros-foxy-slam-toolbox \
    ros-foxy-navigation2 \
    ros-foxy-nav2-bringup \
    ros-foxy-xacro \
    ros-foxy-joint-state-publisher-gui \
    ros-foxy-gazebo-ros \
    ros-foxy-gazebo-ros-pkgs \
    ros-foxy-gazebo-dev \
    ros-foxy-gazebo-msgs \
    ros-foxy-gazebo-plugins \