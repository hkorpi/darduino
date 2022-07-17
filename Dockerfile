FROM ubuntu:20.04

ENV HOME /home/developer
WORKDIR /home/developer

# install dependencies
RUN apt-get update && \ 
    apt-get install -y \
      wget \
      openjdk-17-jre \
      xz-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install arduino ide
ENV ARDUINO_IDE_VERSION 1.8.19
RUN (wget -q -O- https://downloads.arduino.cc/arduino-${ARDUINO_IDE_VERSION}-linux64.tar.xz \
	| tar xJC /usr/local/share \
	&& ln -s /usr/local/share/arduino-${ARDUINO_IDE_VERSION} /usr/local/share/arduino \
	&& ln -s /usr/local/share/arduino-${ARDUINO_IDE_VERSION}/arduino /usr/local/bin/arduino)

ENV DISPLAY :1.0

# create container user
# replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    groupadd -g ${gid} developer && \
    useradd developer -u ${uid} -g ${gid} -m -s /bin/bash && \
    usermod -a -G dialout developer
USER developer
