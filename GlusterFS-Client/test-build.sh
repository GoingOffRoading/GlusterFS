#!/bin/bash

echo "Building the Docker Image"
sudo docker build -t glusterserver . 

echo "Running the Docker Image"
sudo docker run -d --privileged glusterserver

echo "Done"
sleep 5
sudo docker container ls -a | grep -e 'CONTAINER\|gluster'

echo "Next run: sudo docker exec –it CONTAINER-NAME /bin/bash"


#--no-cache 