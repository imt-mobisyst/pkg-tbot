
import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import ExecuteProcess, Shutdown
from launch_ros.actions import Node

def generate_launch_description():
    kobuki_urdf = os.path.join(get_package_share_directory('tbot_sim'),'urdf', 'kobuki_standalone.urdf')
    urdf = open(kobuki_urdf).read()
    tbot_start_script = os.path.join(get_package_share_directory('tbot_start'), '../../lib/tbot_start/start_base')

    # env = {
    #     'GAZEBO_MODEL_PATH': model,
    #     'GAZEBO_PLUGIN_PATH': plugin,
    #     'GAZEBO_RESOURCE_PATH': media,
    # }

    return LaunchDescription([
        ExecuteProcess(
            cmd = [
                'sudo docker run --rm --privileged --network host lozenge14/imt-mobisyst:u16kobuki bash start_ros.bash'
                # tbot_start_script
            ],
            output='screen',
            # additional_env=env,
            shell=True,
            on_exit=Shutdown()
        ),

        # Node(
        #     package='ros1_bridge',
        #     executable='dynamic_bridge',
        #     name='bridge'
        # ),
        # Node(
        #     package='tbot_pytools',
        #     executable='multiplexer',
        #     name='multiplexer'
        # ),
        # Node(
        #     package='urg_node',
        #     executable='urg_node_driver',
        #     name='laser_range',
        #     parameters=[{
        #         "serial_port": "/dev/ttyACM0"
        #     }]
        # ),
        # Node(
        #     package='robot_state_publisher',
        #     executable='robot_state_publisher',
        #     name="robot_state_publisher",
        #     output='screen',
        #     parameters=[{'use_sim_time': 'false',
        #         'robot_description': urdf}]),
        # Node(
        #     package='rviz2',
        #     executable='rviz2',
        #     name='visualization'
        # )
    ])
