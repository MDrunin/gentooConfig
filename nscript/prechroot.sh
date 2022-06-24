#format disk
#sda1 - DOS boot 256M
#sda2 - swap 1G
#sda3 - / 

sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk /dev/sda
  o # create a DOS partition
  n # new partition
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk 
  +256M # 256 MB boot parttion
  n # new partition
  p # primary partition
  2 # partion number 2
    # default, start immediately after preceding partition
  +1G # 1 gig swap partition
  n # new partition
  p # primary partition
  3 # partion number 3
    # default, start immediately after preceding partition
    # default, extend partition to end of disk
  t # change mode of partition...
  2 # ...number 2 -- /dev/sda2
  82 # make it swap partition
  a # make a partition bootable
  1 # bootable partition is partition 1 -- /dev/sda1
  p # print the in-memory partition table
  w # write the partition table and quit
EOF


#Creating filesystem


#applying fs
mkfs.ext2 /dev/sda1
mkfs.ext4 /dev/sda3

#activating swap partition
mkswap /dev/sda2
swapon /dev/sda2

#mounting root partition
mount /dev/sda3 /mnt/gentoo

#untar stage3-*
cd /mnt/gentoo
tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner

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
