#!/bin/bash

cp kernel-config linux-stable/.config

cd linux-stable

export PATH=`pwd`/../gcc-linaro-7.2.1-2017.11-i686_arm-linux-gnueabihf/bin:$PATH

make ARCH=arm clean
make \
  ARCH=arm \
  CROSS_COMPILE=arm-linux-gnueabihf- \
  LOADADDR=0x60008000 \
  zImage \
  dtbs \
  uImage \
  -j`nproc`
