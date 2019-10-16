#!/bin/bash

docker run --rm -it \
           --network="OVERLAY_NETWORK" \
           --name orderer.example.com \
           -p 7050:7050 \
           -e FABRIC_LOGGING_SPEC=INFO \
           -e ORDERER_GENERAL_LISTENADDRESS=0.0.0.0 \
           -e ORDERER_GENERAL_GENESISMETHOD=file \
           -e ORDERER_GENERAL_GENESISFILE=/var/hyperledger/channel-artifacts/genesis.block \
           -e ORDERER_GENERAL_LOCALMSPID=OrdererMSP \
           -e ORDERER_GENERAL_LOCALMSPDIR=/var/hyperledger/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp \
           -e ORDERER_GENERAL_TLS_ENABLED=true \
           -e ORDERER_GENERAL_TLS_PRIVATEKEY=/var/hyperledger/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key \
           -e ORDERER_GENERAL_TLS_CERTIFICATE=/var/hyperledger/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt \
           -e ORDERER_GENERAL_TLS_ROOTCAS=[/var/hyperledger/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt] \
           -e ORDERER_KAFKA_TOPIC_REPLICATIONFACTOR=1 \
           -e ORDERER_KAFKA_VERBOSE=true \
           -e ORDERER_GENERAL_CLUSTER_CLIENTCERTIFICATE=/var/hyperledger/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt \
           -e ORDERER_GENERAL_CLUSTER_CLIENTPRIVATEKEY=/var/hyperledger/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key \
           -e ORDERER_GENERAL_CLUSTER_ROOTCAS=[/var/hyperledger/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt] \
           -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=OVERLAY_NETWORK \
           -v sshvolume:/var/hyperledger \
           -w /opt/gopath/src/github.com/hyperledger/fabric \
           hyperledger/fabric-orderer orderer
