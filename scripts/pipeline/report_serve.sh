#!/bin/bash
docker restart android-dev
sleep 5
echo $server_ip
readarray -t order < yamls/android_test_order
docker exec -i -d android-dev sisyphus -t android -d $device_name -v $android_version -a $android_app -i $android_activity -s $server_ip -c ${order[0]} -r $server_ip -e yes

