From: "Mark Cave-Ayland" <m.cave-ayland@webbased.co.uk>
Subject: RE: [Bridge] Problem with bridge/8139too module under 2.4.27?
Date: Fri, 3 Dec 2004 09:17:36 -0000
Message-ID: <9EB50F1A91413F4FA63019487FCD251DACE8@WEBBASEDDC.webbasedltd.local>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20041202111108.25448eb8@dxpl.pdx.osdl.net>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org


> -----Original Message-----
> From: Stephen Hemminger [mailto:shemminger@osdl.org] 
> Sent: 02 December 2004 19:11
> To: Mark Cave-Ayland
> Cc: bridge@lists.osdl.org
> Subject: Re: [Bridge] Problem with bridge/8139too module under 2.4.27?
> 
(cut)

> > Nov 14 13:22:13 src@Devil kernel: unregister_netdevice: waiting for 
> > br0 to become free. Usage count = 2
> > 
> > This message is repeatedly output to the console until I 
> manually go 
> > and power cycle it. I've traced this through the startup/shutdown 
> > scripts, and have determine that the problem exists in the 
> following 
> > sequence of
> > commands:
> > 
> > brctl addbr br0
> > brctl addif br0 eth0
> > brctl addif br0 eth1
> > ifconfig eth0 up
> > ifconfig eth1 up
> > 
> > ifconfig eth0 down
> > ifconfig eth1 down
> > brctl delif eth0
> > brctl delif eth1
> 
> ifconfig br0 down
> 
> Take take the bridge down as well. The code on 2.4 is not as 
> robust or complete as 2.6 and probably needs that.
> 
> > brctl delbr br0   <------ This is where the problem occurs


Hi Stephen,

Thanks for the advice - I wasn't sure if the list had been abandoned or
someone had been away on holiday ;)

I tried what you suggested and the problem still occurs when taking the
bridge down. Here is the sequence of commands I used to take down the bridge
based on your suggestion:

ifconfig eth0 down
ifconfig eth1 down
brctl delif br0 eth0
brctl delif br0 eth1
ifconfig br0 down
brctl delbr br0

...and again the system hangs with the same unregister_netdevice error :(. I
did try swapping the Realteks for another card, and while I couldn't get
data in/out of the new cards due to driver issues, the kernel correctly
loaded the module and created the ethX and brX interfaces, and again when I
tried to reboot I still got the same error which leads me to believe it's
something in the bridge code.... Any other suggestions???? I've included the
output of "brctl show", "ifconfig" and "route" below (I've obscured the
public facing IPs which is where the bridge operates):


root@Devil:~ # brctl show
bridge name     bridge id               STP enabled     interfaces
br0             8000.00d07001064e       no              eth0
	
eth1

root@Devil:~ # ifconfig
br0       Link encap:Ethernet  HWaddr 00:D0:70:01:06:4E
          inet addr:219.X.X.X  Bcast:219.X.X.X  Mask:255.255.255.248
          inet6 addr: fe80::2d0:70ff:fe01:64e/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:270 errors:0 dropped:0 overruns:0 frame:0
          TX packets:541 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:51170 (49.9 KiB)  TX bytes:41669 (40.6 KiB)

eth0      Link encap:Ethernet  HWaddr 00:D0:70:01:06:4E
          inet6 addr: fe80::2d0:70ff:fe01:64e/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:245 errors:0 dropped:0 overruns:0 frame:0
          TX packets:511 errors:0 dropped:0 overruns:0 carrier:0
          collisions:7 txqueuelen:1000
          RX bytes:51415 (50.2 KiB)  TX bytes:40627 (39.6 KiB)
          Interrupt:21 Base address:0xda00

eth1      Link encap:Ethernet  HWaddr 00:E0:4C:0D:1F:A8
          inet6 addr: fe80::2e0:4cff:fe0d:1fa8/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:37 errors:0 dropped:0 overruns:0 frame:0
          TX packets:57 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:4820 (4.7 KiB)  TX bytes:3803 (3.7 KiB)
          Interrupt:22 Base address:0xdc00

eth2      Link encap:Ethernet  HWaddr 00:D0:70:01:04:6E
          inet addr:192.168.2.1  Bcast:192.168.2.255  Mask:255.255.255.0
          inet6 addr: fe80::2d0:70ff:fe01:46e/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:714 errors:0 dropped:0 overruns:0 frame:0
          TX packets:318 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:56874 (55.5 KiB)  TX bytes:54606 (53.3 KiB)
          Interrupt:17 Base address:0xdd00

eth3      Link encap:Ethernet  HWaddr 00:40:05:8B:EA:5A
          inet addr:192.168.3.1  Bcast:192.168.3.255  Mask:255.255.255.0
          inet6 addr: fe80::240:5ff:fe8b:ea5a/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:86 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:9982 (9.7 KiB)  TX bytes:208 (208.0 b)
          Interrupt:19 Base address:0xde00

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:30 errors:0 dropped:0 overruns:0 frame:0
          TX packets:30 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:3603 (3.5 KiB)  TX bytes:3603 (3.5 KiB)

root@Devil:~ # route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use
Iface
255.255.255.255 *               255.255.255.255 UH    0      0        0 eth2
219.X.X.X   *               255.255.255.248 U     0      0        0 br0
192.168.3.0     *               255.255.255.0   U     0      0        0 eth3
192.168.2.0     *               255.255.255.0   U     0      0        0 eth2
default         219.X.X.X   0.0.0.0         UG    0      0        0 br0

root@Devil:~ # uname -a
Linux Devil 2.4.27-grsec #1 SMP Wed Oct 13 19:56:13 EST 2004 i686
GenuineIntel unknown GNU/Linux


Kind regards,

Mark.

------------------------
WebBased Ltd
South West Technology Centre
Tamar Science Park
Plymouth
PL6 8BT 

T: +44 (0)1752 791021
F: +44 (0)1752 791023
W: http://www.webbased.co.uk



