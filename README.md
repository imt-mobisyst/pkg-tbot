# MobiSyst - TBot

This project is a ROS Catkin package that includes usefull elements for turtlebot2 robots in the IMT Nord-Europe configuration (tbot).

Last system version: **Ubuntu 20.04 lts** / **ROS neotic**.

Thanks:

- [gaunthan for Turtlebot2 on Melodic](https://github.com/gaunthan/Turtlebot2-On-Melodic)
- [TheConstruct](https://www.theconstructsim.com/) the virtualisation and the simulation environment they provide.


## Installation

The `tbot` project requires several dependencies mostly relying on Docker and ROS to load turtlebot-kobuki ROS driver in a virtual environment and add some usefull ROS packages (laser, ros2-bridge...). 

However to shortcut the installation process you can execute the install script (supose that ROS Neotic is already installed): 

**In short:** [./script/install.sh](install.sh)

```sh
curl -k https://bitbucket.org/imt-mobisyst/mb6-tbot/raw/master/script/install.sh | bash
```

_WARNING_: The default install comme with simulation packages.

Otherwise you can go throut the step-by-step installation:

### Dependencies

TBot Requires an Ubuntu/ROS machine with Docker and some other dependencies.

**Classical Ubuntu packages.**

```sh
sudo apt update
sudo apt install -y git sshfs curl code build-essential
```


**ROS and Docker**

Installation procedure:

- [ROS](https://wiki.ros.org/noetic/Installation/Ubuntu) (script: [install-ros.sh](script/install-ros.sh))
- [Docker](https://docs.docker.com/engine/install/ubuntu) (script: [install-docker.sh](script/install-docker.sh))


**Some ROS packages.**

Then it depends also on several packages not installed with the desktop version of ROS:

```bash
sudo apt update
# tbot dpds :
sudo apt install -y \
    ros-noetic-depthimage-to-laserscan \
    ros-noetic-joy \
    ros-noetic-urg-node \
    ros-noetic-urdf

# gazebo dpds :
sudo apt install -y \
    ros-noetic-gazebo-ros \
    ros-noetic-gazebo-plugins \
    ros-noetic-depth-image-proc
```

To finalize kobuki installation (http://wiki.ros.org/kobuki/Tutorials/Installation)

```bash
sudo usermod -a -G dialout $USER
roscore > roscore.log &
rosrun kobuki_ftdi create_udev_rules
```

This script normally allows udev to recgnize a connected kobuki and to install it on `/dev/kobuki` when the usb connector is plugged to the computer.

Restart the machine to have everything configured properly.


### Tbot

Clone this repo in your catkin directory:

```bash
cd $HOME/catkin_ws
mkdir src # If necessary
git clone https://bitbucket.org/imt-mobisyst/mb6-tbot src/mb6-tbot
```

Potentially the cloning process fail du to SSL verification. Try: 

```sh
git config --global http.sslverify false
```
or
```sh
export GIT_SSL_NO_VERIFY=1
```

Générate the docker-image: (script: [generate-docker-images](script/generate-docker-images.sh))

tbot includes 2 images: **mb6u16**, a généric ROS image on top of a Ubuntu 16.04 (xenial) and **mb6u16:kobuki** with kobuki packages.

```sh
sudo docker build --tag mb6u16 docker-image/mb6u16/
sudo docker build --tag mb6u16:kobuki docker-image/kobuki/
```

Then it is possoble to generate tbot packages:

Build-it: (2 or 3 times to solve somme recursive dependencies...)

```bash
catkin_make
```

(for a selection of packahes: `catkin_make --only-pkg-with-deps kobuki_safety_controller`)

## Getting started

Start kobuki: 

1. connect and switch-on the turtlebot-kobuki 
2. start the docker: `./script/start-tbot.sh`





---

## Installation

The `tbot` project requires several dependencies mostly relying on ROS packages befor to be build.
However to shortcut the installation process you can execute the install script (supose that ROS Neotic is already installed): 

**In short:** [./script/install_apt_deps.sh](install.sh)

```sh
curl https://bitbucket.org/imt-mobisyst/mb6-tbot/raw/dev-guillaume/script/install.sh | bash
```

_WARNING_: The default install comme with simulation packages.

Otherwise you can go throut the step-by-step installation:

### Dependencies

**TBot Requires an Ubuntu/ROS machine.**

- [Installation procedure](https://wiki.ros.org/noetic/Installation/Ubuntu)

Then it depends also on several packages not installed with the desktop version of ROS:

```bash
sudo apt update
# Kobuki dpds :
sudo apt install -y \
    ros-noetic-ecl-exceptions \
    ros-noetic-ecl-threads \
    ros-noetic-ecl-geometry \
    ros-noetic-ecl-streams \
    ros-noetic-ecl-eigen \
    ros-noetic-kobuki-* \
    ros-noetic-angles \
    ros-noetic-depthimage-to-laserscan \
    ros-noetic-joy \
    ros-noetic-urg-node \
    ros-noetic-urdf \
    libyaml-cpp*

# Kobuki_gazebo dpds :
sudo apt install -y \
    ros-noetic-gazebo-ros \
    ros-noetic-gazebo-plugins \
    ros-noetic-depth-image-proc
```

To finalize kobuki installation (http://wiki.ros.org/kobuki/Tutorials/Installation)

```bash
sudo usermod -a -G dialout $USER
roscore > roscore.log &
rosrun kobuki_ftdi create_udev_rules
```

This script normally allows udev to recgnize a connected kobuki and to install it on `/dev/kobuki` when the usb connector is plugged to the computer.

Restart the machine to have everything configured properly.

### TBot

Clone this repo in your catkin directory:

```bash
cd $HOME/catkin_ws
mkdir src # If necessary
git clone https://bitbucket.org/imt-mobisyst/mb6-tbot src/mb6-tbot
```

Potentially the cloning process fail du to SSL verification. Try: 

```sh
git config --global http.sslverify false
```
or
```sh
export GIT_SSL_NO_VERIFY=1
```

Build-it: (2 or 3 times to solve somme recursive dependencies...)

```bash
catkin_make
```

for a selection of packahes: `catkin_make --only-pkg-with-deps kobuki_safety_controller`

### Hello World:

Switch-on a turtlebot and connect it to the machine.

Start ROS and the robot equiped with the hokuyo laser:

```bash
source devel/setup.bash
roslaunch tbot_bringup start.launch
```

You can teleoperate the robot with the keyboard from a second terminal:

```bash
roslaunch tbot_bringup teleop.launch
```

Stop the programs (`ctrl-c`).

## Simulation:



## Laser:



## RealSense Camera:

TBot perception integrate a RealSense Camera

```sh
bash ./script/install_realsense.sh
```

or :

### Install the RealSense

For the drivers:

* [Linux instruction](https://github.com/IntelRealSense/librealsense/blob/master/doc/distribution_linux.md))
* [ROS installation](https://github.com/IntelRealSense/realsense-ros#installation-instructions)
* [wiki ros](http://wiki.ros.org/RealSense) - The interesting pkg is the **realsense2_camera**

First you want to configure the software manager (`apt`) to follow Intel Realsense repository.

1. Register the server's public key:

```bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
#or, if you are on a restricted network with closed ports...
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
```

2. Then add the server to the list of repositories: 

```bash
sudo add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u
```

Now, you can easily install the libraries and tools:

```bash
sudo apt install \
    librealsense2-dkms \
    librealsense2-utils \
    librealsense2-dev \
    librealsense2-dbg
```

Connect the Intel RealSense depth camera and run: `realsense-viewer`.

Then you can install appropriate ROS packages

Ressources:


Installation:

```bash
sudo apt-get install \
    ros-noetic-librealsense2 \
    ros-noetic-realsense2-camera \
    ros-noetic-realsense2-description
    ros-noetic-depthimage-to-laserscan \
    ros-noetic-rqt \
    ros-noetic-rqt-image-view
```

Then you can launch the camera to publish the data into ROS topics:

```bash
roslaunch realsense2-camera rs_camera.launch
```

### Start a robot with the realsense

Switch-on a turtlebot and connect it to the machine.

Start ROS with the robot:

```bash
roslaunch turtlebot_bringup minimal.launch
```

Stop the programs (`ctrl-c`).

For a complete configuration: (turtlebot + laser + realsens...):

```bash
roslaunch tbot_bringup minimal.launch
```


## Gazebo simulation of tbot

```bash
roslaunch tbot_gazebo start_world.launch
roslaunch tbot_gazebo spawn_tbot.launch
```

### larm

```bash
roslaunch larm challenge-3.launch
```


# FAQ

## view_frames

There is a known bug in noetic: https://github.com/ros/geometry/pull/193

```
$ rosrun tf view_frames
Listening to /tf for 5.0 seconds
Done Listening
b'dot - graphviz version 2.43.0 (0)\n'
Traceback (most recent call last):
  File "/opt/ros/noetic/lib/tf/view_frames", line 119, in <module>
    generate(dot_graph)
  File "/opt/ros/noetic/lib/tf/view_frames", line 89, in generate
    m = r.search(vstr)
TypeError: cannot use a string pattern on a bytes-like object
```

Line 89 of `/opt/ros/noetic/lib/tf/view_frames`:

```python
m = r.search(vstr.decode('utf-8'))
```

```
sudo sed -i 's/m = r.search(vstr)/m = r.search(vstr.decode("utf-8"))/' /opt/ros/noetic/lib/tf/view_frames
```

## python error

Certains scripts utilisent :

```python
#!/usr/bin/env python
```

or `python` n'existe plus en ubuntu 20.04 et il faut privil�gier l'utilisation explicite de :

```python
#!/usr/bin/env python3
```

# TODO

- tbot rgbd visual model broken in rviz
