#!/bin/bash

function fabric_ca() {
  cp ./templates/template_fabric_ca.sh fabric_ca.sh
  chmod +x fabric_ca.sh

  CURRENT_DIR=$PWD
  cd crypto-config/peerOrganizations/org1.example.com/ca/
  PRIV_KEY=$(ls *_sk)

  cd "$CURRENT_DIR"
  sed $OPTS "s/CA_PRIVATE_KEY/${PRIV_KEY}/g" fabric_ca.sh
  sed $OPTS "s/OVERLAY_NETWORK/${OVERLAY_NETWORK}/g" fabric_ca.sh
}

function fabric_orderer() {
  cp ./templates/template_fabric_orderer.sh fabric_orderer.sh
  chmod +x fabric_orderer.sh

  sed $OPTS "s/OVERLAY_NETWORK/${OVERLAY_NETWORK}/g" fabric_orderer.sh
}

function fabric_couchdb() {
  cp ./templates/template_fabric_couchdb.sh fabric_$1.sh
  chmod +x fabric_$1.sh

  sed $OPTS "s/OVERLAY_NETWORK/${OVERLAY_NETWORK}/g" fabric_$1.sh
  sed $OPTS "s/COUCHDB_NAME/$1/g" fabric_$1.sh

  # If MacOSX, remove the temporary backup of the docker-compose file
  if [ "$ARCH" == "Darwin" ]; then
    rm fabric_$1.sht
  fi
}

function fabric_peer() {
  cp ./templates/template_fabric_peer.sh fabric_$1.sh
  chmod +x fabric_$1.sh

  sed $OPTS "s/OVERLAY_NETWORK/${OVERLAY_NETWORK}/g" fabric_$1.sh
  sed $OPTS "s/PEER_NAME/$1/g" fabric_$1.sh
  sed $OPTS "s/COUCHDB_NAME/$2/g" fabric_$1.sh
  sed $OPTS "s/BOOTSTRAP_NODE_NAME/$3/g" fabric_$1.sh

  # If MacOSX, remove the temporary backup of the docker-compose file
  if [ "$ARCH" == "Darwin" ]; then
    rm fabric_$1.sht
  fi
}

function fabric_cli() {
  cp ./templates/template_fabric_cli.sh fabric_cli.sh
  chmod +x fabric_cli.sh

  sed $OPTS "s/OVERLAY_NETWORK/${OVERLAY_NETWORK}/g" fabric_cli.sh
  sed $OPTS "s/PEER0_NAME/$1/g" fabric_cli.sh
  sed $OPTS "s/PEER1_NAME/$2/g" fabric_cli.sh
}

# sed on MacOSX does not support -i flag with a null extension. We will use
# 't' for our back-up's extension and delete it at the end of the function
ARCH=$(uname -s | grep Darwin)
if [ "$ARCH" == "Darwin" ]; then
  OPTS="-it"
else
  OPTS="-i"
fi
OVERLAY_NETWORK="fabric-net"

fabric_ca
fabric_orderer
fabric_couchdb couchdb0
fabric_peer peer0.org1.example.com couchdb0 peer1.org1.example.com
fabric_couchdb couchdb1
fabric_peer peer1.org1.example.com couchdb1 peer0.org1.example.com
fabric_cli peer0.org1.example.com peer1.org1.example.com

# If MacOSX, remove the temporary backup of the docker-compose file
if [ "$ARCH" == "Darwin" ]; then
  rm fabric_ca.sht
  rm fabric_orderer.sht
  rm fabric_cli.sht
fi
