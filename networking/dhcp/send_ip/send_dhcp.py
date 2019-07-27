#!/usr/bin/env python
"""
Waits for the request pkg on the given interface
and offers an IP in the given range
"""
from scapy.all import DHCP_am
from scapy.base_classes import Net
dhcp_server = DHCP_am(iface="enp2s0f0u13", domain="example.com",
                      pool=Net("192.168.3.0/24"),
                      network="192.168.3.0/24",
                      gw="192.168.3.254",
                      renewal_time=600, lease_time=3600)

dhcp_server()
#########
"""
ethernet=Ether(dst=dest_mac, src=hw, type=0x800)
ip=IP(dst=dest_addr, src=srv_ip)
udp=UDP(sport=67, dport=68)
bootp=BOOTP(op=2, yiaddr=dest_addr, siaddr=srv_ip, chaddr=client_mac)
dhcp=DHCP(options=[("message-type", "offer"), ("server_id", dest_addr), ("broadcast_address", broadcast), ("router", gateway), ("subnet_mask", netmask)])
of_pack=ethernet/ip/udp/bootp/dhcp

sendp(of_pack, iface="enp2s0f0u13")
"""