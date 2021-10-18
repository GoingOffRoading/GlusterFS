#!/bin/bash

echo "Building the Docker Image"
sudo docker build --no-cache -t glusterserver . 

echo "Running the Docker Image"
sudo docker run -d -it glusterserver

echo "Done"
sleep 3
sudo docker container ls -a | grep -e 'CONTAINER\|gluster'

echo "What is the Gluster container name?"

read container
sudo docker exec –it $container /bin/bash