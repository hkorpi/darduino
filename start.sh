#!/bin/bash
# Starts dbus and the Arduino IDE
set -e
cd $(dirname $0)

if ! pgrep -x "dbus-daemon" > /dev/null
then
  echo "starting dbus-daemon"
  export DBUS_SESSION_BUS_ADDRESS=$(dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address | cut -d, -f1)
else
  echo "dbus-daemon already running"
fi
./arduino-ide --no-sandbox
