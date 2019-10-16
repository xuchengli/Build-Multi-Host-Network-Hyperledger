#!/bin/bash

docker plugin install --grant-all-permissions vieux/sshfs

docker volume create --driver vieux/sshfs sshvolume
