#!/bin/sh

xhost +

# Users home is mounted as home
# --rm will remove the container as soon as it ends
docker run --rm \
    -i -t \
    -v ${HOME}:/home/${USER} \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY \
    timcera/qgis-desktop:master

xhost -


