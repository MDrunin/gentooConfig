source /etc/profile

mount /dev/sda1 /boot

emerge-webrsync

#eselect news list
#eselect news read

eselect profile set 1

emerge --verbose --update --deep --newuse @world

#TODO USE

emerge app-portage/cpuid2cpuflags
echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use/00cpu-flags

echo "America/New_York" > /etc/timezone
emerge --config sys-libs/timezone-data

echo "en_US ISO-8859-1" >> /etc/locale.gen
echo "en_US.UTF-88 UTF-8" >> /etc/locale.gen
locale-gen
eselect locale set 6

env-update && source /etc/profile && export PS1="(chroot) ${PS1}"

emerge sys-kernel/gentoo-sources

eselect kernel set 1

emerge sys-apps/pciutils
cd /usr/src/linux
make menuconfig
make && make modules_install
make install

emerge sys-kernel/dracut
dracut --kver=5.15.41-gentoo

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
exit
