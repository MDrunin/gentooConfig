#! /bin/bash

echo "STAGE0,	lsCreating harddisk for QEMU VM with $1 of space
(Recomended:10G+)"
qemu-img create -f qcow2 image.img $1
