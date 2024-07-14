FROM ubuntu:22.04

ARG UID=1000
ARG GID=1000
ARG ARDUINO_IDE_VERSION=2.2.1

ENV HOME=/home/developer
WORKDIR /home/developer

# install dependencies
RUN apt-get update && \ 
    apt-get install -y \
      wget unzip xz-utils \
      libgl1 dbus \
      libx11-xcb1 libglib2.0-0 libxshmfence1 libnss3 libatk1.0-0 libatk-bridge2.0-0 libdrm2 libgtk-3-0 libgbm1 libasound2 libsecret-1-0 libxkbfile1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install arduino ide
ENV ARDUINO_IDE_VERSION=$ARDUINO_IDE_VERSION
RUN cd /opt \
      && wget -q "https://downloads.arduino.cc/arduino-ide/arduino-ide_${ARDUINO_IDE_VERSION}_Linux_64bit.zip" \
      && unzip "arduino-ide_${ARDUINO_IDE_VERSION}_Linux_64bit.zip" \
      && rm -rf "arduino-ide_${ARDUINO_IDE_VERSION}_Linux_64bit.zip" \
      && mv arduino-ide_${ARDUINO_IDE_VERSION}_Linux_64bit arduino-ide-${ARDUINO_IDE_VERSION}

#RUN mkdir -p /opt/arduino-ide-${ARDUINO_IDE_VERSION} \
#      && cd /opt/arduino-ide-${ARDUINO_IDE_VERSION} \
#      && wget -q "https://downloads.arduino.cc/arduino-ide/arduino-ide_${ARDUINO_IDE_VERSION}_Linux_64bit.AppImage" \
#      && chmod a+x "arduino-ide_${ARDUINO_IDE_VERSION}_Linux_64bit.AppImage"

# RUN apt-get update && apt-get install -y libx11-xcb1 libglib2.0-0 libxshmfence1 libnss3 libatk1.0-0 libatk-bridge2.0-0 libdrm2 libgtk-3-0 libgbm1 libasound2 libsecret-1-0


COPY --chmod=755 start.sh /opt/arduino-ide-$ARDUINO_IDE_VERSION/

RUN apt-get update && \ 
    apt-get install -y strace && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
 
# create container user
# replace 1000 with your user / group id
RUN groupadd -g $GID developer && \
    useradd developer -u $UID -g $GID -m -s /bin/bash && \
    usermod -a -G dialout developer
USER developer

