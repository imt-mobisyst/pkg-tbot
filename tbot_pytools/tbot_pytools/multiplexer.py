#!python3
import time, rclpy
from rclpy.node import Node

from geometry_msgs.msg import Twist

class Multiplexer(Node):

    def __init__( self, MsgType= Twist, inTopics=['/multi/cmd_nav', '/multi/cmd_teleop'], outTopics=['/cmd_vel', '/mobile_base/commands/velocity'] ):
        super().__init__('multiplexer')
        callbacks= [
            self.cmd_1_callback, self.cmd_2_callback, self.cmd_3_callback, self.cmd_4_callback,
            self.cmd_5_callback, self.cmd_6_callback, self.cmd_7_callback, self.cmd_8_callback
        ]
        callbacks= callbacks[:len(inTopics)]
        for topic, callback in zip(inTopics, callbacks) :
            self.create_subscription( MsgType, topic, callback, 10)
        self.create_timer(0.1, self.cmd_0)
        self.hand= 0
        self.t= time.time()

        self.myPublishers= []
        for topic in outTopics :
            self.myPublishers.append( self.create_publisher( MsgType, topic, 10) )

    def cmd_callback(self, prevalence, cmdMsg):
        t= time.time()
        if prevalence >= self.hand or t - self.t > 1.0 :
            if prevalence > self.hand :
                self.get_logger().info( f"Get cmd from {prevalence}" )
            self.hand= prevalence
            self.t= t
            for p in self.myPublishers :
                p.publish( cmdMsg )

    def cmd_0(self):
        velo= Twist()
        return self.cmd_callback(0, velo)

    def cmd_1_callback(self, cmdMsg):
        return self.cmd_callback(1, cmdMsg)
    
    def cmd_2_callback(self, cmdMsg):
        return self.cmd_callback(2, cmdMsg)

    def cmd_3_callback(self, cmdMsg):
        return self.cmd_callback(3, cmdMsg)

    def cmd_4_callback(self, cmdMsg):
        return self.cmd_callback(4, cmdMsg)

    def cmd_5_callback(self, cmdMsg):
        return self.cmd_callback(5, cmdMsg)

    def cmd_6_callback(self, cmdMsg):
        return self.cmd_callback(6, cmdMsg)

    def cmd_7_callback(self, cmdMsg):
        return self.cmd_callback(7, cmdMsg)

    def cmd_8_callback(self, cmdMsg):
        return self.cmd_callback(8, cmdMsg)

def multiplexer(args=None):
    # Initialize ROS
    rclpy.init(args=args)

    # Initialize ScanInterperter
    node = Multiplexer()
    
    # infinite Loop
    rclpy.spin(node)
    
    # Clean end
    node.destroy_node()
    rclpy.shutdown()
