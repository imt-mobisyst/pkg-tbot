#!/usr/bin/env bash

# Some complement:
echo "## Classical libs"
echo "##----------------------------"

sudo apt install -y libopencv-dev python3-opencv

# Make dependencies' directory:
if [[ ! -d dpd ]]
then
    mkdir dpd
fi
cd dpd

# Clone and initialize vcpkg:
echo "## Install vcpkg"
echo "##----------------------------"

git clone https://github.com/Microsoft/vcpkg.git
./vcpkg/bootstrap-vcpkg.sh

# And finally install the realsense2 lib and tools 
echo "## Get and Build RealSense2"
echo "##----------------------------"

# Some dependancies:
sudo apt install -y autoconf dh-autoreconf libudev-dev cmake

./vcpkg/vcpkg install realsense2
#pip install pyrealsense2

cd ..
./script/setup_udev_rules.sh

echo "# Install urg_node"
echo "#----------------------------"
