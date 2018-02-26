#!/bin/bash

cp raspbian_lite_latest.img mypi.img
cp u-boot/u-boot u-boot.img


qemu-system-aarch64 \
  -machine virt \
  -cpu cortex-a53 \
  -kernel uboot-a53 \
  -m 2G \
  -serial stdio \
  -display gtk \
  -sd mypi.img \
  #-drive file=mypi.img,format=raw,if=virtio,id=d0 
  #-device virtio-blk-device,drive=d0 

#-netdev tap,id=net0,ifname=tap74,script=no \
#-device virtio-net-pci,netdev=net0

# -nographic \
#-dtb vexpress-v2p-ca15-tc1.dtb \
#-smp cpus=1,cores=4,threads=1,maxcpus=4 \
