# Use an official ROS parent image
FROM ubuntu:xenial

# Complete ubuntu environment
RUN apt update
RUN apt -y install sudo

# Complete ROS environment
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt update
RUN apt install -y ros-kinetic-ros-base
RUN rosdep init
RUN rosdep update

# Make port 11311 available to the world outside this container
EXPOSE 11311
