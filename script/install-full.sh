#!/usr/bin/env bash

echo "# Clonage"
echo "#----------------------------"
sudo apt update
sudo apt install -y git

# Make ROS src directory:
cd
mkdir rosspace
mkdir rosspace/src
cd rosspace/src

git clone https://bitbucket.org/imt-mobisyst/mb6-tbot tbot
cd tbot

echo "# Ubuntu 20.04"
echo "#----------------------------"
bash ./script/prepare-ubuntu20.04.sh

echo "# ROS et Docker"
echo "#----------------------------"
bash ./script/install-ros.sh
bash ./script/install-docker.sh

echo "# Extra equipments"
echo "#----------------------------"
bash ./script/install-extra.sh

echo "# And finally build it"
echo "#----------------------------"
bash ./script/build.sh


# Configure user bash:
cd ../..

echo ""                                   >> ~/.bashrc
echo "# Tbot WorkSpace"                    >> ~/.bashrc
echo "if [ -d `dirs`/install ]; then"     >> ~/.bashrc
echo "  source `dirs`/install/setup.sh"   >> ~/.bashrc
echo "fi"                                 >> ~/.bashrc

echo ">> TBOT (on branch: master) installed in ~/mb6Space/src/tbot <<"
