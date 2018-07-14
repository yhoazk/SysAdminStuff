# IPv4 Routing


### Ranges for private network address

`192.168.X.X` and `10.X.X.X` the ranges `172.16.0.0` - `172.31.255.255` is also
reserved but is not used that often.

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


## NAT Network Address

The NAT is a method by which IP addresses are mapped from one group to another,
transparent to the end users. Network Address Port Translation or NAPT is a
method by which many network addresses and their TCP/UDP ports are translated
into a single network address and TCP/UDP ports. Together, these two operations
referred to as traditional NAT, provide a mechanism to connect a realm with
private address to an external realm with globally unique registered addresses.

The need for IP address translation arises when a network's internal IP address
cannot be used outside the network either for provacy reasons or because they
are invalid for use outside of the network.



https://security.stackexchange.com/questions/44065/with-ipv6-do-we-need-to-use-nat-any-more

#### NAT Fordwarding Table

Some sort of hash table, where given an IP from one side of the network,
returns the IP of the other side of the network.

```
Inner <---> HomeRouter <---> ISPRouter <---> The Internet
```

Each router has its own table so it can translate between the two domains.
This is a simplification, as its possible to have 1:1 or 1:Many NAT.

## CIDR: Classless Inter-Domain Routing

Defines how many addresses are in a network block. For the loopback address
`127.0.0.1/31` is just 2 addresses.
