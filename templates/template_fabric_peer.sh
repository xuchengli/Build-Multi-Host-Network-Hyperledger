#!/bin/bash

docker run --rm -it \
           --network="OVERLAY_NETWORK" \
           --name PEER_NAME \
           -p 7051:7051 \
           -p 7053:7053 \
           --link orderer.example.com:orderer.example.com \
           --link COUCHDB_NAME:COUCHDB_NAME \
           -e CORE_LEDGER_STATE_STATEDATABASE=CouchDB \
           -e CORE_LEDGER_STATE_COUCHDBCONFIG_COUCHDBADDRESS=COUCHDB_NAME:5984 \
           -e CORE_LEDGER_STATE_COUCHDBCONFIG_USERNAME= \
           -e CORE_LEDGER_STATE_COUCHDBCONFIG_PASSWORD= \
           -e CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock \
           -e FABRIC_LOGGING_SPEC=INFO \
           -e CORE_PEER_TLS_ENABLED=true \
           -e CORE_PEER_GOSSIP_USELEADERELECTION=true \
           -e CORE_PEER_GOSSIP_ORGLEADER=false \
           -e CORE_PEER_PROFILE_ENABLED=true \
           -e CORE_PEER_TLS_CERT_FILE=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org1.example.com/peers/PEER_NAME/tls/server.crt \
           -e CORE_PEER_TLS_KEY_FILE=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org1.example.com/peers/PEER_NAME/tls/server.key \
           -e CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/fabric/crypto-config/peerOrganizations/org1.example.com/peers/PEER_NAME/tls/ca.crt \
           -e CORE_PEER_ID=PEER_NAME \
           -e CORE_PEER_ADDRESS=PEER_NAME:7051 \
           -e CORE_PEER_LISTENADDRESS=0.0.0.0:7051 \
           -e CORE_PEER_CHAINCODEADDRESS=PEER_NAME:7052 \
           -e CORE_PEER_CHAINCODELISTENADDRESS=0.0.0.0:7052 \
           -e CORE_PEER_GOSSIP_BOOTSTRAP=BOOTSTRAP_NODE_NAME:7051 \
           -e CORE_PEER_GOSSIP_EXTERNALENDPOINT=PEER_NAME:7051 \
           -e CORE_PEER_LOCALMSPID=Org1MSP \
           -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=OVERLAY_NETWORK \
           -e GODEBUG=netdns=go \
           -v /var/run/:/host/var/run/ \
           -v sshvolume:/etc/hyperledger/fabric \
           -w /opt/gopath/src/github.com/hyperledger/fabric/peer \
           hyperledger/fabric-peer peer node start
