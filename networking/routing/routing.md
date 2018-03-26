# IPv4 Routing


## What routers do

A router connects different networks, without routers every network space is
isolated. Suppose we have two networks `192.168.1.0/24` and a `192.168.2.0/24`.
These networks cannot talk to each other without a router connecting them. These
are class C private networks with 254 usable address wach.

```
ipcalc 192.168.0.1/24
Address:	192.168.0.1
Network:	192.168.0.0/24
Netmask:	255.255.255.0 = 24
Broadcast:	192.168.0.255

Address space:	Private Use
Address class:	Class C
HostMin:	192.168.0.1
HostMax:	192.168.0.254
Hosts/Net:	254
```

The mask indicates what address are available in the network, the `24` indicates
that 24 bits are not to be used, this are from left to right masked. Then for a
mas 24 -> 24/8 = 3 bytes. Only one byte is left to assign.

Each octect can represent 256 values, but that does not give us 256 host
addresses because the first and last values, 0 and 255, are reserved.
- 0 is the network identifier
- 255 is the broadcast address.

That leaves 254 host addresses, but this doest not mean that there are not
addresses ending with 0 or 255. Suppose we have a 16 bit prefix:

```
ipcalc --info 192.168.1.0/16
Address:	192.168.1.0
Network:	192.168.0.0/16
Netmask:	255.255.0.0 = 16
Broadcast:	192.168.255.255

Address space:	Private Use
Address class:	Class C
HostMin:	192.168.0.1
HostMax:	192.168.255.254
Hosts/Net:	65534
```

With the 16 bit prefix, the range for HostMin and HostMax now allows to have
hosts with 0 and 255 address.


## CIDR: Classless Inter-Domain Routing

Defines how many addresses are in a network block. For the loopback address
`127.0.0.1/31` is just 2 addresses.
