#!/usr/bin/env bash
cd
git config --global http.sslVerify false
git clone https://bitbucket.org/imt-mobisyst/mb6-tbot tbot
git -C tbot/ checkout dev-guillaume
#bash tbot/script/install_dependencies.sh

#sudo usermod -a -G dialout $USER
#roscore > roscore.log &
#rosrun kobuki_ftdi create_udev_rules

#bash src/tbot/script/install_simulation.sh
#catkin_make

echo ">> TBOT (on branch: dev-guillaume) installed in ~/tbot <<"
