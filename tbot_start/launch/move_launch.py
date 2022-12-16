from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    return LaunchDescription([
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
        )
    ])
