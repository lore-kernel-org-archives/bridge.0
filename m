From: geos@epost.de (Georg Schwarz)
Date: Thu, 20 May 2004 23:03:56 +0200
Message-ID: <1ge3one.1m2b8mcymi2u4M@geos.net.eu.org>
Subject: [Bridge] Linux bridging code bounces back frames?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: buytenh@gnu.org, bridge@osdl.org, manty@debian.org

Hi,

I'm trying to build a bridge using a 486DX2/66 with two 10 Mbit Ethernet
NICs. The machine (tsushima) is running Debian stable and kernel 2.4.26.
Previously I used it as a router, so I know the hardware (NICs) is
working.
The NICs are as follows:
eth0: WD80x3 at 0x280, 00 00 C0 0A 2C 2F WD8003-old, IRQ 10, shared
memory at 0xd0000-0xd1fff.
eth16i.c: v0.35 01-Jul-1999 Mika Kuoppala (miku@iki.fi)
eth1: ICL EtherTeam 16i/32 at 0x240, IRQ 15, 00:00:4b:07:b3:9f TP
interface.

eth0 is a BNC network, if that matters.

I'm using the bridge-utils 0.95-2 from Debian stable, and I've set up
br0 with eth0 and eth1 via the interfaces script, as found in the
examples. There I've also assigned a static IP to br0 to access the
machine (bridge) from remote:

tsushima:/etc/network# grep -v ^# interfaces 

auto lo
iface lo inet loopback

auto br0
iface br0 inet static
    address 192.168.0.225
    network 192.168.0.0
    netmask 255.255.255.0
    broadcast 192.168.0.255
    gateway 192.168.0.1
    bridge_ports eth0 eth1



Now the problem is that the bridge appears to sometimes "reflect" frames
received on eth0 back to eth0. When I ping from one PC another PC on the
same side (eth0) of the bridge, i.e. in the same collision domain, I
often get duplicate replies when the bridge is running and connected
(and only then). This is not normal behaviour, is it? Is this a known
problem?

I tried to nail down the problem. On the eth0 side there is a host
192.168.0.1 and a host 192.168.0.39 (00:A0:24:CF:E8:8E).
On the bridge with brctl showmacs br0 I can see where 00:A0:24:CF:E8:8E
is supposed to be. It should be on port no. 1. Nevertheless,  
brctl showmacs br0 sometimes shows the 00:a0:24:cf:e8:8e on port no. 2,
i.e. eth1. This is when the duplicates/reflections occur.

At one instance:

tsushima:/etc# brctl showmacs br0
port no mac addr                is local?       ageing timer
  2     00:00:4b:07:b3:9f       yes                0.00
  2     00:00:c0:0a:26:69       no                10.52
  1     00:00:c0:0a:2c:2f       yes                0.00
  2     00:10:a4:8d:b1:85       no                21.38
  2     00:a0:24:cf:e8:8e       no                 0.37
  1     08:00:07:d6:8e:f5       no                 0.04
  1     08:00:69:06:99:59       no                19.79

then after unplugging eth1 on the bridge and pinging from 192.168.0.1 to
192.168.0.39:

tsushima:/etc# brctl showmacs br0
port no mac addr                is local?       ageing timer
  2     00:00:4b:07:b3:9f       yes                0.00
  1     00:00:c0:0a:26:69       no                36.85
  1     00:00:c0:0a:2c:2f       yes                0.00
  2     00:10:a4:8d:b1:85       no               246.98
  1     00:a0:24:cf:e8:8e       no                44.13
  1     08:00:07:d6:8e:f5       no                 0.05
  1     08:00:69:06:99:59       no                21.68

Here, 00:10:a4:8d:b1:85 really on the eth1 (port 2) side; all other
(non-local) MACs are not.
How can this happen???


To get stop the phenomenon immediately, it turned out to be sufficient
unplug eth1 or to turn of the carrier on that interface. I've tried
several different machines connect to eth1 (via a TP cross cable). In
all cases the duplicates sooner or later did occur.

The bride does not work; I cannot ping through it; strangely though dhcp
does work through it, as does arp resolution.

My network is very simple. There's only that one bridge linking two
ethernet collission domains.
Unlike what /usr/share/doc/bridge-utils/README.Debian.gz says, STP seems
to be disabled by default. With the one-bridge network I have (no other
switches, really) this should not hurt though (and turning it on did not
make a difference).
In /etc/network/options both spoofprotect and ip_forwarding are set to
no (if that matters).
Could it be that ethernet broadcast frames are, under certain
conditions, reflected back to the incoming interface? 


Any help on figuring out what's going wrong would be very much
appreciated.

completely puzzled, Georg
  

-- 
Georg Schwarz    http://home.pages.de/~schwarz/
 geos@epost.de     +49 177 8811442
