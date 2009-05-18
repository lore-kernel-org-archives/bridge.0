Message-ID: <4A11714A.2000301@epfl.ch>
Date: Mon, 18 May 2009 16:31:38 +0200
From: Alexandre Becholey <alexandre.becholey@epfl.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] network bridging between wireless and wired connection
 fails Cont'd
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org
Cc: alexandre.becholey@epfl.ch

Hi

I have a similar problem than the one in this thread: 
https://lists.linux-foundation.org/pipermail/bridge/2009-May/006383.html
and the network is quite similar: 
http://inwww.epfl.ch/~becholey/network.jpg (every computer run linux 
there are no DHCP, every IP needs to be static)

when I try to ping PC1 from PC2 I can see the ARP "who-has" going to 
PC1. PC1 answers, I can see the ARP is at on the bridge (on any 
interfaces), but they don't arrive to PC2 => "Destination Host Unreachable"
when I try to ping PC2 from PC1 I can see on the bridge the ARP 
"who-has", but they don't arrive to PC2.
 From the bridge, I can ping everybody.

In both case I can see the number of packets increasing on the bridge 
with ifconfig, there are no drops and no errors..

The use of a bridge is not an option, because I need the same subnet 
(10.79.0.0) in the whole network :-/

Do you have an idea why the ARP packets can't be sent in "the air"? Or 
do you have a workaround for this?
I hope I provided enough information... Thanks in advance.

Best regards,

Alexandre Becholey

PS: here is the configuration of the bridge: (I tried with 2 different 
wireless card, one mini-PCI broadcom and a USB dongle ralink)
# brctl addbr br0
# ifconfig wlan0 0.0.0.0 up
# ifconfig eth0 0.0.0.0 up
# iwconfig wlan0 essid my_ssid
# brctl addif br0 wlan0
# brctl addif br0 eth0
# ifconfig br0 10.79.2.2 netmask 255.255.0.0 up
# dmesg
device eth0 entered promiscuous mode
br0: port 2(eth0) entering learning state
br0: port 1(wlan0) entering learning state
br0: no IPv6 routers present
br0: topology change detected, propagating
br0: port 2(eth0) entering forwarding state
br0: topology change detected, propagating
br0: port 1(wlan0) entering forwarding state

# ifconfig
br0       Link encap:Ethernet  HWaddr 00:21:E9:E7:AE:88 
          inet addr:10.79.2.2  Bcast:10.79.255.255  Mask:255.255.0.0
          inet6 addr: fe80::221:e9ff:fee7:ae88/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:6 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 b)  TX bytes:468 (468.0 b)

eth0      Link encap:Ethernet  HWaddr 00:22:41:30:92:18 
          inet6 addr: fe80::222:41ff:fe30:9218/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:59327 errors:0 dropped:0 overruns:0 frame:0
          TX packets:34860 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:28272439 (26.9 Mb)  TX bytes:5007876 (4.7 Mb)
          Interrupt:17

lo        Link encap:Local Loopback 
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:1665 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1665 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:2650847 (2.5 Mb)  TX bytes:2650847 (2.5 Mb)

wlan0      Link encap:Ethernet  HWaddr 00:21:E9:E7:AE:88 
          inet6 addr: fe80::221:e9ff:fee7:ae88/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2004 errors:0 dropped:0 overruns:0 frame:296525
          TX packets:799 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:150703 (147.1 Kb)  TX bytes:77417 (75.6 Kb)
          Interrupt:16

wmaster0  Link encap:UNSPEC  HWaddr 
00-1B-11-08-88-F8-00-00-00-00-00-00-00-00-00-00 
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)


