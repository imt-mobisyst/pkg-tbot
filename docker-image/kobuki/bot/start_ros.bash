#!/bin/bash

source /opt/ros/kinetic/setup.sh
ln -s /dev/ttyUSB0 /dev/kobuki
roslaunch kobuki_node minimal.launch
