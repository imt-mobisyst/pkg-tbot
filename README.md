# MobiSyst - TBot

This project is a ROS package that includes usefull elements for turtlebot2 robots in the IMT Nord-Europe configuration (**tbot**).

Last system version: **Ubuntu 20.04 lts** / **ROS1 neotic** + **ROS2 foxy** 

Also, **tbot** is designed to work on a Raspberry-Pi3.
To configure the Pi3 before to install **tbot**, please refers to [mb6-playload](https://www.bitbucket.org/imt-mobisyst/mb6-playload) project.
Otherwise you can overpass this step.

## Installation

The **tbot** project requires several dependencies mostly relying on Docker and ROS to load turtlebot-kobuki ROS driver in a virtual environment and add some usefull ROS packages (laser, ros2-bridge...). 

However to shortcut the installation process you can execute the install script (supose that ROS Neotic is already installed): 

**Full install:** [./script/install-full.sh](script/install-full.sh)

From a fresh Ubuntu 20.04 instal, you can just execute the following commands in your favorit shell:

```sh
sudo apt update
sudo apt install openssh-server curl
# Potentially: log with ssh, then
curl -k https://bitbucket.org/imt-mobisyst/mb6-tbot/raw/master/script/install-full.sh | bash
```

This script will install dependencies, configure git, clone the repo, generate the docker image and compile the **tbot** packages.

**In short:**

If the environnement is already set (ROS etc...), you can just clone and build the project as a ROS package.

```sh
git clone https://bitbucket.org/imt-mobisyst/mb6-tbot src/tbot
cd src/tbot
./script/build.sh
```

**In detail:** 

A manual detailled install porcedure is proposed here: [./docs/install.md](docs/install.md).


## Getting started

Test kobuki: 

1. Update your shell environnement: `source /opt/ros/foxy/setup.bash & source ../../install/setup.bash`
1. Connect and switch-on the turtlebot-kobuki
2. Start the docker in a $1st$ terminal: `ros2 run tbot_start start`
2. Start the hokuyo-laser driver in a $2d$ terminal: `source /opt/ros/foxy/setup.bash & ros2 run urg_node urg_node_driver --ros-args -p serial_port:=/dev/ttyACM0`
3. Launch a bridge between ROS1 and ROS2 in a $3d$ terminal: `source /opt/ros/noetic/setup.bash & source /opt/ros/foxy/setup.sh & ros2 run ros1_bridge dynamic_bridge`
3. Teleop the robot, in a $4th$ terminal: `source /opt/ros/foxy/setup.bash & ros2 run teleop_twist_keyboard teleop_twist_keyboard --ros-args --remap cmd_vel:=/mobile_base/commands/velocity`
4. Stop processes (in each terminal: `ctrl-c`).
