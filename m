Message-ID: <30554.212.77.162.22.1202496189.squirrel@www.entrap.de>
Date: Fri, 8 Feb 2008 19:43:09 +0100 (CET)
From: b52@entrap.de
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Subject: [Bridge] bond0: received packet with own address as source address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bonding-devel@lists.sourceforge.net, bridge@lists.linux-foundation.org, aoetools-discuss@lists.sourceforge.net


Hi,

I know this will get a little complicated and, cause I have no clue whose
fault it is, I'll post to all three lists..

First my network Setup:

/dev/etherd/e0.2           /eth0 -- switch1 -- AoEServer
              br0 -- bond0            |
                           \eth1 -- switch2

- switch1 and switch2 are connected.
- eth0 is connectet to switch 1.
- eth1 is connectet to switch 2.
- no spanning tree is running (cause you dont need it).
- I use bonding in active-backup mode of eth0 and eth1.
  eth0 is active
  eth1 is backup
- bond0 is in bridge br0
- Host is mounting a AoE device shared through br0 (from AoEServer)

In this Setup I am receiving periodically, every 60s this Kernel message:
bond0: received packet with own address as source address

I thought "it might be a broadcast loop. Broadcast outgoing from br0
through bond0, through eth0 over the switches looping back through eth1",
but this is not the case for ARP traffic, only for AoE traffic.
Here are some listings: (ethertype 0x88a2 is AoE)


In one shell i did:
mrbrown:/# arping -b -I br0 192.168.13.45
which is not existent


In a second shell i traced the active interface eth0:
mrbrown:/# tcpdump -XX -nvvi eth0 not port 22
tcpdump: WARNING: eth0: no IPv4 address assigned
tcpdump: listening on eth0, link-type EN10MB (Ethernet), capture size 96
bytes
20:14:21.195823 arp who-has 192.168.13.45 tell 255.255.255.255
        0x0000:  ffff ffff ffff 0002 b3c7 e55e 0806 0001  ...........^....
        0x0010:  0800 0604 0001 0002 b3c7 e55e ffff ffff  ...........^....
        0x0020:  0000 0000 0000 c0a8 0d2d                 .........-
20:14:21.692671 00:02:b3:c7:e5:5e > ff:ff:ff:ff:ff:ff, ethertype Unknown
(0x88a2), length 32:
        0x0000:  ffff ffff ffff 0002 b3c7 e55e 88a2 1000  ...........^....
        0x0010:  ffff ff01 0000 0000 0000 0000 0000 0000  ................
20:14:21.692679 00:02:b3:c7:e5:5e > ff:ff:ff:ff:ff:ff, ethertype Unknown
(0x88a2), length 32:
        0x0000:  ffff ffff ffff 0002 b3c7 e55e 88a2 1000  ...........^....
        0x0010:  ffff ff01 0000 0000 0000 0000 0000 0000  ................


In a third shell i traced the backup interface eth1:
mrbrown:/# tcpdump -XX -nvvi eth1
tcpdump: WARNING: eth1: no IPv4 address assigned
tcpdump: listening on eth1, link-type EN10MB (Ethernet), capture size 96
bytes
20:13:21.702832 00:02:b3:c7:e5:5e > ff:ff:ff:ff:ff:ff, ethertype Unknown
(0x88a2), length 32:
        0x0000:  ffff ffff ffff 0002 b3c7 e55e 88a2 1000  ...........^....
        0x0010:  ffff ff01 0000 0000 0000 0000 0000 0000  ................
20:14:21.692686 00:02:b3:c7:e5:5e > ff:ff:ff:ff:ff:ff, ethertype Unknown
(0x88a2), length 32:
        0x0000:  ffff ffff ffff 0002 b3c7 e55e 88a2 1000  ...........^....
        0x0010:  ffff ff01 0000 0000 0000 0000 0000 0000  ................

and these two packets at eth1 cause that error message. But this too
packets should be ignored by the kernel, cause this nic is backup. ARP
traffic is ignored by the Kernel.

Actually we need this setup in a produktive environment, to get High
Availability Virtual Machines at one Host. STP on the bridge is just too
slow to live without bonding, and RSTP is not available in Kernel.

Thanks, bye,
Holger Lechner

