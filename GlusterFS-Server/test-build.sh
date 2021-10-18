#!/bin/bash

sudo docker build --no-cache -t glusterserver . 

sudo docker containers ls | grep -e gluster

echo "Next Step: sudo docker run ––name CONTAINER-NAME –d nginx"