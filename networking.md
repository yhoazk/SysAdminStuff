Troubleshooting network interfaces

check the network configuration:
```
/etc/network/interfaces
```
This file is not required for the network to work, its optional, if is not set 
de network is probably being managed by network manager, a system daemon that
makes things "just work"

Desktops and laptops usually want network manager, servers/embedded computers
want stuff configured in `/etc/network/interfaces`
