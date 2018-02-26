#!/bin/bash

cp img/piq.img .
cp u-boot/u-boot u-boot.img

if [[ -z $RAWBOOT ]] 
then
  qemu-system-arm \
    -machine vexpress-a9 \
    -cpu cortex-a9 \
    -kernel uboot-a9 \
    -m 1G \
    -nographic \
    -sd piq.img
else
  qemu-system-arm \
    -machine vexpress-a9 \
    -cpu cortex-a9 \
    -kernel zImage \
    -dtb ./linux-stable/arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
    -m 1G \
    -nographic \
    -append "earlyprintk mem=1024M maxcpus=1 console=ttyAMA0 root=/dev/mmcblk0p2 rw rootwait panic=10" \
    -sd piq.img
fi
  
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
