#!/usr/bin/env python3

import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument, IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration, Command
from launch_ros.actions import Node

def generate_launch_description():
    use_sim_time = LaunchConfiguration('use_sim_time', default='true')
    
    # Set the path to this package.
    pkg_share = get_package_share_directory('tbot_sim')
    
    # Set the path to the world file
    world_file_name = 'challenge-1.world'
    world_path = os.path.join(pkg_share, 'worlds', world_file_name)
    world = LaunchConfiguration('world')

    declare_world_cmd = DeclareLaunchArgument(
        name='world',
        default_value=world_path,
        description='Full path to the world model file to load')

    pkg_gazebo_ros = get_package_share_directory('gazebo_ros')      
    gazebo = IncludeLaunchDescription(
                PythonLaunchDescriptionSource([os.path.join(pkg_gazebo_ros, 'launch'), '/gazebo.launch.py']),
            )
    
    # Set the path to the SDF model files.
    gazebo_models_path = os.path.join(pkg_share, 'models')
    os.environ["GAZEBO_MODEL_PATH"] = gazebo_models_path

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

