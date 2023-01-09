#!/bin/bash

git clone https://github.com/argonmist/sisyphus.git
git clone https://github.com/argonmist/triangle.git

docker pull argonhiisi/sisyphus:appium-1.22.3
docker run --privileged -d -v $HOME/sisyphus:/root/sisyphus --net=host -e TZ="Asia/Taipei" -e LANG=C.UTF-8 --name android-dev argonhiisi/sisyphus:appium-1.22.3
sleep 5
docker exec -ti android-dev cp bin/sisyphus /bin
docker exec -ti android-dev sisyphus
