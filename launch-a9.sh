#!/bin/bash

cp img/piq.img .
cp u-boot/u-boot u-boot.img

if [[ -z $RAWBOOT ]] 
then
  # to dump the qemu specific dtb
  #-machine vexpress-a9,accel=tcg,usb=off,dumpdtb=vx9.dtb
  qemu-system-arm \
    -machine vexpress-a9,accel=tcg,usb=off \
    -cpu cortex-a9 \
    -kernel uboot-a9 \
    -m 1G \
    -dtb vexpress-v2p-ca9.dtb \
    -serial telnet:localhost:4400,server,nowait,nodelay \
    -nographic \
    -netdev tap,id=net0,ifname=tap74,script=no -device virtio-net-device,netdev=net0,id=net0,mac=52:54:00:a9:e1:27 \
    -netdev tap,id=net1,ifname=tap77,script=no -device virtio-net-device,netdev=net1,id=net1,mac=52:54:00:bb:ed:f2 \
    -sd piq.img
else
  qemu-system-arm \
    -machine vexpress-a9,accel=tcg,usb=off\
    -cpu cortex-a9 \
    -kernel ./linux-stable/arch/arm/boot/zImage \
    -dtb vexpress-v2p-ca9.dtb \
    -m 1G \
    -serial telnet:localhost:4400,server,nowait,nodelay \
    -nographic \
    -usb \
    -nodefaults \
    -no-user-config \
    -append "earlyprintk mem=1024M maxcpus=1 console=ttyAMA0 root=/dev/mmcblk0p2 rw rootwait panic=10" \
    -netdev tap,id=net0,ifname=tap74,script=no -device virtio-net-device,netdev=net0,id=net0,mac=52:54:00:a9:e1:27 \
    -netdev tap,id=net1,ifname=tap77,script=no -device virtio-net-device,netdev=net1,id=net1,mac=52:54:00:bb:ed:f2 \
    -sd piq.img
fi

#-chardev tty,id=pts47,path=/dev/pts/11 \
#-device isa-serial,chardev=pts47 \
  
###############################################################################
# u-boot instructions
#
# use the following commands to run raspbian from uboot
#-------------------------------------------------------
#
# => setenv ker_addr_r 0x60008000
# => setenv ftd_addr_r 0x61008000
# => fatload mmc 0:1 ${ker_addr_r} uImage
# => fatload mmc 0:1 ${ftd_addr_r} vexpress-v2p-ca9.dtb
# => setenv bootargs "earlyprintk mem=1024M maxcpus=1 console=ttyAMA0 root=/dev/mmcblk0p2 rw rootwait panic=10"
# => bootm ${ker_addr_r} - ${ftd_addr_r}
#
######################
