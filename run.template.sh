#!/usr/bin/env bash
HOSTNAME="DebCCPP"
HOST_PATH_1="/PATH/TO/HOST/WORKDIR"
DOCKER_PATH_1="/workspace"

docker run -ti \
    --hostname ${HOSTNAME} \
    --volume ${HOST_PATH_1}:${DOCKER_PATH_1} \
    -e LOCAL_USER_ID=`id -u $USER` \
    -e LOCAL_GROUP_ID=`id -g $USER` \
    debccpp:latest
