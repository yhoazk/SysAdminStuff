# Auto-IP a.k.a. Zero-conf
[src](https://www.brennan.id.au/04-Network_Configuration.)

Linux supports the handling of auto-ip, in the network configuration file:
`/etc/sysconf/network` the setting `NOZEROCONF=yes`. The value for the
`NOZEROCONF` parameter can actually be set to any value, the initscripts only
check to determine whether the parameter has zero length.
So setting `NOZEROCONF=no` will have the same effect as setting it to `yes`.
You will need to comment or remove the variable to reactive `ZEROCONF`.