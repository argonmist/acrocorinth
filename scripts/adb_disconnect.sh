#!/bin/bash
if [ $# -eq 0 ]; then
    echo "./adb_disconnect.sh YOUR_DEVICE_IP:PORT"
    exit 1
fi

docker exec -ti android-dev adb disconnect $1
