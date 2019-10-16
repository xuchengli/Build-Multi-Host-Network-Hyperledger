#!/bin/bash

docker run --rm -it \
           --network="OVERLAY_NETWORK" \
           --name ca.example.com \
           -p 7054:7054 \
           -e FABRIC_CA_HOME=/etc/hyperledger/fabric-ca-server \
           -e FABRIC_CA_SERVER_CA_NAME=ca.example.com \
           -e FABRIC_CA_SERVER_TLS_ENABLED=true \
           -e FABRIC_CA_SERVER_TLS_CERTFILE=/etc/hyperledger/fabric-ca-server-config/crypto-config/peerOrganizations/org1.example.com/ca/ca.org1.example.com-cert.pem \
           -e FABRIC_CA_SERVER_TLS_KEYFILE=/etc/hyperledger/fabric-ca-server-config/crypto-config/peerOrganizations/org1.example.com/ca/CA_PRIVATE_KEY \
           -e FABRIC_CA_SERVER_CA_CERTFILE=/etc/hyperledger/fabric-ca-server-config/crypto-config/peerOrganizations/org1.example.com/ca/ca.org1.example.com-cert.pem \
           -e FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric-ca-server-config/crypto-config/peerOrganizations/org1.example.com/ca/CA_PRIVATE_KEY \
           -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=OVERLAY_NETWORK \
           -v sshvolume:/etc/hyperledger/fabric-ca-server-config \
           hyperledger/fabric-ca sh -c 'fabric-ca-server start -b admin:adminpw -d'
