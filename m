In-Reply-To: <1ge3one.1m2b8mcymi2u4M@geos.net.eu.org>
From: geos@epost.de (Georg Schwarz)
Date: Sun, 30 May 2004 12:45:12 +0200
Message-ID: <1gelkt3.1hchrzdd83yzeM@geos.net.eu.org>
Subject: [Bridge] Re: Linux bridging code bounces back frames?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: buytenh@gnu.org, bridge@osdl.org, manty@debian.org

Thanks to all of you that have responded to my initial plea for help. In
the mean time I also tried kernel 2.6.6, but with identical results.
Interestingly that kernel constantly reported that it was reciving IP
packets with its own IP address as a source on eth1 (being the built-in
ICL EtherTeam 16i). Probably this is the same effect that for some reson
frames get reflected or or sent-incorectly to that interface.
So I built in another NIC. I tried both an Intel EtherExpress Pro/10+
ISA and a 3COM Etherlink III Combo (3c5x9): with both of them the
problem does not show up, and things work fine (so far :-). BTW, which
of the two would would prefer?
My ethernet setup (kernel 2.4.26) now looks like this, with only eth0
and eth1 being used for the bridge (eth2 remains unfonfigured for the
time being):

Kernel command line: auto BOOT_IMAGE=Linux ro root=301
ether=10,0x280,0xd0000,eth0 ether=11,0x300,eth1 ether=15,0x240,2,eth2
idebus=33

wd.c:v1.10 9/23/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)
eth0: WD80x3 at 0x280, 00 00 C0 0A 2C 2F WD8003-old, IRQ 10, shared
memory at 0x
d0000-0xd1fff.
 id: 0xb4  io: 0x300 eth1: Intel EtherExpress Pro/10+ ISA
 at 0x300, 00:a0:c9:29:f1:29, IRQ 11, 10BaseT.
eth16i.c: v0.35 01-Jul-1999 Mika Kuoppala (miku@iki.fi)
eth2: ICL EtherTeam 16i/32 at 0x240, IRQ 15, 00:00:4b:07:b3:9f TP 
interface.


the Intel EtherExpress Pro/10+ does not say it is eth1 in the dmesg. Is
this a cosmetic bug of the driver?

So it looks like the ICL EtherTeam 16i/32 driver is not compatible with
the bridging code. :-( Hard to say, for me at least, where the fault
is...     

If there is anything more I could do to track down the problem please
let me know.

Georg

PS: if you have any tips for improving bridging latency (pings in the
LAN are about 10 ms via the bridge) on my admittingly old system I would
appreciate if you could let me now.

Georg Schwarz <geos@epost.de> wrote:

> I'm trying to build a bridge using a 486DX2/66 with two 10 Mbit Ethernet
> NICs. The machine (tsushima) is running Debian stable and kernel 2.4.26.
> Previously I used it as a router, so I know the hardware (NICs) is
> working.
> The NICs are as follows:
> eth0: WD80x3 at 0x280, 00 00 C0 0A 2C 2F WD8003-old, IRQ 10, shared
> memory at 0xd0000-0xd1fff.
> eth16i.c: v0.35 01-Jul-1999 Mika Kuoppala (miku@iki.fi)
> eth1: ICL EtherTeam 16i/32 at 0x240, IRQ 15, 00:00:4b:07:b3:9f TP
> interface.
> 
> eth0 is a BNC network, if that matters.
> 



-- 
Georg Schwarz    http://home.pages.de/~schwarz/
 geos@epost.de     +49 177 8811442
