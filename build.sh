wget https://geo.mirror.pkgbuild.com/images/latest/Arch-Linux-x86_64-cloudimg.qcow2.SHA256
wget https://geo.mirror.pkgbuild.com/images/latest/Arch-Linux-x86_64-cloudimg.qcow2
sha256sum -c Arch-Linux-x86_64-cloudimg.qcow2.SHA256

modprobe nbd max_part=16
qemu-nbd --connect=/dev/nbd0 Arch-Linux-x86_64-cloudimg.qcow2
mkdir /mnt/arch
mount /dev/nbd0p2 /mnt/arch/
mount -o bind /dev /mnt/arch/dev/
mount -o bind /proc /mnt/arch/proc
mount -o bind /sys /mnt/arch/sys/
mkdir -p /mnt/arch/tmp/conf.d
cp -rv inc/* /mnt/arch/tmp/conf.d/
chroot /mnt/arch /bin/bash /tmp/configure.sh

