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
            name='multiplexer',
            remappings=[
                ("cmd_vel", "mobile_base/commands/velocity")
            ]),
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
            package='rviz2',
            executable='rviz2',
            name='visualization'
        )
    ])


# $ ros2 topic list
# /clicked_point
# /cmd_vel
# /diagnostics
# /goal_pose
# /initialpose
# /laser_status
# /mobile_base/commands/velocity
# /multi/cmd_nav
# /multi/cmd_teleop
# /parameter_events
# /rosout
# /scan
# /tf
# /tf_static

