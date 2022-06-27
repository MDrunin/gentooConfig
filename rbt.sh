stage3 = $(ls /mnt/gentoo stage3*)
rm -rf $stage3
rm -rf /mnt/gentoo/gentooConfig
cd
umount -l /mnt/gentoo/dev{/shm,/pts,}
umount -R /mnt/gentoo

#will it work?
rm -rf /gentooConfig

reboot
