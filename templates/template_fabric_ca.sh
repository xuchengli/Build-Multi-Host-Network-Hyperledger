#!/bin/bash

docker run --rm -it \
           --network="OVERLAY_NETWORK" \
           --name ca.example.com \
           -p 7054:7054 \
           -e FABRIC_CA_HOME=/etc/hyperledger/fabric-ca-server \
           -e FABRIC_CA_SERVER_CA_NAME=ca.example.com \
           -e FABRIC_CA_SERVER_TLS_ENABLED=true \
           -e FABRIC_CA_SERVER_TLS_CERTFILE=/etc/hyperledger/fabric-ca-server-config/ca.org1.example.com-cert.pem \
           -e FABRIC_CA_SERVER_TLS_KEYFILE=/etc/hyperledger/fabric-ca-server-config/CA_PRIVATE_KEY \
           -e FABRIC_CA_SERVER_CA_CERTFILE=/etc/hyperledger/fabric-ca-server-config/ca.org1.example.com-cert.pem \
           -e FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric-ca-server-config/CA_PRIVATE_KEY \
           -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=OVERLAY_NETWORK \
           --volume-driver vieux/sshfs \
           --mount src=sshvolume,target=/etc/hyperledger/fabric-ca-server-config,volume-opt=sshcmd=root@152.32.170.29:/root/fabric-artifacts/crypto-config/peerOrganizations/org1.example.com/ca,volume-opt=password=!Baas@test \
           hyperledger/fabric-ca sh -c 'fabric-ca-server start -b admin:adminpw -d'
