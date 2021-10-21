#!/bin/bash

service glusterd start
gluser peer status
gluster volume status