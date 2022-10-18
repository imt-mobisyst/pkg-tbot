# Extra dependencies:


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
roslaunch realsense2_camera rs_camera.launch
```

### Start a robot with the realsense

In a first shell::

```sh
./script/start-tbot.sh
```

In a second shell:

```sh
roslaunch realsense2_camera rs_camera.launch
```

```sh 
roslaunch tbot_tools rviz_camera


<!--
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
-->
