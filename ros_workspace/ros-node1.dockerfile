FROM ros:melodic

LABEL Maintainer="Rafael Jardim rafaelfgjardim@gmail.com"

RUN apt-get update \
    && apt-get install -q -y build-essential ros-melodic-rosbridge-server

RUN mv /bin/sh /bin/sh-old \
    && ln -s /bin/bash bin/sh

ENV CATKIN_WS=/root/catkin_ws

RUN source /opt/ros/melodic/setup.bash \
    && mkdir -p ${CATKIN_WS}/src \
    && cd ${CATKIN_WS}/src \
    && catkin_init_workspace

ADD publisher/cam_pub ${CATKIN_WS}/src/

RUN cd ${CATKIN_WS} \
    && catkin_make \
    && source ${CATKIN_WS}/devel/setup.bash

EXPOSE 9090 11311 33690

ENTRYPOINT source /opt/ros/melodic/setup.bash; rosrun cam_pub cam_pub_node /dev/video0