#!/bin/bash

set -e

cp kernel-config linux-stable/.config
cp vexpress-v2p-ca9.dts.qemu linux-stable/arch/arm/boot/dts/vexpress-v2p-ca9.dts

cd linux-stable

# copy dtb with virtio devices into kernel tree

export PATH=`pwd`/../gcc-linaro-7.2.1-2017.11-i686_arm-linux-gnueabihf/bin:$PATH

#make ARCH=arm clean
make \
  ARCH=arm \
  CROSS_COMPILE=arm-linux-gnueabihf- \
  LOADADDR=0x60008000 \
  zImage \
  dtbs \
  uImage \
  modules \
  -j`nproc`
