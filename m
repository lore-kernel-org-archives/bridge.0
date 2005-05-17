Message-ID: <a7243e5e0505171432191b05ed@mail.gmail.com>
Date: Tue, 17 May 2005 14:32:03 -0700
From: Shavian Shakes <shavian78@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Ip traffic not bridged
Reply-To: Shavian Shakes <shavian78@gmail.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi, I am trying to set up a bridge that connects 2 user mode linux
(UML) machines.  The bridge lets ARP traffic through, but not the IP
traffic.

 linux:~ # brctl showmacs br0
port no mac addr                is local?       ageing timer
  2     00:ff:7d:86:06:47       yes                0.00
  3     00:ff:bc:de:07:76       yes                0.00
  2     fe:fd:c0:a8:00:03       no                 0.29
  3     fe:fd:c0:a8:00:04       no                 8.36

The last 2 are the UML machines.   Using ebtables on the host with the
bridge  I can see that the IP packets go upto the FORWARD chain in
both ebtables and iptables after which they seem to disappear. ARP
packets proceed to the POSTROUTING chain and then out to the other UML
but IP packets never reach the POSTROUTING chain.

All the 240 packets seen on the POSTROUTING chain are ARP packets.The
remaining packets out of the 7424 packets on the PREROUTING hook never
appear at the POSTROUTING hook.  (Though they can be seen on the
FORWARD hook in both iptables and ebtables).

linux:~ # ebtables -t nat -L --Lc
Bridge table: nat

Bridge chain: PREROUTING, entries: 1, policy: ACCEPT
-s fe:fd:c0:a8:0:3 -j ACCEPT , pcnt = 7424 -- bcnt = 610120

Bridge chain: OUTPUT, entries: 1, policy: ACCEPT
-s fe:fd:c0:a8:0:3 -j ACCEPT , pcnt = 0 -- bcnt = 0

Bridge chain: POSTROUTING, entries: 1, policy: ACCEPT
-s fe:fd:c0:a8:0:3 -j ACCEPT , pcnt = 240 -- bcnt = 6720
linux:~ #



I am using Suse 9.0 :
linux:~ # uname -a
Linux linux 2.6.5-7.97-smp #1 SMP Fri Jul 2 14:21:59 UTC 2004 i686
i686 i386 GNU/Linux

Also I have cleared all the rules in iptables.  Any other
ideas/pointers will be a great help.

Shavian. 

ps: the ifconfig output: tap1 and tap2 are connected to UML1 and UML2
(fe:fd:c0:a8:00:03 and fe:fd:c0:a8:00:04 respectively )

linux:~ # ifconfig -a
br0       Link encap:Ethernet  HWaddr 00:FF:7D:86:06:47
          inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0
          inet6 addr: fe80::200:ff:fe00:0/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:595 errors:0 dropped:0 overruns:0 frame:0
          TX packets:514 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:46331 (45.2 Kb)  TX bytes:46754 (45.6 Kb)

eth0      Link encap:Ethernet  HWaddr 00:06:5B:ED:64:82
          inet addr:10.182.12.21  Bcast:10.255.255.255  Mask:255.255.240.0
          inet6 addr: fe80::206:5bff:feed:6482/64 Scope:Link
          UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
          RX packets:72262772 errors:0 dropped:0 overruns:0 frame:0
          TX packets:7567548 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:2437020880 (2324.1 Mb)  TX bytes:1394731482 (1330.1 Mb)
          Base address:0xdce0 Memory:feb60000-feb80000

eth1      Link encap:Ethernet  HWaddr 00:06:5B:ED:64:83
          inet6 addr: fe80::206:5bff:feed:6483/64 Scope:Link
          UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
          RX packets:189087447 errors:0 dropped:0 overruns:0 frame:0
          TX packets:73 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:2226851562 (2123.6 Mb)  TX bytes:6160 (6.0 Kb)
          Base address:0xdcc0 Memory:feb20000-feb40000

eth2      Link encap:Ethernet  HWaddr 00:02:B3:B2:71:D6
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Base address:0xcce0 Memory:fe920000-fe940000

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:338811 errors:0 dropped:0 overruns:0 frame:0
          TX packets:338811 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:178689430 (170.4 Mb)  TX bytes:178689430 (170.4 Mb)

sit0      Link encap:IPv6-in-IPv4
          NOARP  MTU:1480  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

tap0      Link encap:Ethernet  HWaddr FE:FD:00:00:00:00
          BROADCAST NOARP MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)


tap1      Link encap:Ethernet  HWaddr 00:FF:7D:86:06:47
          inet6 addr: fe80::2ff:7dff:fe86:647/64 Scope:Link
          UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
          RX packets:9904 errors:0 dropped:0 overruns:0 frame:0
          TX packets:363 errors:0 dropped:6 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:949776 (927.5 Kb)  TX bytes:15994 (15.6 Kb)

tap2      Link encap:Ethernet  HWaddr 00:FF:BC:DE:07:76
          inet6 addr: fe80::2ff:bcff:fede:776/64 Scope:Link
          UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
          RX packets:401 errors:0 dropped:0 overruns:0 frame:0
          TX packets:395 errors:0 dropped:12 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:21777 (21.2 Kb)  TX bytes:20004 (19.5 Kb)

