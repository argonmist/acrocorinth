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

for i in ${pipeline[@]}; do
  cmd="yq -i '.environments.sisyphus.environment_variables.device_name = \"$DEVICE_NAME\"' ../template/$i.gocd.yaml"
  eval $cmd
  cmd="yq -i '.environments.sisyphus.environment_variables.android_version = $ANDROID_VERSION' ../template/$i.gocd.yaml"
  eval $cmd
  cmd="yq -i '.environments.sisyphus.environment_variables.server_ip = \"$SERVER_IP\"' ../template/$i.gocd.yaml"
  eval $cmd
  cmd="yq -i '.environments.sisyphus.environment_variables.android_app = \"$ANDROID_APP\"' ../template/$i.gocd.yaml"
  eval $cmd
  cmd="yq -i '.environments.sisyphus.environment_variables.android_activity = \"$ANDROID_ACTIVITY\"' ../template/$i.gocd.yaml"
  eval $cmd
  cmd="yq -i '.pipelines.$i.materials.yamls.git = \"$YAML_GITLAB\"' ../template/$i.gocd.yaml"
  eval $cmd
  cmd="yq -i '.pipelines.$i.materials.yamls.username = \"$USER\"' ../template/$i.gocd.yaml"
  eval $cmd
  cmd="yq -i '.pipelines.$i.materials.yamls.branch = \"$BRANCH\"' ../template/$i.gocd.yaml"
  eval $cmd
done
