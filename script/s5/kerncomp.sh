#! /bin/bash

emerge sys-kernel/gentoo-sources

eselect kernel set 1

emerge --ask sys-apps/pciutils
cd /usr/src/linux
make menuconfig
make && make modules_install
make install

emerge --ask sys-kernel/dracut
dracut --kver=5.15.41-gentoo
