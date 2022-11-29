#!/usr/bin/env python3
## Doc: https://dev.intelrealsense.com/docs/python2

###############################################
##      Open CV and Numpy integration        ##
###############################################

import pyrealsense2 as rs
import time, numpy as np
import cv2

def imageWrite(image, text, position= (50,50)) :
    # font
    font = cv2.FONT_HERSHEY_SIMPLEX
    # org
    org = (50, 50)
    # fontScale
    fontScale = 1
    # Blue color in BGR
    color = (255, 0, 0)
    # Line thickness of 2 px
    thickness = 2
    # Using cv2.putText() method
    image = cv2.putText(image, text, position, font, fontScale, color, thickness, cv2.LINE_AA)
    return image

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

config.enable_stream(rs.stream.depth, 640, 480, rs.format.z16, 60)
config.enable_stream(rs.stream.color, 640, 480, rs.format.bgr8, 60)
config.enable_stream(rs.stream.accel)
config.enable_stream(rs.stream.gyro)

# Start streaming
pipeline.start(config)

try:
    count= 1
    refTime= time.process_time()
    freq= 60

    while True:

        # Wait for a coherent tuple of frames: depth, color and accel
        frames = pipeline.wait_for_frames()

        depth_frame = frames.first(rs.stream.depth) #frames.get_frame_number(0).as_depth_frame() # frames.get_depth_frame()
        color_frame = frames.first(rs.stream.color) #frames.get_frame_number(1).as_video_frame() # frames.get_color_frame()
        accel_frame = frames.first(rs.stream.accel).as_motion_frame() #frames.frames.get_frame_number(2)
        gyro_frame = frames.first(rs.stream.gyro).as_motion_frame() #frames.frames.get_frame_number(2)

        #print(f"{depth_frame} - {depth_frame.timestamp}")
        #print(f"{color_frame} - {color_frame.timestamp}")
        #print(f"{motion_frame} - {motion_frame.timestamp}")

        if not (depth_frame and color_frame and accel_frame and gyro_frame):
            continue
        
        # Convert images to numpy arrays
        depth_image = np.asanyarray(depth_frame.get_data())
        color_image = np.asanyarray(color_frame.get_data())

        # Apply colormap on depth image (image must be converted to 8-bit per pixel first)
        depth_colormap = cv2.applyColorMap(cv2.convertScaleAbs(depth_image, alpha=0.03), cv2.COLORMAP_JET)

        depth_colormap_dim = depth_colormap.shape
        color_colormap_dim = color_image.shape

        # IMU
        accel= accel_frame.get_motion_data()
        gyro= gyro_frame.get_motion_data()

        # Show images
        images = np.hstack((color_image, depth_colormap)) # supose that depth_colormap_dim == color_colormap_dim (640x480) otherwize: resized_color_image = cv2.resize(color_image, dsize=(depth_colormap_dim[1], depth_colormap_dim[0]), interpolation=cv2.INTER_AREA)
        images= imageWrite(images, f"{round(freq)} fps", (30, 30))
        images= imageWrite(images, f"accel: x: {round(accel.x, 2)}, y: {round(accel.y, 2)}, z: {round(accel.z, 2)}", (30, 60))
        images= imageWrite(images, f"gyro: x: {round(gyro.x, 2)}, y: {round(gyro.y, 2)}, z: {round(gyro.z, 2)}", (30, 90))

        # Show images
        cv2.namedWindow('RealSense', cv2.WINDOW_AUTOSIZE)
        cv2.imshow('RealSense', images)
        cv2.waitKey(1)
        
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
    
