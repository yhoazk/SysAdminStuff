# Create a virtual USB

Use `fallocate`:
```
fallocate -l 4000M virtual_usb.img
```

Set a virtual file system in that img.
```
mkfs -t ext4 virtual_usb.img
```

Create a mount point:
```
mkdir /media/usb_mnt
```

Mount the usb:

```
mount -t auto -o loop ./virtual_usb.img /media/usb_mnt
```
