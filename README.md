# GlusterFS Docker Container
For use in Docker & Kubernetes

## Problem Being Solved
In my GlusterFS journey, there have been gaps that have been dificult to fill:
* No documentation in the [Gluster Docker Hub container registry](https://hub.docker.com/r/gluster/gluster-centos)
* The related [Git repository has not been updated in two years](https://github.com/gluster/gluster-containers)
* [Issues for the Gluster Docker Image(s) are not being addressed](https://github.com/gluster/gluster-containers/issues)
* As of October 2021, [GlusterFS is up to it's August 2021 v9.4 release](https://docs.gluster.org/en/latest/release-notes/9.4/) but the [Gluster Git/Docker Container is capped at it's March 2018 v4.0 release](https://github.com/gluster/gluster-containers)
* Gluster Client crashes on run, [no documentation](https://github.com/gluster/gluster-containers/tree/master/gluster-client)


# Docker-Run Example 
Warning...  This example is temporary.  It does not include a volume for storing the Gluster config, which means when the container goes, so does your configurations.  Stay tuned.

Pull down the image:

```
$ docker pull ghcr.io/goingoffroading/glusterserver:latest
```

Then run:

```
$ sudo docker run --net host --privileged --name glusterserver -v /hostdata:/data  ghcr.io/goingoffroading/glusterserver:latest
```

Alternatively, run Gluster-Docker-Run.sh from this repo

# Kubernetes DaemonSet
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
Assuming no changes from the Gluster-Kubernetes-Daemonset.yml file, run:
```
$ kubectl apply -f https://github.com/GoingOffRoading/GlusterFS/blob/main/Gluster-Kubernetes-Daemonset.yml
```
Alternatively, download the file to your local:
```
$ wget https://raw.githubusercontent.com/GoingOffRoading/GlusterFS/main/Gluster-Kubernetes-Daemonset.yml
```
Edit the file as nessesary, and run it locally:
```
$ kubectl apply -f Gluster-Kubernetes-Daemonset.yml
```
Then get your Gluster pods
```
$ kubectl get pods -o wide | grep -e "NAME\|gluster"
```
Sample output:
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
I don't think which pod you select matters, but I pick the first Pod/Node in the series to SSH into:
```
kubectl exec --stdin --tty glusterfs-q2xb7 -- /bin/bash
```


# Todo:

* Need to update docker run example to include volume for storing Gluster config
* Clean up the Kubernetes example
* Add a docker-compose example
* Have somebody that actually knows what they are doing review this stuff