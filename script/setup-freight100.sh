#!/bin/bash
# To source...

# Configure Freight100 as master:
export export ROS_MASTER_URI=http://freight100.local:11311
export export ROS_HOSTNAME=`hostname`.local

echo Master URI: $ROS_MASTER_URI
echo Local hostname: $ROS_HOSTNAME
