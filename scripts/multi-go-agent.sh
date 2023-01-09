#!/bin/bash
# spin up 5 additional GoCD agents.
AGENT_COUNT=5

# if you want to run the GoCD agent as a service
RUN_AS_SERVICE=true

# if you want to start the service immediately
# only works if `RUN_AS_SERVICE` is true
START_SERVICE_NOW=true

for AGENT_INDEX in $(seq 1 "${AGENT_COUNT}")
do
  AGENT_ID="go-agent-${AGENT_INDEX}"

  # create the directories for agent data and binaries
  sudo mkdir -p /usr/share/${AGENT_ID} /var/{lib,log}/${AGENT_ID} /var/lib/${AGENT_ID}/run

  # copy over all config and shell scripts and wrapper configs
  sudo cp -arf /usr/share/go-agent/{bin,wrapper-config} /usr/share/${AGENT_ID}
  sudo chown -R go:go /usr/share/${AGENT_ID}

  # symlink the wrapper binaries
  sudo ln -sf /usr/share/go-agent/wrapper /usr/share/${AGENT_ID}

  # change ownership and mode, so that the `go` user, and only that user
  # can write to these directories
  sudo chown -R go:go /var/{lib,log}/${AGENT_ID}
  sudo chmod -R 0750 /var/{lib,log}/${AGENT_ID}

  # tweak the scripts and configs to use the correct directories
  sudo sed -i -e "s@go-agent@${AGENT_ID}@g" /usr/share/${AGENT_ID}/bin/go-agent

  sudo sed -i -e "s@=go-agent\$@=${AGENT_ID}@g" \
        -e "s@/var/lib/go-agent@/var/lib/${AGENT_ID}@g" \
        -e "s@/var/log/go-agent@/var/log/${AGENT_ID}@g" \
        -e "s@../wrapper-config/wrapper-properties.conf@/usr/share/${AGENT_ID}/wrapper-config/wrapper-properties.conf@g" \
          /usr/share/${AGENT_ID}/wrapper-config/wrapper.conf
  sudo sed -i -e "s@/var/lib/go-agent@/var/lib/${AGENT_ID}@g" /usr/share/${AGENT_ID}/wrapper-config/wrapper-properties.conf
  sudo chown -R go:go /usr/share/${AGENT_ID}

  if [ "${RUN_AS_SERVICE}" == "true" ]; then
    if [ "${START_SERVICE_NOW}" == "true" ]; then
      sudo /usr/share/${AGENT_ID}/bin/go-agent installstart
    else
    sudo /usr/share/${AGENT_ID}/bin/go-agent install
    fi
  fi
done

