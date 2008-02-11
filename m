Message-ID: <52483.212.77.162.22.1202732390.squirrel@www.entrap.de>
In-Reply-To: <30252.1202499930@death>
References: <30554.212.77.162.22.1202496189.squirrel@www.entrap.de>
	<30252.1202499930@death>
Date: Mon, 11 Feb 2008 13:19:50 +0100 (CET)
From: b52@entrap.de
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Re: [Bonding-devel] bond0: received packet with own
 address as source address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jay Vosburgh <fubar@us.ibm.com>
Cc: bridge@lists.linux-foundation.org, bonding-devel@lists.sourceforge.net, aoetools-discuss@lists.sourceforge.net

>>In this Setup I am receiving periodically, every 60s this Kernel message:
>>bond0: received packet with own address as source address

Actually this problem is SOLVED, Sam Hopkins wrote:
 You'll likely want to use aoe-interfaces to restrict the aoe initiator
 driver to only use br0.  By default it will use all interfaces it
 finds.
..and this solves the issue.

> 	What distro, kernel and version of bonding are you running (from
> cat /proc/net/bonding/bond0)?  Older versions of bonding (prior to about
> 3.0.3, but distros may have the fix without having updated the version
> number) do not drop incoming traffic on backup interfaces.  If your
> bonding driver is too old, then upgrading it may very well make this
> problem go away.
I use Version v3.1.2, with a selfbrewed Kernel (Vanilla 2.6.18 + GFS +
OpenVZ)

> 	I'm not sure offhand why the bridge complains about the 0x88a2
> packets but doesn't complain about ARP packets; perhaps the ARP
> processing happens before the bridge sees the packets.  If you run the
> tcpdumps when doing the arping, do you see the ARP frames coming in on
> eth0 and eth1?
No ARP was only on the active one, eth0.

>>Actually we need this setup in a produktive environment, to get High
>>Availability Virtual Machines at one Host. STP on the bridge is just too
>>slow to live without bonding, and RSTP is not available in Kernel.
>
> 	Just out of curiosity, why are you using a bridge?  Are you
> bridging some other interfaces that you're not describing (i.e., I'm not
> sure why you'd have a bridge with just one interface in it)?
Yes we use that bridge to get virtual machines at this host on the net.

Cheers,
Holger

