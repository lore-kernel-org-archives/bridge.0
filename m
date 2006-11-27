Message-ID: <8df274a50611262348g370f5164l7a75e740941e8c00@mail.gmail.com>
Date: Mon, 27 Nov 2006 08:48:07 +0100
From: "Wojtek Mitus" <woytekm@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_48410_22097153.1164613687619"
Subject: [Bridge] tcpdump/pcap problem
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_Part_48410_22097153.1164613687619
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello
I have a problem with running tcpdump on network devices used in bridge
group:
The bridge configuration is as follows:

/usr/sbin/brctl addbr br0
/usr/sbin/brctl stp br0 no
/sbin/ifconfig eth0 up
/usr/sbin/brctl addif br0 eth0
/usr/sbin/brctl addif br0 wlan0

brctl show command output:

# brctl show
bridge name     bridge id               STP enabled     interfaces
br0             8000.0014bf6f81b2       no              eth0
                                                       wlan0

ifconfig command output:

# ifconfig
br0             Link encap:Ethernet  HWaddr 00:14:BF:6F:81:B2
                inet addr:10.1.1.201  Bcast:192.168.1.255  Mask:
255.255.255.0
                UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
                RX packets:9541 errors:0 dropped:0 overruns:0 frame:0
                TX packets:2717 errors:0 dropped:0 overruns:0 carrier:0
                collisions:0 txqueuelen:100
                RX bytes:1806483 (1.7 MiB)  TX bytes:312466 (305.1 KiB)

eth0            Link encap:Ethernet  HWaddr 00:14:BF:6F:81:B2
                UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
                RX packets:10111 errors:0 dropped:0 overruns:0 frame:0
                TX packets:3139 errors:0 dropped:0 overruns:0 carrier:0
                collisions:0 txqueuelen:100
                RX bytes:1897558 (1.8 MiB)  TX bytes:354798 (346.4 KiB)

lo              Link encap:Local Loopback
                inet addr:127.0.0.1  Mask:255.0.0.0
                UP LOOPBACK RUNNING  MTU:16436  Metric:1
                RX packets:0 errors:0 dropped:0 overruns:0 frame:0
                TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
                collisions:0 txqueuelen:0
                RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

wlan0           Link encap:Ethernet  HWaddr 00:14:BF:6F:81:B2
                UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
                RX packets:435 errors:0 dropped:0 overruns:0 frame:0
                TX packets:5853 errors:0 dropped:0 overruns:0 carrier:0
                collisions:0 txqueuelen:100
                RX bytes:42715 (41.7 KiB)  TX bytes:625334 (610.6 KiB)

The problem is that tcpdump does not show any traffic when attached to eth0
or wlan0. Traffic directed to the bridging device is visible on br0. What
should I do to make tcpdump see traffic entering eth0 and wlan0 ? Note that
this is an embedded MIPS based device with binary only network interface
kernel modules ( linksys router running linux ) .

tcpdump/pcap versions:
tcpdump version 3.9.5
libpcap version 0.9.5

WoytekM

------=_Part_48410_22097153.1164613687619
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello<br>
I have a problem with running tcpdump on network devices used in bridge group:<br>
The bridge configuration is as follows:<br>
<br>
/usr/sbin/brctl addbr br0<br>
/usr/sbin/brctl stp br0 no<br>
/sbin/ifconfig eth0 up<br>
/usr/sbin/brctl addif br0 eth0<br>
/usr/sbin/brctl addif br0 wlan0<br>
<br>
brctl show command output:<br>
<br>
# brctl show<br>
bridge name&nbsp;&nbsp;&nbsp;&nbsp; bridge
id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
STP enabled&nbsp;&nbsp;&nbsp;&nbsp; interfaces<br>
br0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
8000.0014bf6f81b2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
eth0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
wlan0<br>
<br>
ifconfig command output:<br>
<br>
# ifconfig<br>
br0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Ethernet&nbsp; HWaddr 00:14:BF:6F:81:B2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
inet addr:<a href="http://10.1.1.201">10.1.1.201</a>&nbsp; Bcast:<a href="http://192.168.1.255">192.168.1.255</a>&nbsp; Mask:<a href="http://255.255.255.0">255.255.255.0</a><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
UP BROADCAST RUNNING PROMISC MULTICAST&nbsp; MTU:1500&nbsp; Metric:1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
RX packets:9541 errors:0 dropped:0 overruns:0 frame:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
TX packets:2717 errors:0 dropped:0 overruns:0 carrier:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 txqueuelen:100<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
RX bytes:1806483 (1.7 MiB)&nbsp; TX bytes:312466 (305.1 KiB)<br>
<br>
eth0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Ethernet&nbsp; HWaddr 00:14:BF:6F:81:B2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
UP BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp; Metric:1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
RX packets:10111 errors:0 dropped:0 overruns:0 frame:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
TX packets:3139 errors:0 dropped:0 overruns:0 carrier:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 txqueuelen:100<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
RX bytes:1897558 (1.8 MiB)&nbsp; TX bytes:354798 (346.4 KiB)<br>
<br>
lo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Local Loopback<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
inet addr:<a href="http://127.0.0.1">127.0.0.1</a>&nbsp; Mask:<a href="http://255.0.0.0">255.0.0.0</a><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
UP LOOPBACK RUNNING&nbsp; MTU:16436&nbsp; Metric:1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
RX packets:0 errors:0 dropped:0 overruns:0 frame:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
TX packets:0 errors:0 dropped:0 overruns:0 carrier:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 txqueuelen:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
RX bytes:0 (0.0 B)&nbsp; TX bytes:0 (0.0 B)<br>
<br>
wlan0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Ethernet&nbsp; HWaddr 00:14:BF:6F:81:B2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
UP BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp; Metric:1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
RX packets:435 errors:0 dropped:0 overruns:0 frame:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
TX packets:5853 errors:0 dropped:0 overruns:0 carrier:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0 txqueuelen:100<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
RX bytes:42715 (41.7 KiB)&nbsp; TX bytes:625334 (610.6 KiB)<br>
<br>
The problem is that tcpdump does not show any traffic when attached to
eth0 or wlan0. Traffic directed to the bridging device is visible on
br0. What should I do to make tcpdump see traffic entering eth0 and
wlan0 ? Note that this is an embedded MIPS based device with binary
only network interface kernel modules ( linksys router running linux ) .<br>
<br>
tcpdump/pcap versions:<br>
tcpdump version 3.9.5<br>
libpcap version 0.9.5<br>
<br>
WoytekM<br>

------=_Part_48410_22097153.1164613687619--
