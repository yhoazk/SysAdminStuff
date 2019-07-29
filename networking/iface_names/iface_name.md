# Interface names

## With Systemd

The names are now, when it works, fixed and predictable.
the name is known before power-on with the command:

```
udevadm test-builtin net-id /sys/class/net/<iface>
```

## Previous to systemd

the names used to be `eth0` and `wlan` but the number depends in the order in
which the interfaces are discovered, which made this method un reliable and not
portable.


## List interfaces

to list the interfaces without the noise of the settings use the command: 

```
networkctl
```

