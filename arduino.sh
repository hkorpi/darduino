#!/bin/bash
# Starts the Arduino IDE using the docker image.
# see also: ...

#    -v /dev/ttyACM0:/dev/ttyACM0 \
#    -v /dev/ttyUSB0:/dev/ttyUSB0 \
docker run \
    -it \
    --rm \
    --network=host \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --device=/dev/ttyACM1 \
    -v $HOME/research/arduino:/home/developer/Arduino \
    -v $HOME/.arduino15:/home/developer/.arduino15 \
    --name arduino \
    hkorpi/darduino \
    arduino

