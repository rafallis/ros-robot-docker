# Running this image
# docker build -f ros-node0.dockerfile -t rafallis/ros-node0:0.1 .
# docker run --env="ROS_IP=10.5.0.6" --env="ROS_HOSTNAME=10.5.0.6" --env="ROS_MASTER_URI=http://200.0.0.5:11311" --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --device /dev/video1:/dev/video0 --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" -it --rm --name ros_node0 --net staticip --ip 200.0.0.6 rafallis/ros-node0:0.1 bash

FROM ros:melodic

LABEL Maintainer="Rafael Jardim rafaelfgjardim@gmail.com"

ENV ROS_SETUP=/opt/ros/melodic/setup.bash

RUN apt-get update \
    && apt-get install -q -y \
            build-essential \
            ros-melodic-rosbridge-server \
            ros-melodic-usb-cam \
            ros-melodic-turtlesim \
            ros-melodic-rqt \
            ros-melodic-rqt-common-plugins \
            ros-melodic-web-video-server \
    && rm -rf /var/lib/apt/lists/*

RUN mv /bin/sh /bin/sh-old \
    && ln -s /bin/bash bin/sh

EXPOSE 9090 11311 33690

ENTRYPOINT source ${ROS_SETUP}; roslaunch --wait usb_cam usb_cam-test.launch