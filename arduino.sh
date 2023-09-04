#!/bin/bash
# Starts the Arduino IDE using the docker image.

set -e
cd $(dirname $0)
workdir=$(dirname $0)

docker run \
    --rm --init \
    --cap-drop ALL \
    --security-opt no-new-privileges \
    --shm-size=2gb \
    -e DISPLAY=$DISPLAY \
    --tmpfs /run/dbus \
    --mount type=bind,source='/tmp/.X11-unix/X0',target='//tmp/.X11-unix/X0',readonly \
    -v "${workdir}/developer:/home/developer" \
    -v "$HOME/research/arduino:/home/developer/Arduino" \
    -v "$HOME/research/irrigation/arduino:/home/developer/Arduino/irrigation" \
    --device=/dev/ttyACM1 \
    --name arduino \
    hkorpi/darduino \
    /opt/arduino-ide-2.2.1/start.sh
