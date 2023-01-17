from setuptools import setup

package_name = 'tbot_pytools'

setup(
    name=package_name,
    version='0.0.0',
    packages=[package_name],
    requires=['rospy','geometry_msgs','tf2_ros','tf2_geometry_msgs'],
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='bot',
    maintainer_email='bot@mb6.imt-nord-europe.fr',
    description='TODO: Package description',
    license='TODO: License declaration',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'multiplexer = tbot_pytools.multiplexer:multiplexer',
            'rmove = tbot_pytools.reactive_move:move',
            'camera = tbot_pytools.realsense:process_img',
            'goal_keeper = tbot_pytools.posetransform:process_keeper',
            'tf_tester = tbot_pytools.posetransform:process_test'
        ],
    },
)
