#! /bin/bash

sed -i "s/^COMMON_FLAGS=.*/COMMON_FLAGS=\"-march=skylake -O2 -pipe\"/" /mnt/gentoo/etc/portage/make.conf
echo "MAKEOPTS=\"-j6\"" >> /mnt/gentoo/etc/portage/make.conf
