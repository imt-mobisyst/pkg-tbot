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

Tbot is designed to work on a Raspberry-Pi3. To configure the Pi3 before to install tbot, please refers to [mb6-playload](https://www.bitbucket.org/imt-mobisyst/mb6-playload) project.
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


## FAQ

### view_frames

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

### python error

Certains scripts utilisent :

```python
#!/usr/bin/env python
```

or `python` n'existe plus en ubuntu 20.04 et il faut privilégier l'utilisation explicite de :

```python
#!/usr/bin/env python3
```
