#!/bin/bash

echo "Building the Docker Image"
sudo docker build -t glusterclient . 

echo "Running the Docker Image"
sudo docker run -d --privileged glusterclient

echo "Done"
sleep 5
sudo docker container ls -a | grep -e 'CONTAINER\|gluster'

echo "Next run: sudo docker exec –it CONTAINER-NAME /bin/bash"
