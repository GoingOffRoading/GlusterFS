# Gluster Server

Built on an Ubuntu image, as it appears Gluster will not work on an Alpine image without substantual workarounds

## Local Use
I will get these images published to Github shortly.  Until then:

Copy down the repository:

```
git clone https://github.com/GoingOffRoading/GlusterFS.git
```
Once it's been pulled down:

```
cd GlusterFS-Client && cd GlusterFS-Server
```

## Build the Docker image

```
sudo docker build -t glusterser .
```

## Deploy to Docker 

```
sudo docker run -d -it glusterserver:latest
```
Get the container name:

```
$ sudo docker container ps -a | grep -e gluster
d0955fda88eb   glusterserver:latest                   "/usr/sbin/init"         2 minutes ago    Up 2 minutes                            sharp_merkle
```
The container's name here is 'sharp_merkle'.  Your container name will be different.  

Then SSH into the container using the container name:

```
r$ sudo docker exec -it sharp_merkle /bin/bash
```
Gluster commands now avaliable for us:

```
root@d0955fda88eb:/# glusterfs --version
glusterfs 9.4
Repository revision: git://git.gluster.org/glusterfs.git
Copyright (c) 2006-2016 Red Hat, Inc. <https://www.gluster.org/>
GlusterFS comes with ABSOLUTELY NO WARRANTY.
It is licensed to you under your choice of the GNU Lesser
General Public License, version 3 or any later version (LGPLv3
or later), or the GNU General Public License, version 2 (GPLv2),
in all cases as published by the Free Software Foundation.
```
# ToDo:
Add volume mounts to persist data 