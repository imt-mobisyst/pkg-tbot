#!/bin/bash

sudo apt install -y ros-foxy-ecl-core ros-foxy-ecl-console ros-foxy-ecl-mobile-robot

cd ~/ros2_ws/
git clone https://github.com/kobuki-base/kobuki_ros
git clone https://github.com/kobuki-base/kobuki_core
git clone https://github.com/kobuki-base/kobuki_ros_interfaces

cd ..
colcon build
