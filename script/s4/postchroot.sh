source /etc/profile
export PS1=\"(chroot) ${PS1}\"
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
