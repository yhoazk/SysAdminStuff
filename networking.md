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



### Vconfig

Allows to create and remove vlan-connection on a vlan-.enabled kernal.
VLan devices are virtual ethernet devices which represent the virtual lans on the pysical LAN

Vconfig can be preplaced with the ip command:

```
ip link add link eth0 name eth0.5 type vlan id 5
ìp link set eth0.5 up
```


### ptp4l 

Implementation of the precision time protocol according to the IEE 1588. 
It implements boundary clock and ordinary clock.

### brctl

used to setup, maintain and insepct the ethernet bridge configuration in the kernal.
Abridge is used to connect eth ports together. Can be replaced with `ip`

```
ip link add name br type bridge
ip link set dev br0 up
ip link set dev eth0 master br0
ip link set dev eth1 master br0
```

To remove an interface from the bridge
```
ip link set eth0 nomaster
ip link del br0
```

### Forwarding manipulation

To manipulate other aspects of the birdge like the FDB (Forwarding data base):
Show FDB for bridge br0
```
bridge fdb show dev br0
```

Disable a port from provessing BPDUs(Bridge protocol data unit) This will make the interface
filter any incoming bpdu.

```
bridge link set dev eth0 guard on
```

Setting STP (Spannig tree protocol) cost to a port:

```
bridge link set dev eth1 cost 3
```

To set root guard on eth0


```
bridge link set dev eth0 root_block on
```

Cost is calculated using some factors, and the link speed is one of them. 
Using a fix cost and disabling the processing of bpdus and enabling root_block is similar
to a `guard_root` feature from the switches.
O
Other features like vepa and hairpin mode can be found on bridge link subcommand list.

#### Bridge VLAN manipulation rules

the blan object from the birdge command will allow to create ingress/egress filters on the 
bridges. To show if there is any vlan ingress egress filters:

```
bridge vlan show
```

To add rules to a given interface

```
bridge vlan add dev eth1 <vod, pvid, untagged, self, master>
```

To remove rules. Use the same parameters as vlan add but detele a specific rule

```
bridge vlan delete dev eth1
```