My config.

Brief:

This config creating QEMU VM with 20G space img, 6 threads, and 6G RAM.
Then its installing custom Gentoo on it.
Gentoo customization: using DOS, Intel Core2 with 6 treads, Generic Kernel
but with Intel Core2 optimization (no AMD options).

STAGE 0
Create QEMU VM.
You need to be in your working directory.
Run
```
./script/s0/mkqemuimg.sh X
```
script, where X - size of harddrive that you willing to give to your VM
Example:
```
./script/s0/mkqemuimg 20G
```
will create a harddrive with 20 gigs of space.

Now you have harddrive for your VM.

STAGE 1

Choosing medium

Download gentoo MinimalCD from https://www.gentoo.org/downloads/ and place it
in directory with your .img file, that you created at stage0.
Then run
```
./script/s1/cdstartvm.sh X
```
Where X - name of MinimalCD.
Example:
```
./script/s1/cdstartvm.sh install-amd64-minimal-20220619T170540Z.iso
```
Now you are inside your QEMU VM. Press enter couple of times and you
should be greeted with
```
livecd#
```

STAGE 2

Networking

Check your internet connection:
```
ping google.com
```
If you dont have network, follow instructions in 
wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Networking

If everything is good, you should download this script inside your VM:
```
wget https://github.com/MDrunin/gentooConfig/archive/refs/heads/main.zip
```
And unzip it:

```
unzip main.zip
cd gentooConfig-main
```

> **_NOTE:_** at this point all scripts should be started with your current pwd
but at this readme it will be starting just with /

At the end of this stage you should have network and scripts on your VM.
STAGE 3

Preparing the disk

> **_NOTE:_** in this script I`m using Dos and 1G for swap partition.
First of all, check the name of your haddrive device:
```
lsblk
```
Output should be something like:
```
fd0		...
loop0	...
sda (or vda) ...
sr0		...
```
Your harddrive name should be sda or vda, remember that and pass it
into next script:
```
/script/s3/formatdisk.sh X
```
X = sda, or X = vda

Examle:
```
/script/s3/formatdisk.sh sda
```

Now you prepared your disk. You can view your partition layout:
```
fdisk /dev/sda
p
q
```

Creating filesystem and applying it to a pertion

> **_NOTE:_** by default I use ext2 for boot, and ext4 for other

> **_NOTE:_** this script also mounting the root partition

Run
!!! TODO: VDA SUPPORT
```
/script/s3/createfs.sh
```
You just applyied fs for your partions, actvated swap pertition
and mounted root partition.


STAGE 4
STAGE 5
STAGE 6
STAGE 7
STAGE 8
STAGE 9
STAGE 10


Using OpenRC

Processor:		Intel Core2, 6 threads
Bootloader:		DOS bootloader


