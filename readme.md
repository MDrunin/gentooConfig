Brief:

1. Create and start qemu VM in current directory. Pass your MinimalCD path as argument.
```
startqemu.sh /path/to/minimalcd.iso
```
2. Download this script to your VM.
```
cd /
wget https://github.com/MDrunin/gentooConfig/archive/refs/heads/main.zip
unzip main.zip
rm main.zip
```
3. Format disk. In my script I`m using DOS, sda1 as 256M boot partition with ext2 fs, sda2 as 1G swap partition, sda3 as root partition with ext4 fs.
```
formdisk.sh
```
4. Download stage3-* tar:
```
cd /mnt/gentoo
links https://gentoo.org/downloads
```
Choose and download stage3-openrc tar and then run:
```
cd
prechroot.sh
```
Choose your mirrors.

5. You are just chrooted, run:
```
postchroot.sh
```
Customize your kernel.
For qemu guest you need to config next options:
```
VIRTIO_BLK=y
VIRTIO_PCI=y
```
Set password for root user.

6. Last step - reboot
```
exit
rbt.sh
```


TODO:

Comments in scripts.

Manual config for /etc/fstab in case if user did their own fdisk.

Support for GPT setup (at this time only DOS supported).
