#!/bin/bash

echo "Pulling down the Docker Image"
sleep 3
sudo docker pull ghcr.io/goingoffroading/glusterfs-server:latest

sleep 3
echo "Starting the Gluster Server Docker container"
Sleep 3
sudo docker run --net host --privileged --name glusterserver -v /hostdata:/data  ghcr.io/goingoffroading/glusterfs-server:latest

Sleep 3
echo "Done"

sleep 3
sudo docker container ls -a | grep -e 'CONTAINER\|gluster'

echo "If you need to configure Gluster, run sudo docker exec –it CONTAINER-NAME /bin/bash"
