#! /bin/bash

emerge sys-kernel/gentoo-sources

eselect kernel set 1

emerge sys-apps/pciutils
cd /usr/src/linux
make menuconfig
make && make modules_install
make install

emerge sys-kernel/dracut
dracut --kver=5.15.41-gentoo
