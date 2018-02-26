# ceftb iot-emu

This repository contains code in support of iot device emulation for ceftb. Currently this includes

- Linux kernel build automation for versatile express platform
- u-boot build automation for qemu-system-aarch64:vexpress-a9:cortex-a9
- scripts to launch qemu-aarch64:vexpress-a15:coretex-a53 with u-boot bootloader

## Building

`make prepare-a9`

## Running

For instant satisfaction

`RAWBOOT=1 make run-a9`

For U-Boot

`make run-a9`

Right now this will just dump you into the u-boot console. However, the raspbian image is loaded on the first and only disk (see [launch.sh](launch.sh)).

## Terminating

In a different terminal (assuming you ahve no other `qemu-system-arm`s running)

`pkill -f qemu-system-arm`
