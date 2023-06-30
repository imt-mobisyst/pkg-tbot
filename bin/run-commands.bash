# Imt-mobisyst bash run-commands

source /opt/ros/humble/setup.bash
export ROS_LOCALHOST_ONLY=1

# Tbot WorkSpace
if [ -d ~/ros2_ws/install ]; then
  source ~/ros2_ws/install/setup.sh
fi

# export GAZEBO_RESOURCE_PATH="$HOME/ros1_ws/src/larm_material/larm/models"
alias imt-ip='ip a | egrep -o "inet 10\.[0-9|\.]+" | egrep -o "[1-9][0-9]*\.[1-9][0-9]*\.[1-9][0-9]*\.[1-9][0-9]*"'

# Prompt
PS1='\[\033[01;32m\]\h\[\033[00m\]|\[\033[01;32m\]`imt-ip`\[\033[00m\](\[\033[01;31m\]ros$ROS_VERSION\033[00m\]):\[\033[01;34m\]\w\[\033[00m\]\n$ '
