#!python3
import time, rclpy
from rclpy.node import Node
import tf2_ros, tf2_geometry_msgs
from geometry_msgs.msg import Pose, PoseStamped

class LocalGoal(Node):
    def __init__(self):
        super().__init__('goal_keeper')
        # Transform tool:
        self.tf_buffer = tf2_ros.Buffer()
        self.tf_listener = tf2_ros.TransformListener(self.tf_buffer, self)
        # Node Attribute:
        self.local_frame= 'base_link'
        self.global_goal= Pose()
        self.global_goal.position.x= (float)(1)
        self.global_goal.position.y= (float)(2)
        # Local Goal Publisher:
        self.create_timer(0.1, self.publish_goal)
        self.goalPublisher= self.create_publisher( PoseStamped, 'local_goal', 10)

    def publish_goal(self):
        currentTime= rclpy.time.Time().to_msg()
        stampedTransform= None
        # Get Transformation
        try:
            stampedTransform= self.tf_buffer.lookup_transform(
                        self.local_frame,
                        'odom',
                        currentTime)
        except tf2_ros.TransformException as tex:
            self.get_logger().info( f'Could not transform the goal into {self.local_frame}: {tex}')
            return
        
        # Compute goal in local coordinates
        stampedGoal= PoseStamped()
        stampedGoal.pose= self.global_goal
        stampedGoal.header.frame_id= 'odom'
        stampedGoal.header.stamp= currentTime
        localGoal = tf2_geometry_msgs.do_transform_pose( stampedGoal, stampedTransform )
        # Publish
        self.goalPublisher.publish(localGoal)

def process_keeper(args=None):
    # Initialize ROS
    rclpy.init(args=args)

    # Initialize ScanInterperter
    node = LocalGoal()
    
    # infinite Loop
    rclpy.spin(node)
    
    # Clean end
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__' :
    process_keeper()