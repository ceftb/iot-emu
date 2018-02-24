# ceftb iot-emu

This repository contains code in support of iot device emulation for ceftb. Currently this includes

- u-boot build automation for qemu-system-aarch64:vexpress-a15:cortex-a53
- scripts to launch qemu-aarch64:vexpress-a15:coretex-a53 with u-boot bootloader

## Building

`make prepare`

## Running

`make run`

Right now this will just dump you into the u-boot console. However, the raspbian image is loaded on the first and only disk (see [launch.sh](launch.sh)).

## Terminating

In a different terminal

`pkill -f aarch`
