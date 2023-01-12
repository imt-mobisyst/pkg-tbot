#!/bin/bash

# sudo apt install -y ros-humble-ecl-build

# cd ~/ros2_ws/

git clone -b humble https://github.com/ros/diagnostics.git
cd diagnostics && git checkout b0f508f9194abe50d87cd65024ce18253e68789c && cd ..

git clone -b devel https://github.com/stonier/ecl_core.git
cd ecl_core && git checkout 9d1c49c882c57668f3c46adb2a1a38c2d0957e59 && cd ..

git clone -b devel https://github.com/stonier/ecl_lite.git
cd ecl_lite && git checkout f9b8aa04c97ea332ae8ea7e052a31f7ec2670c9a && cd ..

git clone -b devel https://github.com/kobuki-base/kobuki_core.git
cd kobuki_core && git checkout e2f0feac0f7a9964d021ac3241b7663f7728d5b9 && cd ..

git clone -b devel https://github.com/kobuki-base/kobuki_ros.git
cd kobuki_ros && git checkout a54e89226bc5b6d6b623ee2b1a50632ff5a781e4 && cd ..

git clone -b devel https://github.com/kobuki-base/kobuki_ros_interfaces.git
cd kobuki_ros_interfaces && git checkout 7711d4fbec13c69bcf6477ce8e446c3ccca33113 && cd ..

git clone -b master https://github.com/strasdat/Sophus.git
cd Sophus && git checkout caf27cf918b180852f55e4395139aa30397ed0a2 && cd ..

# cd ~/ros2_ws/
# colcon build

