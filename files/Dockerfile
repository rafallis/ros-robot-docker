FROM ros:melodic

LABEL Maintainer="Rafael Jardim rafaelfgjardim@gmail.com"

RUN apt-get update \
    && apt-get install -q -y build-essential

RUN rm /bin/sh \
    && ln -s /bin/bash bin/sh

ENV CATKIN_WS=/root/catkin_ws

RUN source /opt/ros/melodic/setup.bash \
    && mkdir -p ${CATKIN_WS}/src \
    && cd ${CATKIN_WS}/src \
    && catkin_init_workspace

ADD cam_pub ${CATKIN_WS}/src/

RUN cd ${CATKIN_WS} \
    && catkin_make \
    && source ${CATKIN_WS}/devel/setup.bash

ENTRYPOINT source /opt/ros/melodic/setup.bash \
            && catkin_make