#!/bin/bash

sudo docker build --no-cache -t glusterserver .

echo "tagging image"
sleep 2
sudo docker tag glusterserver ghcr.io/goingoffroading/glusterserver:latest

#Will require token, not for public use
echo "pushing to github"
sleep 2
sudo docker push ghcr.io/goingoffroading/glusterserver:latest

echo "Done, now lets clean up"
sleep 5
sudo docker image rm ghcr.io/goingoffroading/glusterserver
sudo docker image rm glusterserver
