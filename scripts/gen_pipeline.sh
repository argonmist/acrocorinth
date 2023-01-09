#!/bin/bash
DEVICE_NAME=$(yq .DEVICE_NAME ../settings.yaml)
ANDROID_VERSION=$(yq .ANDROID_VERSION ../settings.yaml)
SERVER_IP=$(yq .SERVER_IP ../settings.yaml)
YAML_GITLAB=$(yq .YAML_GITLAB ../settings.yaml)
USER=$(yq .USER ../settings.yaml)
BRANCH=$(yq .BRANCH ../settings.yaml)
ANDROID_APP=$(yq .ANDROID_APP ../settings.yaml)
ANDROID_ACTIVITY=$(yq .ANDROID_ACTIVITY ../settings.yaml)
pipeline=("report-generate" "report-serve" "gitbook")

cmd="yq -i '.environments.sisyphus.environment_variables.device_name = \"$DEVICE_NAME\"' ../template/acrocorinth.yaml"
eval $cmd
cmd="yq -i '.environments.sisyphus.environment_variables.android_version = $ANDROID_VERSION' ../template/acrocorinth.yaml"
eval $cmd
cmd="yq -i '.environments.sisyphus.environment_variables.server_ip = \"$SERVER_IP\"' ../template/acrocorinth.yaml"
eval $cmd
cmd="yq -i '.environments.sisyphus.environment_variables.android_app = \"$ANDROID_APP\"' ../template/acrocorinth.yaml"
eval $cmd
cmd="yq -i '.environments.sisyphus.environment_variables.android_activity = \"$ANDROID_ACTIVITY\"' ../template/acrocorinth.yaml"
eval $cmd

for i in ${pipeline[@]}; do
  cmd="yq -i '.pipelines.$i.materials.yamls.git = \"$YAML_GITLAB\"' ../template/acrocorinth.yaml"
  eval $cmd
  cmd="yq -i '.pipelines.$i.materials.yamls.username = \"$USER\"' ../template/acrocorinth.yaml"
  eval $cmd
  cmd="yq -i '.pipelines.$i.materials.yamls.branch = \"$BRANCH\"' ../template/acrocorinth.yaml"
  eval $cmd
done
