#untar stage3-*
cd /mnt/gentoo
stage3=$(ls stage3*)
tar xpvf $stage3 --xattrs-include='*.*' --numeric-owner

#set CFLAGS (for intel i7, 6 threads)
sed -i "s/^COMMON_FLAGS=.*/COMMON_FLAGS=\"-march=skylake -O2 -pipe\"/" /mnt/gentoo/etc/portage/make.conf
echo "MAKEOPTS=\"-j6\"" >> /mnt/gentoo/etc/portage/make.conf

#TODO: COMMENT THIS
mirrorselect -i -o >> /mnt/gentoo/etc/portage/make.conf

mkdir --parents /mnt/gentoo/etc/portage/repos.conf
cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf

cp --dereference /etc/resolv.conf /mnt/gentoo/etc/

cp -r /gentooConfig-main /mnt/gentoo/

mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount --bind /run /mnt/gentoo/run
mount --make-slave /mnt/gentoo/run

chroot /mnt/gentoo /bin/bash
