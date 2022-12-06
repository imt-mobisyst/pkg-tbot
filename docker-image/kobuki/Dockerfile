# Use an official ROS parent image
FROM lozenge14/imt-mobisyst:u16

# Turtlebot: Kobuki
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt update
RUN apt install -y ros-kinetic-kobuki ros-kinetic-kobuki-ftdi

# Turtlebot
COPY ./bot /bot
WORKDIR bot
#ENV NAME World
