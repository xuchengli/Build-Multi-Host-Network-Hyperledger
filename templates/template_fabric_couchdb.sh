#!/bin/bash

docker run --rm -it \
           --network="OVERLAY_NETWORK" \
           --name COUCHDB_NAME \
           -p 5984:5984 \
           -e COUCHDB_USER= \
           -e COUCHDB_PASSWORD= \
           -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=OVERLAY_NETWORK \
           hyperledger/fabric-couchdb
