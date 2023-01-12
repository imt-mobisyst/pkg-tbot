
import os
import yaml
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import IncludeLaunchDescription
from launch_ros.actions import Node
from launch.launch_description_sources import PythonLaunchDescriptionSource

def generate_launch_description():
    tbot_start_path = get_package_share_directory('tbot_start')
    tbot_start_launch_dir = os.path.join(tbot_start_path, 'launch')

    kobuki_urdf = os.path.join(get_package_share_directory('tbot_sim'),'urdf', 'tbot.urdf')
    urdf = open(kobuki_urdf).read()

    return LaunchDescription([
        IncludeLaunchDescription(
            PythonLaunchDescriptionSource([tbot_start_launch_dir, '/base.launch.py'])
        ),
        Node(
            package='urg_node',
            executable='urg_node_driver',
            name='laser_range',
            parameters=[{
                "serial_port": "/dev/ttyACM0",
                "laser_frame_id": "laser_link",
            }]
        ),
        Node(
            package='robot_state_publisher',
            executable='robot_state_publisher',
            name="robot_state_publisher",
            output='screen',
            parameters=[{'use_sim_time': False,
                'robot_description': urdf}]),
        # Node(
        #     package='rviz2',
        #     executable='rviz2',
        #     name='visualization'
        # )
    ])
