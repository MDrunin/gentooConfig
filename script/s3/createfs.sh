#! /bin/bash

#applying fs
mkfs.ext2 /dev/sda1
mkfs.ext4 /dev/sda3

#activating swap partition
mkswap /dev/sda2
swapon /dev/sda2

#mounting root partition
mkdir --parents /mnt/gentoo
mount /dev/sda3 /mnt/gentoo

