#!/bin/bash

get_fail_num() {
  arr=("$@")
  echo ${arr[*]}
  for x in "${!arr[@]}"; do
  if [[ ${arr[$x]} == *'failed'* ]]; then
    k=$[$x - 1]
    fail+=(${arr[$k]})
  fi
  done
}

docker restart android-dev
sleep 10
docker exec -i android-dev adb connect $device_name
sleep 3
docker exec -i android-dev adb -s $device_name forward --remove-all
sleep 3
readarray -t order < yamls/android_test_order
for i in "${order[@]}"
do
  echo $i
  out=($(docker exec -i android-dev sisyphus -t android -d $device_name -v $android_version -a $android_app -i $android_activity -s $server_ip -c $i -r $server_ip -g yes))
  get_fail_num "${out[@]}"
  fail_num=${fail[${#fail[@]} - 1]}
  if [ "$fail_num" -gt 0 ]; then
    echo 'failed:' $fail_num
    docker restart android-dev
    sleep 10
    docker exec -i android-dev adb connect $device_name
    sleep 3
    echo "re-run testcase because of testcase failed"
    out=($(docker exec -i android-dev sisyphus -t android -d $device_name -v $android_version -a $android_app -i $android_activity -s $server_ip -c $i -r $server_ip -g yes))
    get_fail_num "${out[@]}"
    fail_num=${fail[${#fail[@]} - 1]}
    if [ "$fail_num" -gt 0 ]; then
      echo "fail again, restart container and reconnect to device"
      docker restart android-dev
      sleep 10
      docker exec -i android-dev adb connect $device_name
      sleep 3
    fi
  fi
done

