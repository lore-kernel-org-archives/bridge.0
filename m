From: Jay Vosburgh <fubar@us.ibm.com>
In-reply-to: <1228350057.4344.141.camel@fuego>
References: <1228350057.4344.141.camel@fuego>
Date: Wed, 03 Dec 2008 16:46:56 -0800
Message-ID: <25142.1228351616@death.nxdomain.ibm.com>
Subject: Re: [Bridge] [Bonding-devel] received packet with own address as
	source address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Matthew Kent <matt@bravenet.com>
Cc: bridge@lists.linux-foundation.org, bonding-devel@lists.sourceforge.net

Matthew Kent <matt@bravenet.com> wrote:

>Trying to determine if I have a misconfiguration, misunderstanding or
>have stumbled on a bug.
>
>Have a CentOS 5.2 server with 2 e1000e nics in a balance-xor bond, check
>this out: 

	I suspect your switch is misconfigured.
	
	The balance-xor mode is nominally "Etherchannel compatible" and
the switch ports connected to bonding balance-xor should be in
Etherchannel mode ("Trunking", etc, but not "LACP" or "802.3ad").

	If the switch doesn't know the ports are aggregated, it may very
well send broadcasts recieved on one port back out the other port, which
may be the cause of what you're seeing.  The switch might also whine
about flapping of the MAC address.

	If I set up bonding here with the switch unconfigured for
Etherchannel, I see the same behavior as this:

ARPING 172.16.0.117 from 172.16.0.116 eth0
Unicast reply from 172.16.0.117 [00:15:17:70:A3:88]  0.607ms
Unicast reply from 172.16.0.117 [00:15:17:70:A3:88]  0.648ms
Sent 1 probes (1 broadcast(s))
Received 2 response(s)

	Specifically the "Received 2 response(s)" part.  This happens
because the bond receives one copy of the packet on each port, and
responds to each.

	After I configure the switch ports correctly for Etherchannel,
there is only 1 response.  Without the switch configuration IPv6
addrconf also complains about duplicate address detected.

	-J

---
	-Jay Vosburgh, IBM Linux Technology Center, fubar@us.ibm.com
