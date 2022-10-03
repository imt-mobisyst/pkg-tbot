#!/bin/bash

if [ -e "/dev/ttyUSB0" ]
then
  echo "Launch imop:turtlebot"
  sudo docker run --rm --privileged --network host -it mb6u16:kobuki bash start_ros.bash
  # "--privileged" to get most of /dev
  # "--network host" to run the docker image as it was running directly on the host
else
  echo "kobuki need to be connected (/dev/ttyUSB0 absent)"
fi
