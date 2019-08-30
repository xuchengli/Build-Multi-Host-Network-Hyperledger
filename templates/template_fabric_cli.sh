#!/bin/bash

docker run --rm -it \
           --network="OVERLAY_NETWORK" \
           --name cli \
           --link orderer.example.com:orderer.example.com \
           --link PEER0_NAME:PEER0_NAME \
           --link PEER1_NAME:PEER1_NAME \
           -e GOPATH=/opt/gopath \
           -e CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock \
           -e FABRIC_LOGGING_SPEC=info \
           -e CORE_PEER_ID=cli \
           -e CORE_PEER_ADDRESS=PEER0_NAME:7051 \
           -e CORE_PEER_LOCALMSPID=Org1MSP \
           -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp \
           -e CORE_CHAINCODE_KEEPALIVE=10 \
           -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=OVERLAY_NETWORK \
           -v /var/run/:/host/var/run/ \
           -v $(pwd)/chaincode/:/opt/gopath/src/github.com/hyperledger/fabric/examples/chaincode/go \
           -v $(pwd)/crypto-config:/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ \
           -v $(pwd)/scripts:/opt/gopath/src/github.com/hyperledger/fabric/peer/scripts/ \
           -v $(pwd)/channel-artifacts:/opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts \
           -w /opt/gopath/src/github.com/hyperledger/fabric/peer \
           hyperledger/fabric-tools /bin/bash -c './scripts/script.sh'
