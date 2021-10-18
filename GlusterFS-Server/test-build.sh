#!/bin/bash

sudo docker build --no-cache -t glusterserver . 

sudo docker container ls | grep -e 'CONTAINER\|gluster'

echo "Next Step: sudo docker run ––name CONTAINER-NAME –d nginx"