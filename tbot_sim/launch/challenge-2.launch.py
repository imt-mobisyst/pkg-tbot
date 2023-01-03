#!/usr/bin/env python3

import os
from launch import LaunchDescription
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import ThisLaunchFileDir,LaunchConfiguration
from launch_ros.actions import Node
from launch_ros.substitutions import FindPackageShare

def generate_launch_description():
    use_sim_time = LaunchConfiguration('use_sim_time', default='true')

    pkg_gazebo_ros = FindPackageShare(package='gazebo_ros').find('gazebo_ros')
    gazebo = IncludeLaunchDescription(
                PythonLaunchDescriptionSource([os.path.join(pkg_gazebo_ros, 'launch'), '/gazebo.launch.py']),
            )

    # Set the path to the SDF model files.
    pkg_tbot_sim = FindPackageShare(package='tbot_sim').find('tbot_sim')
    gazebo_models_path = os.path.join(pkg_tbot_sim, 'models')
    os.environ["GAZEBO_MODEL_PATH"] = gazebo_models_path

    # GAZEBO_MODEL_PATH has to be correctly set for Gazebo to be able to find the model
    willowgarage_entity = Node(package='gazebo_ros', executable='spawn_entity.py',
                        arguments=['-entity', 'willowgarage', '-database', 'willowgarage'],
                        output='screen')

    robot_entity = Node(package='gazebo_ros', executable='spawn_entity.py',
                        arguments=['-entity', 'tbot', '-database', 'tbot'],
                        output='screen')

    laser_link = Node(package = "tf2_ros", 
                       executable = "static_transform_publisher",
                       arguments = ["0.115", "0", "0.13", "0", "0", "0", "base_link", "laser_link"])

    camera_link = Node(package = "tf2_ros", 
                       executable = "static_transform_publisher",
                       arguments = ["0.0", "0", "0.3", "0", "0", "0", "base_link", "camera_link"])

    return LaunchDescription([
        declare_world_cmd,
        gazebo,
        robot_entity,
        laser_link,
        camera_link
    ])

