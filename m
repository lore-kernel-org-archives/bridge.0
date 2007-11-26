Date: Mon, 26 Nov 2007 08:50:40 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] BitTorrent crashes Linux firewall running bridging
Message-ID: <20071126085040.088db76c@freepuppy.rosehill.pdx.hemminger.net>
In-Reply-To: <8A55DBB97B4FBF4D9A6F23C92FE0F117EA3E01@BE08.exg3.exghost.com>
References: <200711222000.lAMK04RV009521@smtp2.linux-foundation.org>
	<8A55DBB97B4FBF4D9A6F23C92FE0F117EA3E01@BE08.exg3.exghost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jay Libove <libove@felines.org>
Cc: bridge@lists.linux-foundation.org

On Sat, 24 Nov 2007 17:29:05 -0500
"Jay Libove" <libove@felines.org> wrote:

> Hi Bridge folks -
> 
> I sent a note about this quite some time back, and have never resolved
> the problem.
> 
> I have a Linux system (based on Fedora, all packages current per 'yum'),
> running bridging.  It works fine ... except if I have BitTorrent traffic
> running through it, in which case it is guaranteed to crash repeatedly,
> sometimes with as little as a minute's worth of traffic going through it
> after a reboot before crashing again.
> 
> The firewall has a PCI quad Ethernet card with Digital DS21140 Tulip
> controllers on it. These are eth0, eth1, eth2, and eth3.
> 
> Here's the 'dmesg' output relating to this PCI quad Ethernet card:
> 
> Linux Tulip driver version 1.1.15 (Feb 27, 2007)
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
> PCI: setting IRQ 11 as level-triggered
> ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNKB] -> GSI 11 (level,
> low) -> IRQ 11
> tulip0:  EEPROM default media type Autosense.
> tulip0:  Index #0 - Media 10baseT (#0) described by a 21140 non-MII (0)
> block.
> tulip0:  Index #1 - Media 100baseTx (#3) described by a 21140 non-MII
> (0) block.
> tulip0:  Index #2 - Media 10baseT-FDX (#4) described by a 21140 non-MII
> (0) block.
> tulip0:  Index #3 - Media 100baseTx-FDX (#5) described by a 21140
> non-MII (0) block.
> eth0: Digital DS21140 Tulip rev 34 at MMIO 0xd5000000,
> 00:00:BC:11:56:D7, IRQ 11.
> ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNKC] -> GSI 5 (level, low)
> -> IRQ 5
> tulip1:  EEPROM default media type Autosense.
> tulip1:  Index #0 - Media 10baseT (#0) described by a 21140 non-MII (0)
> block.
> tulip1:  Index #1 - Media 100baseTx (#3) described by a 21140 non-MII
> (0) block.
> tulip1:  Index #2 - Media 10baseT-FDX (#4) described by a 21140 non-MII
> (0) block.
> tulip1:  Index #3 - Media 100baseTx-FDX (#5) described by a 21140
> non-MII (0) block.
> eth1: Digital DS21140 Tulip rev 34 at MMIO 0xd5001000,
> 00:00:BC:11:56:D6, IRQ 5.
> ACPI: PCI Interrupt 0000:02:06.0[A] -> Link [LNKD] -> GSI 10 (level,
> low) -> IRQ 10
> tulip2:  EEPROM default media type Autosense.
> tulip2:  Index #0 - Media 10baseT (#0) described by a 21140 non-MII (0)
> block.
> tulip2:  Index #1 - Media 100baseTx (#3) described by a 21140 non-MII
> (0) block.
> tulip2:  Index #2 - Media 10baseT-FDX (#4) described by a 21140 non-MII
> (0) block.
> tulip2:  Index #3 - Media 100baseTx-FDX (#5) described by a 21140
> non-MII (0) block.
> eth2: Digital DS21140 Tulip rev 34 at MMIO 0xd5002000,
> 00:00:BC:11:56:D5, IRQ 10.
> ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
> ACPI: PCI Interrupt 0000:02:07.0[A] -> Link [LNKA] -> GSI 11 (level,
> low) -> IRQ 11
> tulip3:  EEPROM default media type Autosense.
> tulip3:  Index #0 - Media 10baseT (#0) described by a 21140 non-MII (0)
> block.
> tulip3:  Index #1 - Media 100baseTx (#3) described by a 21140 non-MII
> (0) block.
> tulip3:  Index #2 - Media 10baseT-FDX (#4) described by a 21140 non-MII
> (0) block.
> tulip3:  Index #3 - Media 100baseTx-FDX (#5) described by a 21140
> non-MII (0) block.
> piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
> eth3: Digital DS21140 Tulip rev 34 at MMIO 0xd5003000,
> 00:00:BC:11:56:D4, IRQ 11.
> 
>  ... and some more 'dmesg' output of net interest:
> 
> NET: Registered protocol family 10
> lo: Disabled Privacy Extensions
> ADDRCONF(NETDEV_UP): eth2: link is not ready
> ADDRCONF(NETDEV_UP): eth3: link is not ready
> Mobile IPv6
> ADDRCONF(NETDEV_CHANGE): eth3: link becomes ready
> 
> ip_tables: (C) 2000-2006 Netfilter Core Team
> arp_tables: (C) 2002 David S. Miller
> Ebtables v2.0 registered
> Netfilter messages via NETLINK v0.30.
> nf_conntrack version 0.5.0 (4607 buckets, 36856 max)
> ip6_tables: (C) 2000-2006 Netfilter Core Team
> Bridge firewalling registered
> device eth3 entered promiscuous mode
> br0: port 1(eth3) entering learning state
> eth0: no IPv6 routers present
> eth1: no IPv6 routers present
> eth3: no IPv6 routers present
> br0: no IPv6 routers present
> tun: Universal TUN/TAP device driver, 1.6
> tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> tun0: Disabled Privacy Extensions
> tun1: Disabled Privacy Extensions
> tun2: Disabled Privacy Extensions
> br0: topology change detected, propagating
> br0: port 1(eth3) entering forwarding state
> ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready
> eth2: no IPv6 routers present
> 
> 
> Here's ifconfig -a output:
> 
> br0       Link encap:Ethernet  HWaddr 00:00:BC:11:56:D4  
>           inet6 addr: fe80::200:bcff:fe11:56d4/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:1033126 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:6 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0 
>           RX bytes:47748729 (45.5 MiB)  TX bytes:468 (468.0 b)
> 
> eth0      Link encap:Ethernet  HWaddr 00:00:BC:11:56:D7  
>           inet addr:216.xxx.xxx.xxx  Bcast:216.xxx.xxx.255
> Mask:255.255.255.0
>           inet6 addr: fe80::200:bcff:fe11:56d7/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:23941 errors:1 dropped:0 overruns:0 frame:0
>           TX packets:672809 errors:4 dropped:0 overruns:0 carrier:9
>           collisions:134 txqueuelen:1000 
>           RX bytes:13324751 (12.7 MiB)  TX bytes:57721426 (55.0 MiB)
>           Interrupt:11 Base address:0x8000 
> 
> eth0:1    Link encap:Ethernet  HWaddr 00:00:BC:11:56:D7  
>           inet addr:192.168.15.3  Bcast:192.168.15.255
> Mask:255.255.255.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           Interrupt:11 Base address:0x8000 
> 
> eth1      Link encap:Ethernet  HWaddr 00:00:BC:11:56:D6  
>           inet addr:192.168.255.5  Bcast:192.168.255.127
> Mask:255.255.255.128
>           inet6 addr: fe80::200:bcff:fe11:56d6/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:793455 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:452729 errors:4 dropped:0 overruns:0 carrier:10
>           collisions:837 txqueuelen:1000 
>           RX bytes:67810520 (64.6 MiB)  TX bytes:60778513 (57.9 MiB)
>           Interrupt:5 
> 
> eth2      Link encap:Ethernet  HWaddr 00:00:BC:11:56:D5  
>           inet addr:192.168.0.139  Bcast:192.168.0.255
> Mask:255.255.255.0
>           inet6 addr: fe80::200:bcff:fe11:56d5/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:11659 errors:70656 dropped:0 overruns:0 frame:0
>           TX packets:9318 errors:5 dropped:0 overruns:0 carrier:11
>           collisions:2 txqueuelen:1000 
>           RX bytes:10236933 (9.7 MiB)  TX bytes:1291086 (1.2 MiB)
>           Interrupt:10 Base address:0xc000 
> 
> eth3      Link encap:Ethernet  HWaddr 00:00:BC:11:56:D4  
>           inet6 addr: fe80::200:bcff:fe11:56d4/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:1070453 errors:1 dropped:0 overruns:0 frame:0
>           TX packets:859 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000 
>           RX bytes:78197874 (74.5 MiB)  TX bytes:36294 (35.4 KiB)
>           Interrupt:11 Base address:0x2000 
> 
> lo        Link encap:Local Loopback  
>           inet addr:127.0.0.1  Mask:255.0.0.0
>           inet6 addr: ::1/128 Scope:Host
>           UP LOOPBACK RUNNING  MTU:16436  Metric:1
>           RX packets:9669 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:9669 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0 
>           RX bytes:949740 (927.4 KiB)  TX bytes:949740 (927.4 KiB)
> 
> tun0      Link encap:UNSPEC  HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  
>           inet addr:192.168.253.1  P-t-P:192.168.253.2
> Mask:255.255.255.255
>           UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100 
>           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
> 
> tun1      Link encap:UNSPEC  HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  
>           inet addr:192.168.253.65  P-t-P:192.168.253.66
> Mask:255.255.255.255
>           UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100 
>           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
> 
> tun2      Link encap:UNSPEC  HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  
>           inet addr:192.168.253.129  P-t-P:192.168.253.130
> Mask:255.255.255.255
>           UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100 
>           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
> 
> Eth0 is connected to a 10Mbit Ethernet hub which is the outside segment
> of my network. Eth0 has my firewall's public Internet address
> (statically assigned, one of a group of static IPs assigned to me, by my
> ISP). Also on that outside Ethernet segment (that is, plugged in to that
> same hub) are the inside interface of a Vonage VoIP adaptor, and Eth3.
> 
> Eth1 is connected to my internal network.
> 
> Eth2 is my fallback interface which can be connected to e.g. my
> neighbor's WLAN (with their permission) when my own (unreliable) DSL
> service craps out. The vast majority of the time, Eth2 is not physically
> connected.
> 
> Eth3 is configured 'up' and has no IP address. Arptables is set up on
> this Linux host to answer proxy ARPs for the rest of my static IP
> address range, because the Vonage VoIP adaptor is too stupid to do so.
> If I do not have Eth3 able to answer ARPs from the outside world for my
> other static IP addresses, then only the Vonage VoIP adaptor's one
> static address out of my range of 10 addresses can be reached from the
> Internet. Sigh.  Yes, I need the VoIP adaptor outside the network like
> this, to perform traffic shaping. (I tried using Linux kernel traffic
> shaping, to insufficient effect).
> 
> The tun interfaces are for OpenVPN, which I pretty much never use
> anymore.
> 
> Here's the br0 configuration:
> 
> # brctl show
> bridge name     bridge id               STP enabled     interfaces
> br0             8000.0000bc1156d4       no              eth3
> 
> Here are the commands which set up that bridge:
> 
> # brctl addbr br0
> # brctl addif br0 eth3
> # ifconfig br0 0.0.0.0

Seems unrelated to the lines below (eth3 vs eth1)

> I have static ARP entries on this Linux firewall thus:
> 
> # arp -Ds 216.xxx.xxx.43 eth1 -i eth1 pub
> # route add -host 216.xxx.xxx.43 dev eth0 gw 192.168.15.1
> # for host in 42 44 45 46 47 48 49 50 51; do \
>    ebtables -t nat -A PREROUTING -i eth0 -p ARP \
>    --arp-op request --arp-ip-dst 216.xxx.xxx.$host \
>    -j arpreply --arpreply-mac $MAC_OF_VOIP_ADAPTOR_OUTER_INTERFACE;
> done
> 
> 
> 
> Any high level ideas on why BitTorrent traffic might crash the firewall
> with this bridge and ARP configuration?
> 
> What additional information would you like me to post to get help on
> this annoyance?

First, define "crash" more carefully.  I assume you mean that one or more
of the interfaces stops forwarding traffic, but that the console is still working.

Second, reduce the problem down.  Does it happen with only two interfaces in
the bridge?  Does it happen when you are not using any ebtables rules?

Lastly, identify which interface is not responding and whether it is not
receiving or transmitting.  You should still be able to use tcpdump/ethereal/wireshark
to capture packets even after the bridging stops.

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
