# Gluster Server

Built on an Ubuntu image, as it appears Gluster will not work on an Alpine image without substantual workarounds






docker pull ghcr.io/goingoffroading/glusterserver:latest


kubectl get pods | grep -e gluster

kubectl exec --stdin --tty shell-demo -- /bin/bash







## Build Image & Use

Pull down the repository, move into the correct directory, build and run the image

```
git clone https://github.com/GoingOffRoading/GlusterFS.git && \
cd GlusterFS-Client && cd GlusterFS-Server && \
sudo docker build -t glusterser . && \ 
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




Notes for figuring out CMD:

CMD ["glusterd", "-N", "--log-file=/dev/stdout"]
https://github.com/metal3d/docker-glusterfs/blob/master/Dockerfile

CMD ["/usr/sbin/init"]
https://github.com/gluster/gluster-containers/blob/master/Fedora/Dockerfile


ENTRYPOINT ["/usr/local/bin/update-params.sh"]
CMD ["/usr/sbin/init"]
https://github.com/gluster/gluster-containers/blob/master/CentOS/Dockerfile


CMD ["/usr/sbin/glusterd","-N"]
https://github.com/blang/gluster-server/blob/master/Dockerfile

ENTRYPOINT ["/usr/local/bin/run.sh"]
https://github.com/angelnu/docker-glusterfs/blob/master/Dockerfile


https://github.com/testdasi/gluster-server/blob/main/Dockerfile
RUN echo "$(date "+%d.%m.%Y %T") Built from ${FRM} with tag ${TAG}" >> /build_date.info

while true
do
    echo '[info] Quick status:'
    echo ''
    gluster peer status
    echo ''
    gluster volume status
    echo ''
    sleep $sleep_time
done
https://github.com/testdasi/gluster-server/blob/main/scripts/entrypoint.sh

