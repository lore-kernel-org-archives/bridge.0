Message-ID: <4AF184B7.2070307@aixigo.de>
Date: Wed, 04 Nov 2009 14:42:15 +0100
From: Harald Dunkel <harald.dunkel@aixigo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridge on bonding interface: DHCP replies don't get through
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org, bridge@lists.linux-foundation.org

Hi folks,

I would like to run a bridge for kvm on a bonding interface
(4 * 1Gbit, Intel e1000e). Problem: The DHCPDISCOVER packets
sent by the guest show up on my dhcp server as expected, but
the DHCPOFFER sent as a reply doesn't reach the guest behind
the bridge.

Using tcpdump on host and guest I can see the DHCPOFFER on
the bond0 and br0 interface, but it never shows up on vnet0
or on the guest's eth0.

If I drop the bonding interface and use the host's eth2 for
the bridge instead, then there is no such problem.

Kernel on host and guest is 2.6.31.5. Below you can find more
information about my setup. I had sent this information to the
linux kvm mailing list before, but consensus was that this is
a bridging problem. See

	http://www.spinics.net/lists/kvm/msg25153.html

Would it be possible to track this problem down? Any helpful
comment would be highly appreciated.


Many thanx

Harri
====================================================================
# brctl show
bridge name     bridge id               STP enabled     interfaces
br0             8000.001517ab0a59       no              bond0
                                                        vnet0
# ip addr list
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth2: <BROADCAST,MULTICAST,PROMISC,SLAVE,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast master bond0 state UP qlen 1000
    link/ether 00:15:17:ab:0a:59 brd ff:ff:ff:ff:ff:ff
3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN qlen 1000
    link/ether 00:30:48:c6:e0:98 brd ff:ff:ff:ff:ff:ff
4: eth3: <BROADCAST,MULTICAST,PROMISC,SLAVE,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast master bond0 state UP qlen 1000
    link/ether 00:15:17:ab:0a:59 brd ff:ff:ff:ff:ff:ff
5: _rename: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN qlen 1000
    link/ether 00:30:48:c6:e0:99 brd ff:ff:ff:ff:ff:ff
6: eth4: <BROADCAST,MULTICAST,PROMISC,SLAVE,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast master bond0 state UP qlen 1000
    link/ether 00:15:17:ab:0a:59 brd ff:ff:ff:ff:ff:ff
7: eth5: <BROADCAST,MULTICAST,PROMISC,SLAVE,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast master bond0 state UP qlen 1000
    link/ether 00:15:17:ab:0a:59 brd ff:ff:ff:ff:ff:ff
8: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP
    link/ether 00:15:17:ab:0a:59 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::215:17ff:feab:a59/64 scope link
       valid_lft forever preferred_lft forever
51: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN
    link/ether 00:15:17:ab:0a:59 brd ff:ff:ff:ff:ff:ff
    inet 172.19.96.25/23 brd 172.19.97.255 scope global br0
    inet6 fe80::215:17ff:feab:a59/64 scope link
       valid_lft forever preferred_lft forever
52: vnet0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UNKNOWN qlen 500
    link/ether c6:d7:7b:fb:02:35 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::c4d7:7bff:fefb:235/64 scope link
       valid_lft forever preferred_lft forever
# cat /proc/net/bonding/bond*
Ethernet Channel Bonding Driver: v3.5.0 (November 4, 2008)

Bonding Mode: load balancing (round-robin)
MII Status: up
MII Polling Interval (ms): 100
Up Delay (ms): 0
Down Delay (ms): 0

Slave Interface: eth2
MII Status: up
Link Failure Count: 0
Permanent HW addr: 00:15:17:ab:0a:59

Slave Interface: eth3
MII Status: up
Link Failure Count: 0
Permanent HW addr: 00:15:17:ab:0a:58

Slave Interface: eth4
MII Status: up
Link Failure Count: 0
Permanent HW addr: 00:15:17:ab:0a:5b

Slave Interface: eth5
MII Status: up
Link Failure Count: 0
Permanent HW addr: 00:15:17:ab:0a:5a



