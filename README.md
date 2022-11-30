# MobiSyst - TBot

This project is a ROS Catkin package that includes usefull elements for turtlebot2 robots in the IMT Nord-Europe configuration (**tbot**).

Last system version: **Ubuntu 20.04 lts** / **ROS neotic**.

Also, **tbot** is designed to work on a Raspberry-Pi3.
To configure the Pi3 before to install **tbot**, please refers to [mb6-playload](https://www.bitbucket.org/imt-mobisyst/mb6-playload) project.
Otherwise you can overpass this step.

## Installation

The **tbot** project requires several dependencies mostly relying on Docker and ROS to load turtlebot-kobuki ROS driver in a virtual environment and add some usefull ROS packages (laser, ros2-bridge...). 

However to shortcut the installation process you can execute the install script (supose that ROS Neotic is already installed): 

**In short:** [./script/install.sh](install.sh)

By considering that curl and git are installed, you can just execute the folloowing command in your favorit shell:

```sh
sudo apt update
sudo apt install openssh-server curl
# Potentially: log with ssh, then
curl -k https://bitbucket.org/imt-mobisyst/mb6-tbot/raw/master/script/install.sh | bash
```

This script will install dependencies, configure git, clone the repo, generate the docker image and compile the **tbot** packages.


**In detail:** 

A detailled install porcedure is proposed here: [./doc/install.md](install.md).


## Getting started

Test kobuki: 

1. Connect and switch-on the turtlebot-kobuki
2. Start the docker in a first terminal: `./script/start-tbot.sh`
3. Launch a brdge between ROS1 and ROS2 in a second terminal: `source /opt/ros/noetic/setup.sh & ros2 run ros1_bridge dynamic_bridge`
3. Teleop the robot, in a third terminal: `ros2 run teleop_twist_keyboard teleop_twist_keyboard.py cmd_vel:=/mobile_base/commands/velocity`
4. Stop each process (`ctrl-c`).
