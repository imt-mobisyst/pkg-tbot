#!/bin/bash

# Get some dependencies:

export ROSDISTRO=iron
sudo apt install -y\
    ros-$ROSDISTRO-ecl-command-line\
    ros-$ROSDISTRO-ecl-console\
    ros-$ROSDISTRO-ecl-devices\
    ros-$ROSDISTRO-ecl-geometry\
    ros-$ROSDISTRO-ecl-mobile-robot\
    ros-$ROSDISTRO-ecl-sigslots\
    ros-$ROSDISTRO-urg-node

# configure udev to recognize kobuki robot:
sudo cp ./kobuki_core/60-kobuki.rules /lib/udev/rules.d/
sudo usermod -a -G dialout `whoami`

./bin/build.sh
