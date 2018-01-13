# Mounting


## Find the Mounting point of a disk

The information about the mount point is in `/proc/mounts` and the program `mount`
stores similar information in `/etc/mtab`.
`/proc/mounts` is always updated but `/etc/mtab` could not be.

In both the first colun is the device path and the second is the mount point.

In linux there is a tool to find the mount point: `findmnt`
Also if installed `lsblk` can be used for the same purpose.


```
$ findmnt -nr -o target -S /dev/storage/home
/home
$ lsblk -o MOUNTPOINT -nr /dev/storage/home
/home
```

## Union Mount:


A union mount is a way of combining multiple directories into one that appears
to containg their combinated contents. Supported in linux. (unionfs).
