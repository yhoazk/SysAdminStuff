# The not so simple eject

There is a difference in how linux and windows "eject" a external HD.
This began with an external drive making a sad _noice_ when unpluged.
The noise was only when it was unpluged from a linux machine, but not 
from a windows machine.
![](img/noice.png)

This little sad noise was the spinning plate of the HD, only windows
stopped providing power to the HD, while the "eject" comand in linux
only `umount`ed the HD. This does not stopped the plates spinning.

Then in linux an extra command is needed to stop the plates:
```
udiskctl power-off -b /dev/sdb
```

### Tried this, didn't work
Also `eject` command provides this option:
```
man eject
...
-s, --scsi
  This option specifies that the drive should be ejected usign SCSI commands
```

Then the command should be:

```
sudo eject -s /dev/sdb
```
