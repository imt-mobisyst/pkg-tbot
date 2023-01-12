
import os
import yaml
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    # kobuki_urdf = os.path.join(get_package_share_directory('tbot_sim'),'urdf', 'kobuki_standalone.urdf')
    # urdf = open(kobuki_urdf).read()

    share_dir = get_package_share_directory('kobuki_node')
    params_file = os.path.join(share_dir, 'config', 'kobuki_node_params.yaml')
    with open(params_file, 'r') as f:
        params = yaml.safe_load(f)['kobuki_ros_node']['ros__parameters']

    return LaunchDescription([
        Node(package='kobuki_node',
            executable='kobuki_ros_node',
            output='both',
            parameters=[params]),
        Node(
            package='tbot_pytools',
            executable='multiplexer',
            name='multiplexer',
            remappings=[
                ("cmd_vel", "commands/velocity")
            ]),
        # Node(
        #     package='rviz2',
        #     executable='rviz2',
        #     name='visualization'
        # )
    ])
