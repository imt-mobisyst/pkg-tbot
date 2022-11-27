#!/usr/bin/env bash
# RealSense:
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
sudo add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u

## Independant:
sudo apt install \
    librealsense2-dkms \
    librealsense2-utils \
    librealsense2-dev \
    librealsense2-dbg

## In ROS:
#sudo apt install -y \
#    ros-noetic-librealsense2 \
#    ros-noetic-realsense2-camera \
#    ros-noetic-realsense2-description
#    ros-noetic-depthimage-to-laserscan \
#    ros-noetic-rqt \
#    ros-noetic-rqt-image-view
