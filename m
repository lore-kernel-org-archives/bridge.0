In-reply-to: <30554.212.77.162.22.1202496189.squirrel@www.entrap.de> 
References: <30554.212.77.162.22.1202496189.squirrel@www.entrap.de>
Date: Fri, 08 Feb 2008 11:45:30 -0800
Message-ID: <30252.1202499930@death>
From: Jay Vosburgh <fubar@us.ibm.com>
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
To: b52@entrap.de
Cc: bridge@lists.linux-foundation.org, bonding-devel@lists.sourceforge.net, aoetools-discuss@lists.sourceforge.net

b52@entrap.de wrote:

>- switch1 and switch2 are connected.
>- eth0 is connectet to switch 1.
>- eth1 is connectet to switch 2.
>- no spanning tree is running (cause you dont need it).
>- I use bonding in active-backup mode of eth0 and eth1.
>  eth0 is active
>  eth1 is backup
>- bond0 is in bridge br0
>- Host is mounting a AoE device shared through br0 (from AoEServer)
>
>In this Setup I am receiving periodically, every 60s this Kernel message:
>bond0: received packet with own address as source address
>
>I thought "it might be a broadcast loop. Broadcast outgoing from br0
>through bond0, through eth0 over the switches looping back through eth1",
>but this is not the case for ARP traffic, only for AoE traffic.

	I'd guess it probably is a broadcast loop.

>Here are some listings: (ethertype 0x88a2 is AoE)
[...]
>and these two packets at eth1 cause that error message. But this too
>packets should be ignored by the kernel, cause this nic is backup. ARP
>traffic is ignored by the Kernel.

	What distro, kernel and version of bonding are you running (from
cat /proc/net/bonding/bond0)?  Older versions of bonding (prior to about
3.0.3, but distros may have the fix without having updated the version
number) do not drop incoming traffic on backup interfaces.  If your
bonding driver is too old, then upgrading it may very well make this
problem go away.

	I'm not sure offhand why the bridge complains about the 0x88a2
packets but doesn't complain about ARP packets; perhaps the ARP
processing happens before the bridge sees the packets.  If you run the
tcpdumps when doing the arping, do you see the ARP frames coming in on
eth0 and eth1?

>Actually we need this setup in a produktive environment, to get High
>Availability Virtual Machines at one Host. STP on the bridge is just too
>slow to live without bonding, and RSTP is not available in Kernel.

	Just out of curiosity, why are you using a bridge?  Are you
bridging some other interfaces that you're not describing (i.e., I'm not
sure why you'd have a bridge with just one interface in it)?

	-J

---
	-Jay Vosburgh, IBM Linux Technology Center, fubar@us.ibm.com
