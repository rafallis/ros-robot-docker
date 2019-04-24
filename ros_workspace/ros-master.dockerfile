# This command give to Docker the rights to access X-Server 
# xhost +local:docker
#
# Running this image
# docker build -f ros-master.dockerfile -t rafallis/ros-master:0.1 .
# docker run --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" -it --rm --name ros_master --net staticip --ip 200.0.0.5 rafallis/ros-master:0.1 bash

FROM ros:melodic

LABEL Maintainer="Rafael Jardim rafaelfgjardim@gmail.com"

ENV CATKIN_WS=/root/catkin_ws
ENV ROS_SETUP=/opt/ros/melodic/setup.bash

RUN apt-get update \
    && apt-get install -q -y \
            build-essential \
            ros-melodic-rosbridge-server \
            ros-melodic-image-transport-plugins \
            ros-melodic-compressed-image-transport \
            ros-melodic-catkin \
            ros-melodic-turtlesim \
            ros-melodic-rqt \
            ros-melodic-rqt-common-plugins \
            ros-melodic-web-video-server \
    && rm -rf /var/lib/apt/lists/*

RUN mv /bin/sh /bin/sh-old \
    && ln -s /bin/bash bin/sh

RUN source ${ROS_SETUP} \
    && mkdir -p ${CATKIN_WS}/src \
    && cd ${CATKIN_WS}/src \
    && catkin_init_workspace

# ADD master/pnk ${CATKIN_WS}/src/

RUN source ${ROS_SETUP} \
    && cd ${CATKIN_WS} \
    && catkin_make \
    && source ${CATKIN_WS}/devel/setup.bash

EXPOSE 9090 11311 33690

ENTRYPOINT source /opt/ros/melodic/setup.bash; roscore