#!/bin/bash
# Starts the Arduino IDE using the docker image.

set -e
cd $(dirname $0)
workdir=$(dirname $0)

docker run \
    --rm --init \
    --cap-drop ALL \
    --network=host \
    -e DISPLAY=$DISPLAY \
    --mount type=bind,source='/tmp/.X11-unix/X0',target='//tmp/.X11-unix/X0',readonly \
    --device=/dev/ttyACM1 \
    -v "${workdir}/developer:/home/developer" \
    -v "$HOME/research/arduino:/home/developer/Arduino" \
    --name arduino \
    hkorpi/darduino-1.8 \
    arduino

