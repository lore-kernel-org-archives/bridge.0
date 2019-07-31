Return-Path: <Allan.Nielsen@microchip.com>
Date: Wed, 31 Jul 2019 21:38:57 +0200
From: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Message-ID: <20190731193855.sgpbvam5v2a5gkia@lx-anielsen.microsemi.net>
References: <20190729135205.oiuthcyesal4b4ct@lx-anielsen.microsemi.net>
	<e4cd0db9-695a-82a7-7dc0-623ded66a4e5@cumulusnetworks.com>
	<20190729143508.tcyebbvleppa242d@lx-anielsen.microsemi.net>
	<20190729175136.GA28572@splinter>
	<20190730062721.p4vrxo5sxbtulkrx@lx-anielsen.microsemi.net>
	<20190730143400.GO28552@lunn.ch>
	<20190730190000.diacyjw6owqkf7uf@lx-anielsen.microsemi.net>
	<20190731033156.GE9523@lunn.ch>
	<20190731080149.oyqcrw42utxjizsx@lx-anielsen.microsemi.net>
	<20190731134550.GA23028@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20190731134550.GA23028@lunn.ch>
Subject: Re: [Bridge] [PATCH] net: bridge: Allow bridge to joing multicast
	groups
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, Ido Schimmel <idosch@idosch.org>, Horatiu Vultur <horatiu.vultur@microchip.com>

The 07/31/2019 15:45, Andrew Lunn wrote:
> > Here is how I see it:
> > 
> > Teach the SW bridge about non-IP multicast addresses. Initially the switch
> > should forward all MAC multicast frames to the CPU. Today MDB rules can be
> > installed (either static or dynamic by IGMP), which limit the flooding of IPv4/6
> > multicast streams. In the same way, we should have a way to install a rule
> > (FDM/ or MDB) to limit the flooding of L2 multicast frames.
> > 
> > If foreign interfaces (or br0 it self) is part of the destination list, then
> > traffic also needs to go to the CPU.
> > 
> > By doing this, we can for explicitly configured dst mac address:
> > - limit the flooding on the on the SW bridge interfaces
> > - limit the flooding on the on the HW bridge interfaces
> > - prevent them to go to the CPU if they are not needed
> This is all very complex because of all the different corner cases. So
> i don't think we want a user API to do the CPU part, we want the
> network stack to do it. Otherwise the user is going to get is wrong,
> break their network, and then come running to the list for help.
Not sure I really understand what to conclude from this... Their are already
many ways the user can break it (tc has great hooks for that), and I not think
we can really prevent the user in configuring something that break stuff (but
we should not make it too easy either).

Anyway, Horatiu has come a long way in creating a (surprising simple) patch
which allow us to limit the flooding of L2-multicast. It is following the
guidance from Nikolay, it is using the MDB database, and I beleive it is well
aligned with the existing sw-bridge design.

I hope it will be ready tomorrow, then we can have a look at it and see if it is
any good.

> This also fits with how we do things in DSA. There is deliberately no
> user space concept for configuring the DSA CPU port. To user space,
> the switch is just a bunch of Linux interfaces. Everything to do with
> the CPU port is hidden away in the DSA core layer, the DSA drivers,
> and a little bit in the bridge.

Understood, but as far as I understand, in DSA you still have the br0 interface,
which kind-of represent the traffic going to the CPU (like in pure SW bridge,
and SwitchDev offloaded SW-bridge).

/Allan

