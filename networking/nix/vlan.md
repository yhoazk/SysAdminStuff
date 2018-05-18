Enable VLAN in qemu:

crate the adapter:

`ip link add link eth0 name eth0.$i type vlan id $i`

as option to the command `vconfig`.

To get information about the packets received in the 
created interface. Check

```
cat /proc/net/vlan/eth0.$i
```

No we need to add the configuration to the interface.
`ifconfig eth0.$i 192.168.1.21 netmask 255.255.255.0 up`

For this to work we need to add the configuration on the router.

View the routing table:

`netstat -rn`
or 
`route`

It depends on hte specific switch if the tagget packets are discarded or
forwarded. There are at least two problems the vlan unaware shitch will
encounter:

- The 802.1q tagged packet will have a non-std ethertype specified in the
frame which will not be recognized. At this point it will either drop the 
frame as damaged or pass it regardless.

- 802.1q adds a few bytes to the frame, in the case of large frames it'll
push them over the 1500 byte MTU, Again the switch will drop it or pass 
depending on how was the firmware written.

Lastly, how will it know which port to forward the frame out. Assuming its
going to after the two points.

in theory this should work as per normal switches, the first frame will be
flooded and then it will learn the MAC->port association and direct all
future traffic to that port.




