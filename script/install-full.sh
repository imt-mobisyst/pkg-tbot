#!/usr/bin/env bash

echo "# Clonage"
echo "#----------------------------"
sudo apt update
sudo apt install -y git

# Make ROS src directory:
cd
mkdir ros2_ws
mkdir ros2_ws/src
cd ros2_ws/src

git clone https://bitbucket.org/imt-mobisyst/mb6-tbot tbot
cd tbot

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
cd
mkdir ros1_ws
mkdir ros1_ws/src
cd ros1_ws/src

sudo apt install -y libyaml-cpp-dev \
    ros-noetic-gazebo-plugins \
    gazebo11 \
    ros-noetic-gazebo-ros \
    ros-noetic-xacro \
    ros-noetic-robot-state-publisher  \
    ros-noetic-joy \
<<<<<<< HEAD
    ros-noetic-urg-node \
    ros-noetic-gazebo-plugins \
    ros-noetic-rqt-graph
=======
    ros-noetic-urg-node
>>>>>>> 8c18d9a649205965ba36baf09c326ba7e727f543

git clone https://bitbucket.org/imt-mobisyst/larm_material.git

sudo sed -i 's/m = r.search(vstr)/m = r.search(vstr.decode("utf-8"))/' /opt/ros/noetic/lib/tf/view_frames

cd ..
source /opt/ros/noetic/setup.bash
catkin_make

# Configure user bash:

echo ""                   >> ~/.bashrc
echo "#ROS"               >> ~/.bashrc
echo 'alias rosify1="source /opt/ros/noetic/setup.bash && source $HOME/ros1_ws/devel/setup.bash"' >> ~/.bashrc
echo 'export GAZEBO_RESOURCE_PATH="$HOME/ros1_ws/src/larm_material/larm/models"' >> ~/.bashrc
echo 'alias rosify2="source /opt/ros/foxy/setup.bash && source $HOME/ros2_ws/install/setup.bash"'  >> ~/.bashrc

