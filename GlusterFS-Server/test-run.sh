#!/bin/bash

echo "Building the Docker Image"
sleep 3
sudo docker build --no-cache -t glusterserver . 

echo "Running the Docker Image"
sleep 3
sudo docker run -d --privileged glusterserver

echo "Done"
sleep 3
sudo docker container ls -a | grep -e 'CONTAINER\|gluster'

echo "Next run: sudo docker exec –it CONTAINER-NAME /bin/bash"

