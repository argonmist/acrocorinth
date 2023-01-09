#!/bin/bash
if [ $# -eq 0 ]; then
    echo "./adb_connect.sh YOUR_DEVICE_IP:PORT"
    exit 1
fi

docker exec -ti android-dev adb connect $1
