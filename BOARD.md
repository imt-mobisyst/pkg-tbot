# TBot projet board:


## ToDo:

- Update `tuto-generate-tbot.md` to ROS2-Foxy
- pibot: configure ethernet ROS2 connection.
- Pibot: setup a startscript...
- Pibot: capture button or something to shutdown...
- Investigate AndroidPhone Camera.
	+ DroidCam (android app turning the phone on Ip Camera) - https://www.dev47apps.com
	+ V4L2Loopback Turning any video source on a virtual PlugAndPlay cam. Tuto: https://arcoresearchgroup.wordpress.com/2020/06/02/virtual-camera-for-opencv-using-v4l2loopback/
- Test for ORB-SLAM2...
- Make multi-domains nodes (with tow level of domain: ID-robot and ID-coop).
- Investigate Geometric/Robotic librairies:
	- raylib/rmath
	- https://www.roboticslibrary.org
    - geos - https://libgeos.org

## Cross compiling tbot driver

```
sudo apt install docker-buildx
sudo apt-get install qemu binfmt-support qemu-user-static
sudo adduser `whoami` docker
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
# docker run --rm -t arm64v8/ros:iron uname -m

cd
git clone git@bitbucket.org:imt-mobisyst/mb6-space.git

docker run -it --name ros2arm -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static  -v `pwd`/mb6-space:/root/mb6-space --platform linux/arm64  arm64v8/ros:iron bash

sudo apt update
sudo apt install -y \
    ros-$ROS_DISTRO-angles\
    ros-$ROS_DISTRO-ecl-command-line\
    ros-$ROS_DISTRO-ecl-console\
    ros-$ROS_DISTRO-ecl-devices\
    ros-$ROS_DISTRO-ecl-geometry\
    ros-$ROS_DISTRO-ecl-mobile-robot\
    ros-$ROS_DISTRO-ecl-sigslots\
    ros-$ROS_DISTRO-ecl-threads\
    ros-$ROS_DISTRO-diagnostic-updater\
    ros-$ROS_DISTRO-diagnostic-msgs\
    ros-$ROS_DISTRO-rosidl-typesupport-c\
    ros-$ROS_DISTRO-ament-cmake-ros

echo "export PYTHONPATH='/opt/ros/iron/lib/python3.10/site-packages'" >> ../.bashrc
source ~/.bashrc
```

Before compiling, you should fix the line 255 of `/opt/ros/iron/ecl_build/cmake/ecl_platform_detection.cmake`
(cf. https://github.com/stonier/ecl_tools/pull/12/files):

```
- include(FindThreads)
+ find_package(Threads)
```

Then, compile :

```
cd ~/mb6-space
# [OK] colcon build --packages-select kobuki_core
# [OK] colcon build --packages-select kobuki_ros_interfaces
# [OK] colcon build --packages-select kobuki_node kobuki_ros
colcon build
```

Compiled packages are in `~/mb6-space/install` and can be deployed elsewhere (on pi)
