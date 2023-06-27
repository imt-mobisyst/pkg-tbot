#!/bin/bash

sudo apt install -y ros-foxy-ecl-core ros-foxy-ecl-console ros-foxy-ecl-mobile-robot
# sudo apt install -y ros-foxy-ecl-build

sudo cp /home/bot/ros2_ws/kobuki_driver/kobuki_core/60-kobuki.rules /lib/udev/rules.d/

# cd ~/ros2_ws/
# git clone https://github.com/kobuki-base/kobuki_ros
# git clone https://github.com/kobuki-base/kobuki_core
# git clone https://github.com/kobuki-base/kobuki_ros_interfaces

cd ~/ros2_ws/
colcon build
