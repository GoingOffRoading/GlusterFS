#!/bin/bash

glusterd --log-level ERROR
gluster peer status
gluster volume status
