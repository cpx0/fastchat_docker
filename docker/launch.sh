#!/bin/bash -e

# TODO: User should be refactored instead of hard coded cpx

USER_NAME=cpx

docker run --gpus all -ti --init --rm \
    --hostname $(hostname) --name fastchat \
    --user $(id -u):$(id -g) \
    -p 5005:5005 -p 10000:10000 \
    ""--shm-size=16384m"" \
    -v $(pwd):/home/$USER_NAME/workspace \
    -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY \
    cpx0/fastchat:cu117-cudnn8-devel-ubuntu22

# docker-compose up --no-recreate
