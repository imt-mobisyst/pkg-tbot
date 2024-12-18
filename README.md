# MobiSyst - TBot

This project is a ROS package that includes usefull elements for turtlebot2 robots in the IMT Nord-Europe configuration (**tbot**).

Last system version: **Ubuntu 22.04 lts** / **ROS2 iron** 

Also, **tbot** is designed to work on a Raspberry-Pi3 (pibotXX configuration).
To configure the Pi3 before to install **tbot**, please refers to [mb6-space](https://www.bitbucket.org/imt-mobisyst/mb6-space) project.
Otherwise you can overpass this step.

**tbot** is developped on top of `kobuki`. 
Used materials can be found by cloning those repos: 

- [kobuki_core](https://github.com/kobuki-base/kobuki_core)
- [kobuki_ros](https://github.com/kobuki-base/kobuki_ros)

Those packages rely on :

- [kobuki_ros_interfaces](https://github.com/kobuki-base/kobuki_ros_interfaces) forked on [imt-mobisyst/pkg-interfaces](https://github.com/imt-mobisyst/pkg-interfaces)


However, initial `kobuki` relies on `ecl` packages and indirectly on `sophus` package. 
Those dependancies have some comflics easely removable by removing `set(CMAKE_NO_SYSTEM_FROM_IMPORTED TRUE)` in the instruction list of kobuki CMake files.



## Installation

To notice the existnce of an [install](./bin/install) script.

Like we said, kobuki and then **tbot** relies on some `ecl` packages. 
The robot also need the `urg_node` form the ROS `urg_node` package for the laser range.
See [install](./bin/install) script for a detailled list of packages to install.

Now you have to configure `udev` to recognize kobuki robot and permits the user to access laser data.

```sh
sudo cp ./kobuki_core/60-kobuki.rules /lib/udev/rules.d/
sudo usermod -a -G dialout `whoami`
```

You can build, and configure your shell with the new elelements: 

```sh
./bin/build
source ../install/setup.bash
```

# Get started

The node `kobuki_ros_node` from `kobuki_node` match the minimal control node to communicate with the robot sensors and actuators (i.e  through the USB entrance point remapped as kobuki in udev rules).

```sh
# In a first terminal
ros2 run kobuki_node kobuki_ros_node --ros-args -p device_port:=/dev/kobuki

# In a seond terminal
ros2 topic list 
# Ctrl-c
ros2 run teleop_twist_keyboard teleop_twist_keyboard --ros-args -r /cmd_vel:=/commands/velocity
```

Launch files in `tbot_node` package permit to start the robot with complete configuration (laser, transforms and safe multiplexer).

```sh
# In a first terminal
ros2 launch tbot_node minimal_launch.yaml
```


From that point it is preferable to sent command instruction into `/multi/cmd_nav` or `/multi/cmd_teleop` (operator teleop get an higher priority)

```sh
# In a seond terminal
ros2 topic list 
# Ctrl-c
ros2 run teleop_twist_keyboard teleop_twist_keyboard --ros-args -r /cmd_vel:=/multi/cmd_teleop
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

or `python` n'existe plus en ubuntu 20.04 et il faut privilégier l'utilisation explicite de python3 :

```python
#!/usr/bin/env python3
```

# TODO

- tbot rgbd visual model broken in rviz
