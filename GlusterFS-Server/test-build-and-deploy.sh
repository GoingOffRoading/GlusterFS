#!/bin/bash

sudo docker build --no-cache -t glusterserver .

#Will require token, not for public use
sudo docker push ghcr.io/goingoffroading/glusterserver:latest

#No need to persist the images after upload 
sudo docker image rm ghcr.io/goingoffroading/glusterserver
sudo docker image rm glusterserver