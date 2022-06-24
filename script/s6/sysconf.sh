#! /bin/bash

echo "/dev/sda1		/boot		ext2		noauto,noatime		0 2" >> /etc/fstab
echo "/dev/sda2		none		swap		sw		0 0" >> /etc/fstab
echo "/dev/sda3		/		ext4		noatime		0 1" >> /etc/fstab
echo "/dev/cdrom		/mnt/dcrom		auto		noauto,ro		0 0" >> /etc/fstab

sed -i -e "s/localhost/gentoo-vm/g" /etc/conf.d/hostname
emerge --noreplace net-misc/netifrc
printf "config_enp0s3=\"dhcp\"\n" >> /etc/conf.d/net

cd /etc/init.d
ln -s net.lo net.enp0s3
rc-update add net.enp0s3 default

emerge app-admin/sysklogd
rc-update add sysklogd default

emerge sys-apps/mlocate
emerge net-misc/dhcpcd

passwd

emerge net-misc/chrony
rc-update add chronyd default

emerge sys-fs/e2fsprogs

emerge net-misc/dhcpcd

emerge --verbose sys-boot/grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
useradd -m -G users,wheel,audio -s /bin/bash qemu_user
