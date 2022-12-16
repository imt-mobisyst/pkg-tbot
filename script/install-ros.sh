#!/usr/bin/env bash

echo "## Dependencies"
echo "##----------------------------"

sudo apt update
sudo apt install -y curl gnupg2 lsb-release

echo "## ROS 1 & 2 repos"
echo "##----------------------------"

# Ros 1:
sudo sh -c 'echo deb http://packages.ros.org/ros/ubuntu focal main > /etc/apt/sources.list.d/ros-latest.list'
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -


# Ros 2:
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
 -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

echo "## And go (ROS1 - noetic & ROS2 - foxy)"
echo "##--------------------------------------"

sudo apt update

#### Ros 1: (Only ros1 packages relative to rosbridge would be installed)
#sudo apt install -y ros-noetic-ros-base
#source /opt/ros/noetic/setup.bash
#sudo apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
#sudo rosdep init
#rosdep update

#### Ros 2
sudo apt install -y ros-foxy-desktop ros-dev-tools #ros-foxy-ros-base for a more basic vertion, in Pi for instance... #ros-humble-... # on 2022 machine...

echo "## ROS2 advanced deps"
sudo apt install -y \
    ros-foxy-slam-toolbox \
    ros-foxy-navigation2 \
    ros-foxy-nav2-bringup \
    ros-foxy-xacro \
    ros-foxy-joint-state-publisher-gui \
    ros-foxy-gazebo-ros-pkgs

#### Ros Bridge:
echo "## Ros-Bridge"
sudo apt install -y ros-foxy-ros1-bridge

echo "Copy required ros1 lib for Ros-Bridge"
sudo cp /opt/ros/noetic/lib/libroscpp.so\
    /opt/ros/noetic/lib/libroscpp_serialization.so\
    /opt/ros/noetic/lib/libxmlrpcpp.so\
    /opt/ros/noetic/lib/librostime.so\
    /opt/ros/noetic/lib/libcpp_common.so\
    /opt/ros/noetic/lib/librosconsole.so\
    /opt/ros/noetic/lib/librosconsole_log4cxx.so\
    /opt/ros/noetic/lib/librosconsole_bridge.so\
    /opt/ros/noetic/lib/librosconsole_backend_interface.so\
    /opt/ros/foxy/lib/
