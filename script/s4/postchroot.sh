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
