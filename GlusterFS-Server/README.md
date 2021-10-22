# Gluster Server

Built on an Ubuntu Docker image instead of RedHat or CentOS, for no real reason...  

## Dependancies

- Have Docker Installed: [Ubuntu Docker Install Docs](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)
- Have Git (Github) installed: [Ubuntu Git Install Docs](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
## Local Docker Image Build & Use

Pull down the repository, move into the correct directory, build and run the image the image using the test-run.sh bash script.

```
git clone https://github.com/GoingOffRoading/GlusterFS.git && \
cd GlusterFS/GlusterFS-Server && \
sudo chmox +x test-run.sh && \
./test-run.sh
```

When the build is finished, a _sudo docker container ls -a | grep -e 'CONTAINER\|gluster_ is run in the test-run.sh to display the name and status of the container, as well as the next step:

    Running the Docker Image
    2a44c04324e9cc1ec0ce71f556bc74467ac88cf1ec1b3be9784db3574d03cd23
    Done
    CONTAINER ID   IMAGE                                  COMMAND                  CREATED         STATUS                      PORTS     NAMES
    2a44c04324e9   glusterserver                          "/bin/sh -c 'gluster…"   4 seconds ago   Up 3 seconds                          dreamy_archimedes
   k8s_POD_youtubedlglustertest-6789896868-pmhx7_default_a7ee3535-8ab0-4ab1-84bb-be15faaf5143_0
    Next run: sudo docker exec –it CONTAINER-NAME /bin/bash

Get the container name:

```
$ sudo docker container ps -a | grep -e gluster
d0955fda88eb   glusterserver:latest                   "/usr/sbin/init"         2 minutes ago    Up 2 minutes                            sharp_merkle
```
The container's name in this example is 'sharp_merkle'.  Your container name will be different, but it will be in the same location as 'sharp_merkle' is in this example.  

Then SSH into the container using your container name container name:

```
$ sudo docker exec -it sharp_merkle /bin/bash
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
When done, the GlusterFS Server test-run container and image can be knocked down with the test-destroy.sh:

    sudo chmod +x test-destroy.sh && ./test-destroy.sh

Provide the prompt with the NAME of the container:

    $ ./test-destroy.sh
    CONTAINER ID   IMAGE                                  COMMAND                  CREATED         STATUS                      PORTS     NAMES
    2a44c04324e9   glusterserver                          "/bin/sh -c 'gluster…"   5 minutes ago   Up 5 minutes                          dreamy_archimedes
    Nuke what Conatiner?

test-destroy.sh will take care of stopping & removing the GlusterFS Server Docker container, as well as the Docker image test-run.sh had built:

    dreamy_archimedes
    Going to flat out murder dreamy_archimedes
    dreamy_archimedes
    Destroying the evidence
    dreamy_archimedes
    Nuking Images
    Untagged: glusterserver:latest
    Deleted: sha256:94c589494a79fad1f41f956cda33afd0427d1a22a8517a8d7f54c45e5267bdd0
    Deleted: sha256:23a8fc3af0de00cc37d0a85258aed4f4a3df6f2e8061bd43c4b620fc6d9e6e89
    Deleted: sha256:81890c20486aebb0595ea0b6a5e98740207f2946debf3d1526da8bb6de12de5c
    Deleted: sha256:1e2f922fde6fec5f3f70aa0ef1edcf11037246fe9ec103e477153921027cc2d1

## Deploying the GlusterFS Server container

Edit the test.deploy.sh for your container repository, run  test-deploy.sh to deploy your image there:

    sudo chmod +x test-deploy.sh && ./test-deploy.sh

