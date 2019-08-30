#!/bin/bash

function fabric_ca() {
  # sed on MacOSX does not support -i flag with a null extension. We will use
  # 't' for our back-up's extension and delete it at the end of the function
  ARCH=$(uname -s | grep Darwin)
  if [ "$ARCH" == "Darwin" ]; then
    OPTS="-it"
  else
    OPTS="-i"
  fi

  cp ./templates/template_fabric_ca.sh fabric_ca.sh
  chmod +x fabric_ca.sh

  CURRENT_DIR=$PWD
  cd crypto-config/peerOrganizations/org1.example.com/ca/
  PRIV_KEY=$(ls *_sk)

  cd "$CURRENT_DIR"
  sed $OPTS "s/CA_PRIVATE_KEY/${PRIV_KEY}/g" fabric_ca.sh
  sed $OPTS "s/OVERLAY_NETWORK/${OVERLAY_NETWORK}/g" fabric_ca.sh

  # If MacOSX, remove the temporary backup of the docker-compose file
  if [ "$ARCH" == "Darwin" ]; then
    rm fabric_ca.sht
  fi
}

OVERLAY_NETWORK="fabric-net"

fabric_ca
