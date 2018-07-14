#!/usr/bin/env bash

# Get the diver name to unmount
disk=`readlink -f /dev/disk/by-label/Seagate*`

udisksctl unmount --block-device $disk && udisksctl power-off --block-device $disk