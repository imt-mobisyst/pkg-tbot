# Extra dependencies:

About somme extra materials and ROSPackages:

## RealSense Camera:

### Install instruction

* [Linux instruction](https://github.com/IntelRealSense/librealsense/blob/master/doc/distribution_linux.md))

```sh
# RealSense:
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
sudo add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u

## Independant:
sudo apt install -y \
    librealsense2-dkms \
    librealsense2-utils \
    librealsense2-dev \
    librealsense2-dbg
```

### Install instruction Bis

* [Other Linux instruction](https://github.com/IntelRealSense))

Version based on [vcpkg](https://github.com/Microsoft/vcpkg) dependency manager:

- vcpkg:

```
cd
mkdir .local/app
cd .local/app
git clone https://github.com/Microsoft/vcpkg.git
cd vcpkg
./vcpkg/bootstrap-vcpkg.sh
```

- Some dependencies

```
sudo apt install autoconf dh-autoreconf libudev-dev
```


- The realsense:

```
./vcpkg/vcpkg install realsense2
```

Mais bon ça ne marche pas en 22.04 pour le moment...




### RealSense on ROS

For the drivers:

* [ROS installation](https://github.com/IntelRealSense/realsense-ros#installation-instructions)
* [wiki ros](http://wiki.ros.org/RealSense) - The interesting pkg is the **realsense2_camera**

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
