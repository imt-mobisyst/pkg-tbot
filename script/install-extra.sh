#!/usr/bin/env bash

echo "# Install realsense2"
echo "#----------------------------"

# Some dependancies:
sudo apt install autoconf dh-autoreconf libudev-dev

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

./vcpkg/vcpkg install realsense2