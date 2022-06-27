#! /bin/bash

#create .img harddrive for VM
qemu-img create -f qcow2 image.img 15G

#start VM with $1 CD
qemu-system-x86_64 -enable-kvm -cdrom $1 -boot menu=on -drive file=image.img -m 4G -cpu host -smp 6 -vga virtio -display sdl,gl=on
