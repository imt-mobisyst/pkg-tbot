# MobiSyst - TBot

This project is a ROS Catkin package that includes usefull elements for turtlebot2 robots in the IMT Nord-Europe configuration (tbot).

Last system version: **Ubuntu 20.04 lts** / **ROS neotic**.

Thanks:

- [gaunthan for Turtlebot2 on Melodic](https://github.com/gaunthan/Turtlebot2-On-Melodic)
- [TheConstruct](https://www.theconstructsim.com/) the virtualisation and the simulation environment they provide.


## Installation

The `tbot` project requires several dependencies mostly relying on Docker and ROS to load turtlebot-kobuki ROS driver in a virtual environment and add some usefull ROS packages (laser, ros2-bridge...). 

However to shortcut the installation process you can execute the install script (supose that ROS Neotic is already installed): 


**PiBot install:** 

Tbot is designed to work on a Raspberry-Pi3. To configure the Pi3 beffore to install tbot,
please refers to [./doc/install-pibot.md](install-pibot.md).
Otherwise you can overpass this step.

**In short:** [./script/install.sh](install.sh)

By considering that curl and git are installed, you can just execute the folloowing command in your favorit shell:

```sh
curl -k https://bitbucket.org/imt-mobisyst/mb6-tbot/raw/master/script/install.sh | bash
```

This script will install dependencies, clone the repo, generate the docker image and compile the tbot packages.

**In detail:** 

A detailled install porcedure is proposed here: [./doc/install.md](install.md).

**Extra:** 

Tbot can take advantage of different extra-dependancy, tically the Realsence-camera, the kokuyo laser range, simulation configuration...
The install procedures and more information on [./doc/install-extra.md](install-extra.md).

## Getting started

Start kobuki: 

1. Connect and switch-on the turtlebot-kobuki
2. Start the docker: `./script/start-tbot.sh &`
3. Teleop the robot: `rosrun teleop_twist_keyboard teleop_twist_keyboard.py cmd_vel:=/mobile_base/commands/velocity`
4. Stop the teleop (`ctrl-c`).



---

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
