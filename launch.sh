#!/bin/bash

cp raspbian_lite_latest.img mypi.img
cp u-boot/u-boot u-boot.img

qemu-system-aarch64 \
  -kernel u-boot.img \
  -machine vexpress-a15 \
  -cpu cortex-a53 \
  -m 2G \
  -nographic \
  -drive file=mypi.img,format=raw

#-smp cpus=1,cores=4,threads=1,maxcpus=4 \
