
import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    tbot_sim_path = get_package_share_directory('tbot_sim')
    kobuki_urdf = os.path.join(tbot_sim_path,'urdf', 'kobuki_standalone.urdf')
    urdf = open(kobuki_urdf).read()

    return LaunchDescription([
        Node(
            package='tbot_start',
            executable='start_base',
            name="tbot_driver",
            output='screen'
        ),
        Node(
            package='ros1_bridge',
            executable='dynamic_bridge',
            name='bridge'
        ),
        Node(
            package='tbot_pytools',
            executable='multiplexer',
            name='multiplexer'
        ),
        Node(
            package='urg_node',
            executable='urg_node_driver',
            name='laser_range',
            parameters=[{
                "serial_port": "/dev/ttyACM0"
            }]
        ),
        Node(
            package='robot_state_publisher',
            executable='robot_state_publisher',
            name="robot_state_publisher",
            output='screen',
            parameters=[{'use_sim_time': 'false',
                'robot_description': urdf}]),
        Node(
            package='rviz2',
            executable='rviz2',
            name='visualization'
        )
    ])
