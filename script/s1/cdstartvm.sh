#!/bin/bash

qemu-system-x86_64 -enable-kvm -cdrom $1 -boot menu=on -drive file=image.img -m 4G -cpu host -smp 6 -vga virtio -display sdl,gl=on
