#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
exec "$@"


cd ${CATKIN_WS} \
    && catkin_make \
    && source ${CATKIN_WS}/devel/setup.bash \
    && rosrun turtlesim turtle_teleop_key
