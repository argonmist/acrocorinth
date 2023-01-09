#!/bin/bash

docker run -i --rm -w /tmp -v $(pwd):/tmp openjdk:21-jdk java -jar gocd-file-based-secrets-plugin-1.1.1-122.jar init -f secrets.json
docker run -i --rm -w /tmp -v $(pwd):/tmp openjdk:21-jdk java -jar gocd-file-based-secrets-plugin-1.1.1-122.jar add -f secrets.json -n yamls -v
mv secrets.json ../
