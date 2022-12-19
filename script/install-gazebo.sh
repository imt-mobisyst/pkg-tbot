#!/usr/bin/env bash

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
    ros-noetic-urg-node \
    ros-noetic-gazebo-plugins \
    ros-noetic-rqt-graph

git clone https://bitbucket.org/imt-mobisyst/larm_material.git

sudo sed -i 's/m = r.search(vstr)/m = r.search(vstr.decode("utf-8"))/' /opt/ros/noetic/lib/tf/view_frames

cd ..
source /opt/ros/noetic/setup.bash
catkin_make

echo "#---------------------------------------------------"
echo "# Its cool (normally) you can open a new terminal..."
echo "#---------------------------------------------------"
