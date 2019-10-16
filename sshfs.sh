#!/bin/bash

docker plugin install --grant-all-permissions vieux/sshfs

docker volume create --driver vieux/sshfs \
  -o sshcmd=root@152.32.170.29:/root/fabric-artifacts \
  -o password=!Baas@test \
  sshvolume
