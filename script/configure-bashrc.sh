#!/usr/bin/env bash

cat >> ~/.bashrc << EOF

# ROS

source /opt/ros/foxy/setup.bash
export ROS_LOCALHOST_ONLY=1

# Tbot WorkSpace
if [ -d ~/ros2_ws/install ]; then
  source ~/ros2_ws/install/setup.sh
fi

export PS1="\${ROS_VERSION:+(ros\$ROS_VERSION) }$PS1"
# export GAZEBO_RESOURCE_PATH="\$HOME/ros1_ws/src/larm_material/larm/models"
alias rosify1="source /opt/ros/noetic/setup.bash && source \$HOME/ros1_ws/devel/setup.bash"
alias rosify2="source /opt/ros/foxy/setup.bash && source \$HOME/ros2_ws/install/setup.bash"
alias imt-ip='ip a | grep "inet 10" | egrep -o "[1-9][0-9]*\.[1-9][0-9]*\.[1-9][0-9]*\.[1-9][0-9]*"'

EOF
