Message-ID: <48D7AD8B.3000805@gmx.net>
Date: Mon, 22 Sep 2008 16:36:59 +0200
From: Michael Rennt <m.rennt@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Packets dropped at certain traffic (bridge performance
	tuning)
Reply-To: m.rennt@gmx.net
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bridge@lists.linux-foundation.org

Hi,

I'm trying to tweak the last bit out of our bridge/firewall. What is the maximum
anyone else is getting out of it's bridge in terms of packets per second (pps)?

Whenever outgoing traffic rises above a certain level, packets are getting
dropped at eth1 rx. Tweaking some of the well known sysctl variables doesn't
help either.

Here's the setup:

                    -----------------
(switch) ---- eth0 |      bridge     | eth1 -------- (switch)
                    -----------------
  dmz                                                   mz


* Kernel 2.6.26.4 (see more on bottom of this mail)
* Dual-Core AMD Opteron(tm) Processor 2210
* 4 GB RAM
* bridge-utils 1.2
* iptables
* eth0: Intel 82545GM Gigabit Ethernet (64-Bit PCI-X Slot)
  latest e1000
* eth1: Broadcom BCM5780 Gigabit Ethernet (onboard 64-Bit)
* 14 vlans, 1 bridge per vlan (i.e. br1 = eth0.1 + eth1.1, etc.)
* Cisco GBit switches

Here's what I tested so far:

* Setting sysctl variables to higher values (no effect)
* Changing TCP congestion control algorithm (no effect)
* Changing CPU affinity for eth0/eth1
  (slight improvement when eth0 -> CPU0, eth1 -> CPU1-3)
* Removing all iptables rules (slight improvement ~ +10k pps)
* nf_conntrack_max = 260864 (current usage ~ 140k entries)


When testing with a spare system in our lab, with 2 test machines in the dmz and
2 test machines in the mz, I'm reaching near wire speed (full duplex) in both
directions. On the live system maximum is something like this:


          mbit/s |   pkts/s |  drops/s | rx+tx pps | rx+tx mbps
eth0-rx      219 |    64344 |        0 |
eth0-tx      641 |    80846 |        0 |   145190 |      861
eth1-rx      618 |    76973 |     1119 |
eth1-tx      206 |    60326 |        0 |   137299 |      824

Note: This is messured on the production system.

Packets are getting dropped on eth1-rx at a level of around 55k pps rx / 42k pps
tx. Dropped packets are messured at /proc/net/dev.

Of course, the test setup mentioned doesn't simulate different packet sizes and
all of that. I'm rather using a fixed average size of around 1000 bytes per
packet, running iperf as well as pktgen to simulate the same amount of incoming
traffic, while trying to reach the maximum throughput for outgoing traffic.

But does the mixed packet sizes really cost about 350-380 MBit of throughput on
eth1-rx?

Any suggestions on how to further debug or even fix the problem are really
appreciated. I don't mind supplying more output if needed.





Important Kernel parameters:


<*> Packet socket
[*]   Packet socket: mmapped IO
<*> Unix domain sockets
< > PF_KEY sockets
[*] TCP/IP networking
[*]   IP: multicasting
[*]   IP: advanced router
       Choose IP: FIB lookup algorithm (choose FIB_HASH if unsure) (FIB_HASH)  --->
[*]   IP: policy routing
[*]   IP: equal cost multipath
[*]   IP: verbose route monitoring
[ ]   IP: kernel level autoconfiguration
<*>   IP: tunneling
< >   IP: GRE tunnels over IP
[ ]   IP: multicast routing
[ ]   IP: ARP daemon support (EXPERIMENTAL)
[*]   IP: TCP syncookie support (disabled per default)
< >   IP: AH transformation
< >   IP: ESP transformation
< >   IP: IPComp transformation
< >   IP: IPsec transport mode
< >   IP: IPsec tunnel mode
< >   IP: IPsec BEET mode
< >   Large Receive Offload (ipv4/tcp)
<*>   INET: socket monitoring interface
[*]   TCP: advanced congestion control  --->
[ ]   TCP: MD5 Signature Option support (RFC2385) (EXPERIMENTAL)
< >   IP virtual server support (EXPERIMENTAL)  --->
< >   The IPv6 protocol  --->
[ ] Security Marking
[*] Network packet filtering framework (Netfilter)  --->
< > The DCCP Protocol (EXPERIMENTAL)  --->
< > The SCTP Protocol (EXPERIMENTAL)  --->
< > The TIPC Protocol (EXPERIMENTAL)  --->
< > Asynchronous Transfer Mode (ATM)
<*> 802.1d Ethernet Bridging
<*> 802.1Q VLAN Support
< > DECnet Support
< > ANSI/IEEE 802.2 LLC type 2 Support
< > The IPX protocol
< > Appletalk protocol support
< > CCITT X.25 Packet Layer (EXPERIMENTAL)
< > LAPB Data Link Driver (EXPERIMENTAL)
< > Acorn Econet/AUN protocols (EXPERIMENTAL)
< > WAN router
[*] QoS and/or fair queueing  --->


Best,

Michael
