#!/usr/bin/env python3
## Doc: https://dev.intelrealsense.com/docs/python2

###############################################
##      Open CV and Numpy integration        ##
###############################################

import pyrealsense2 as rs
import time, numpy as np
import sys

# Configure depth and color streams
pipeline = rs.pipeline()
config = rs.config()

# Get device product line for setting a supporting resolution
pipeline_wrapper = rs.pipeline_wrapper(pipeline)
pipeline_profile = config.resolve(pipeline_wrapper)
device = pipeline_profile.get_device()
device_product_line = str(device.get_info(rs.camera_info.product_line))

print( f"Connect: {device_product_line}" )

found_rgb = False
found_motion = False
for s in device.sensors:
    print( "Name:" + s.get_info(rs.camera_info.name) )
    if s.get_info(rs.camera_info.name) == 'RGB Camera':
        found_rgb = True
    if s.get_info(rs.camera_info.name) == 'Motion Module':
        found_motion = True
        
if not (found_rgb or found_motion):
    print("Depth camera with motion module required !!!")
    exit(0)

config.enable_stream(rs.stream.accel)
config.enable_stream(rs.stream.gyro)

# Start streaming
pipeline.start(config)

try:
    count= 1
    refTime= time.process_time()
    freq= 60

    sys.stdout.write( f"-" ) 
    while True:

        # Wait for a coherent tuple of frames: depth, color and accel
        frames = pipeline.wait_for_frames()
        
        accel_frame = frames.first(rs.stream.accel).as_motion_frame()
        gyro_frame = frames.first(rs.stream.gyro).as_motion_frame()

        if not (accel_frame and gyro_frame):
            continue

        # IMU
        accel= accel_frame.get_motion_data()
        gyro= gyro_frame.get_motion_data()

        # Print
        sys.stdout.write( f"\r- accel: x: {round(accel.x, 2)}, y: {round(accel.y, 2)}, z: {round(accel.z, 2)} -\tgyro: x: {round(gyro.x, 2)}, y: {round(gyro.y, 2)}, z: {round(gyro.z, 2)}({round(freq)} fps)      " )
        
        # Frequency:
        if count == 10 :
            newTime= time.process_time()
            freq= 10/((newTime-refTime))
            refTime= newTime
            count= 0
        count+= 1

finally:
    # Stop streaming
    print("\nEnding...")
    pipeline.stop()
    
