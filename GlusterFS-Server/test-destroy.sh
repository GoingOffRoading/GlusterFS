#!/bin/bash

sudo docker container ls -a | grep -e 'CONTAINER\|gluster'

echo "Nuke what Conatiner?"
read container

echo "Going to flat out murder $container"
sleep 2
sudo docker container stop $container

echo "Destroying the evidence"
sleep 2
sudo docker container rm $container

echo "Nuking Images"
sleep 2
sudo docker image rm ghcr.io/goingoffroading/glusterserver
sudo docker image rm glusterserver
