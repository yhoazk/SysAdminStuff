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

## Who names the interfaces

It is necessary to differentiate between 3 steps:

- Predictable interface names
- `biosdevname`
- `70-persistent.rules`

The precedence for systemd and udev rules is: `/etc` then `/run` then `/lib`.

To check the current set-up:

```
# links
ls -l /*/systemd/network/

# rule that read links
ls -l /*/udev/rules.d/80-net-setup-link.rules

# rule that check for /etc/.../80-net-setup-link.rules & net.ifnames
ls -l /*/udev/rules.d/73-usb-net-by-mac.rules
```

### Predictable interface names

This is a `udev` thing that is described in `/lib/udev/rules.d/80-net-setup-link.rules`
systemd uses by default the new predictable interface name. But it has to be
opt-in as the upstream systemd is not always the integrated in the distro.
For this check  `net.ifnames=1`

The kernel command line has to be also correct to enable this renaming:

```
cat /etc/default/grub
:
:
GRUB_CMDLINE_LINUX_DEFAULT="... net.ifnames=1 ..."
:
:
```

After modification of that file, update the actual grub:
`sudo update-grub`

### `biosdevname`

This is a dell attempt to solve the interface naming problem.
This can be disabled by also setting a kernel commandl line:

```
cat /etc/default/grub
:
:
GRUB_CMDLINE_LINUX_DEFAULT="... biosdevname=0 ..."
:
:
```
After that update the grub config, but also the initramfs may contain the
`biosdevname`, so both have to be updated, there config in `/usr/share/initramfs-tools/hooks/biosdevname`
is removed but there is no postrm script to rebuild the initramfs in `/boot/initrd`

```
sudo update-grub
sudo update-initramfs -u
```
### BIOS vs Kernel Names


### Udev 

The `udev` rule `/lib/udev/rules.d/75-persistent-net-generator.rules` creates
during the first boot a custom rules `/lib/udev/rules.d/70-persistent-net.rules`
with the MAC address of the interface.

For example:

```
SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="e0:cb:ee:d7:ff:9a", ATTR{dev_id}=="0x0", ATTR{type}=="1", KERNEL=="eth*", NAME="eth0"
```

If the changes seem to not be applied verify the `/lib/udev/rules.d/` for a file
named persistency which contains the configuration of the first boot.

## Adjust the interface names

```
# remove the udev setting
ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules
# create the new rule
cat /etc/systemd/network/10-internet.link
[Match]
Path=pci-0000:(your device mac address)

[Link]
Name=eth0 (or whatever you want to name it)
```

Then reboot and adjust the file `/etc/network/interfaces`
