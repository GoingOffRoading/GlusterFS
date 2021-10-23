# GlusterFS Server Docker Container
![Gluster Stuff](https://github.com/GoingOffRoading/GlusterFS/blob/main/gluster-ant.png)

Gluster is a free and open source scalable network filesystem
Gluster is a scalable network filesystem. 

Using common off-the-shelf hardware, you can create large, distributed storage solutions for media streaming, data analysis, and other data- and bandwidth-intensive tasks. Gluster is free.

The repo is for Gluster use in Docker & Kubernetes

## Problem Being Solved
In my GlusterFS journey, there have been gaps that have been dificult to fill:
* No documentation in the [Gluster Docker Hub container registry](https://hub.docker.com/r/gluster/gluster-centos)
* The related [Git repository has not been updated in two years](https://github.com/gluster/gluster-containers)
* [Issues for the Gluster Docker Image(s) are not being addressed](https://github.com/gluster/gluster-containers/issues)
* As of October 2021, [GlusterFS is up to it's August 2021 v9.4 release](https://docs.gluster.org/en/latest/release-notes/9.4/) but the [Gluster Git/Docker Container is capped at it's March 2018 v4.0 release](https://github.com/gluster/gluster-containers)
* Gluster Client crashes on run, [no documentation](https://github.com/gluster/gluster-containers/tree/master/gluster-client)

So I set out to build my own GlusterFS containers.  What could go wrong!


# GlusterFS Server
## Docker-Run Example 

```
$ sudo docker pull ghcr.io/goingoffroading/glusterfs-server:latest
$ sudo docker run --net host --privileged --name glusterserver ghcr.io/goingoffroading/glusterfs-server:latest
```
Add volumes as you see fit:

Directory | Notes
---------- | ----------
/data | Really any directory works here.  This will be the directory you Gluster Volume maps to
/etc/glusterfs | Gluster Configs
/var/lib/glusterd | Gluster Metadata
/var/log/glusterfs | Gluster Logs

These directories will be needed to persist data between container restarts.

Full example from the [Gluser Docker Github](https://github.com/gluster/gluster-containers) using [this repo's Gluster Server Docker Image](https://github.com/GoingOffRoading/GlusterFS/pkgs/container/glusterfs-server)

    $ docker run -v /etc/glusterfs:/etc/glusterfs:z -v /var/lib/glusterd:/var/lib/glusterd:z -v /var/log/glusterfs:/var/log/glusterfs:z -v /sys/fs/cgroup:/sys/fs/cgroup:ro -d --privileged=true --net=host -v /data/:/data ghcr.io/goingoffroading/glusterfs-server:latest

## Kubernetes DaemonSet
DaemonSets are kind of cool as they can deploy to all relevant nodes...  Which makes deployment easy, and future scalability VERY easy.

Get the names of the relevant Nodes that are to be inlcuded in the Gluster Daemonset

```
$ kubectl get nodes
```

Expected output:
```
$ kubectl get nodes
NAME                          STATUS   ROLES                  AGE    VERSION
gluster01-poweredge-r210-ii   Ready    <none>                 45h    v1.22.2
gluster02-poweredge-r210-ii   Ready    <none>                 46h    v1.22.2
gluster03-poweredge-r210-ii   Ready    <none>                 46h    v1.22.2
```
Then label each node with storagenode=glusterfs

```
kubectl label nodes NODE-NAME storagenode=glusterfs
```
Using the above kubectl get nodes example:
```
$ kubectl label nodes gluster01-poweredge-r210-ii storagenode=glusterfs
$ kubectl label nodes gluster02-poweredge-r210-ii storagenode=glusterfs
$ kubectl label nodes gluster03-poweredge-r210-ii storagenode=glusterfs
```
Download the GlusterFS Server daemonset yml to your local, make change:
```
$ wget https://raw.githubusercontent.com/GoingOffRoading/GlusterFS/main/Gluster-Server-Kubernetes-Daemonset.yml
```
Edit the file as nessesary, and run it from your control node:
```
$ kubectl apply -f Gluster-Server-Kubernetes-Daemonset.yml
```
Then get your Gluster pods
```
$ kubectl get pods -o wide | grep -e "NAME\|gluster"
```
Sample output:

Found an issue that did not show up in the local Docker run testing... Investigating

```
$ kubectl get pods -o wide | grep -e "NAME\|gluster"
NAME                                   READY   STATUS             RESTARTS      AGE     IP              NODE                          NOMINATED NODE   READINESS GATES
glusterfs-8n7gh                        0/1     CrashLoopBackOff   4 (8s ago)    109s    192.168.1.102   gluster02-poweredge-r210-ii   <none>           <none>
glusterfs-b6jzf                        0/1     Error              4 (51s ago)   109s    192.168.1.103   gluster03-poweredge-r210-ii   <none>           <none>
glusterfs-q2xb7                        0/1     Error              4 (53s ago)   109s    192.168.1.101   gluster01-poweredge-r210-ii   <none>           <none>
```
Next is to SSH into one of the Gluster pods to setup the cluster.
```
kubectl exec --stdin --tty CONTAINER-NAME -- /bin/bash
```
From here, add Volumes, manage GlusterFS Server as needed

# GlusterFS Client Docker Container
For 
## Docker-Run Example 

```
$ sudo docker pull ghcr.io/goingoffroading/glusterfs-client:latest
$ sudo docker run --net host --privileged --name glusterserver ghcr.io/goingoffroading/glusterfs-client:latest
```
Add volumes as you see fit:

Directory | Notes
---------- | ----------
/share | Really any directory works here.  This will be the directory you Gluster Volume maps to

## Kubernetes Deployment

Download the daemonset yml to your local, make change:
```
$ wget https://raw.githubusercontent.com/GoingOffRoading/GlusterFS/main/Gluster-Client-Kubernetes-Daemonset.yml
```
Edit the file as nessesary (like your volume file path), and run it from your control node:
```
$ kubectl apply -f Gluster-Server-Kubernetes-Daemonset.yml
```
Then get your Gluster pods
```
$ kubectl get pods -o wide | grep -e "NAME\|gluster"
```
Sample output:

Found an issue that did not show up in the local Docker run testing... Investigating

```
$ kubectl get pods -o wide | grep -e "NAME\|gluster"
```
Next is to SSH into the Gluster Client pods to setup the cluster.
```
kubectl exec --stdin --tty CONTAINER-NAME -- /bin/bash
```
Join the Gluster Volume to the container volume:

```
$ mount -t glusterfs (GLUSTER-NODE-IP):/(GLUSTER-VOLUME-NAME) /(Volume)
```
Example:
```
$ mount -t glusterfs 192.168.1.102:/Gluster /Share
```
ls in the target directory to test success


