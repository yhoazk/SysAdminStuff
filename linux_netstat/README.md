# Debug Network issues

## IP tables

### Get logging 

```
iptables -A INPUT -j LOG --log-level 4
```

We can also add a specific tag to the log:

```
iptables -A INPUT -s 192.168.0.1 -j LOG --log-prefix '***SUSPECT***'
```
To change the file for the logs, edit the configuration fiel `/etc/rsyslog.conf`
and add the line `kern.warninig /var/log/iptables.log` and restart the system
in fedora with `sudo systemctl restart firewalld` and the same for `syslogd`

## Find host in the network

First cleant the `arp` register. When a ping is send it also sends an arp request.
After the hosts response, check the arp responses with `arp -a`. 

This option works in linux, where the broadcast option is present.
```bash
arp -c
ping -b 192.168.1.255
arp -a
```

For windows, a explicit broadcast has to be crafted:

```batch
arp -c
for /l %i in (1,1,254) do ping -w 50 -n 1 192.168.0.%i
arp -a
```



## Monitor outgoing connections:

netstat -nputw

netstat -antup
Here it can monitor all(a) listening numeric (n) tcp (t) and udp (u) process (p).


Command: `ss`


## Route command

The command route is used to lookup the gatway and the interface
which the system will use when trying to connect to the outside.

Example:
```
$ route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         gateway         0.0.0.0         UG    100    0        0 enp0s3
10.0.2.0        0.0.0.0         255.255.255.0   U     100    0        0 enp0s3
```

* The address `0.0.0.0` in the Gateway says that there is no gateway configured.
    And the destination is reacheable right on that interface. No actual gateway 
    will be used. This assunes that the network is locally connected, there are
    no intermediate hops.
* The destination `0.0.0.0/0` is special. If there are no network bits, there 
 cant be anything in the network number either. So



The address `0.0.0.0` is only used in routing tables NOT for assigning to a host.
More information about the 0 address: https://en.wikipedia.org/wiki/0.0.0.0
And for other _special_ IP addresses: https://tools.ietf.org/html/rfc5735


## [How to add a route to the table route:](http://linux-ip.net/html/basic-changing.html)

* The gateway is a intermediary in the hops.

### How to add a static route to a specific host
We do not need to specify the gateway if we expect to have direct connection to it.

```
ip route add x.x.x.x/mm via y.y.y.y dev eth1
```
Where `x.x.x.x` is the target host, `mm` is the mask. And `y.y.y.y` is the gateway.
In the case that thre's no GW this is the syntax of the command: 
```
ip route add 192.168.0.1 dev eth0
```
This way all the traffic that goes to `192.168.0.1/32` will try to get through `eth0`


## Tunneling
https://wiki.linuxfoundation.org/networking/tunneling
Tunneling is a wa to transform data frames to allow them to pass networks with
incompatible address spaces or even incompatible protocols. Linux supports 
3 tunnel types. `IPIP` IPv4 in IPv6 `GRE` IPv4/IPv& over IPv4 and `SIT` IPv6 over
IPv4.

### IPIP tunnels

Use case??
