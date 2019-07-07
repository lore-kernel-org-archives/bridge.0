Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; bh=x8lXpDRZEO+kJnbsaHqRuaESgj+i+FFLo/tF3IYSR
	vQ=; b=tHjTbQAi+jz81QV1JPIpp4++7BmunyQYQ+Q8cBbZSdC8Uu+abNjabLBo/
	VE0rbxSGDvwLzkUPpXzAl4ASX2U7G6Sc6/nmfa//+/F1IFrGh+aSUwe9GTvMAfOv
	yF84RP3NQIABOStFJEjghqPxaMapj90YPu12SuHNFbJZHQdlREunqUYPyS9DbNjM
	kYQeIlPa5DlPl93g4uQrry30lq8GlzTfkGrZKxB4ZvwRmHHDskq09GN9UBP/umoV
	JUVw06tAM15CEy3gv3tj9vaoUyGnVWIjFon6lWytR7OJo6X2W7M7k00L3xWOdXbM
	QaZBD0S2AF7zBGzqPRM1zesamI5cQ==
Date: Sun, 7 Jul 2019 12:07:47 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20190707090747.GA5516@splinter>
References: <20190620235639.24102-1-vivien.didelot@gmail.com>
	<5d653a4d-3270-8e53-a5e0-88ea5e7a4d3f@gmail.com>
	<20190621172952.GB9284@t480s.localdomain>
	<20190623070949.GB13466@splinter>
	<20190623072605.2xqb56tjydqz2jkx@shell.armlinux.org.uk>
	<20190623074427.GA21875@splinter> <20190629162945.GB17143@splinter>
	<20190630165601.GC2500@otheros> <20190702171158.GA7182@splinter>
	<20190702231308.GA2414@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190702231308.GA2414@otheros>
Subject: Re: [Bridge] [RFC net-next] net: dsa: add support for MC_DISABLED
	attribute
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, b.a.t.m.a.n@lists.open-mesh.org, nikolay@cumulusnetworks.com, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

On Wed, Jul 03, 2019 at 01:13:08AM +0200, Linus L=FCssing wrote:
> Hi Ido,
>=20
> > Do you differentiate between IPv4 and IPv6 in batman-adv?
>=20
> For most things, yes: The querier state is kept separately for
> IPv4 and IPv6. And we do have something like a "router node"
> flag to signalize that a node needs all multicast traffic, which
> is split into IPv4 and IPv6.
>=20
> The "MDB" equivalent in batman-adv (multicast entries in our "TT",
> translation table) are on MAC address base right now, not on an IP
> address base yet, so that sounds similar to what you do in mlxsw?

Yes.

> Regarding querier state, we periodically ask the
> bridge via "br_multicast_has_querier_anywhere(dev, ETH_P_IP)"
> and "br_multicast_has_querier_anywhere(dev, ETH_P_IPV6)".
>=20
> (Something more event based with handler functions would probably
> be nicer, but this was the easier thing to start with.)

Thanks for the reference. Will check the code. I believe that we will
add switchdev notifications for querier state change, so it might be
useful for you as well.

> > 1. All the IPv6 MDB entries need to be removed from the device. At least
> > in mlxsw, we do not have a way to ignore only IPv6 entries. From the
> > device's perspective, an MDB entry is just a multicast DMAC with a
> > bitmap of ports packets should be replicated to.
>=20
> Ah, I see, yes. We had a similar "issue". Initially we just always
> added any multicast entry into our translation table offered by
> the IP stack or bridge, no matter what a querier state or "router
> node" state said. Which would have led to a node receiving two
> copies of a multicast packet if it were both a querier or router
> and were also having a listener announced via IGMP/MLD.
>=20
> So there we also just recently changed that, to filter out
> IPv6 multicast TT entries if this node were also announcing itself as
> an MLD querier or IPv6 router. And same, independently for
> IPv4/IGMP.

This is actually not a problem with mlxsw. The ports a packet should be
replicated to are represented using a bitmap. It does not matter if we
set the bit because it has an MDB entry or because it is an mrouter
port. And obviously it does not matter if we set it twice :)

> > 2. We need to split the flood tables used for IPv4 and IPv6 unregistered
> > multicast packets. For IPv4, packets should only be flooded to mrouter
> > ports whereas for IPv6 packets should be flooded to all the member
> > ports.
>=20
> This one I do not fully understand yet. Why don't you apply the
> "flood to all ports" (in the no IGMP querier present case)
> for IPv4, too?
>=20
> Sure, for IPv4 nothing "essential" will break, as IPv4 unicast
> does not rely on multicast (contrary to IPv6, due to NDP, as you
> mentioned). But still there would be potential multicast packet loss
> for a 239.x.x.x listener on the local link, for instance, wouldn't
> there?
>=20
>=20
> If I'm not mistaken, we do not apply differing behaviour for IPv4
> vs. IPv6 in the bridge either and would flood on all ports for IPv4
> with no querier present, too.

I think I was not clear, so I will explain again. I was referring to a
situation where IPv4 has a querier, but IPv6 does not. In this case, the
bridge will flood IPv4 unregistered multicast packets to mrouter ports
only. On the other hand, IPv6 unregistered multicast packets will be
flooded to all the ports. Based on my reading of the code, this is
controlled by 'mcast_hit' in br_handle_frame_finish().

In mlxsw, each packet type (e.g., unknown unicast, IPvX unregistered
multicast) is associated with a flood table (basically a huge matrix,
where row corresponds to VLAN and column corresponds to a port). If we
are to handle the case where IPv4 unregistered multicast packets need to
be flooded to mrouter ports only, whereas IPv6 unregistered multicast
packets need to be flooded to all the ports, then we need to use a
separate flood table for each.

Alternatively, we can use the same flood table, but flood to all the
ports if IPv4 or IPv6 querier is missing. I do not think anything will
break, it is just very efficient. This seems to be allowed by RFC 4541
(Section 2.1.2):

"If a switch receives an unregistered packet, it must forward that
packet on all ports to which an IGMP router is attached. A switch may
default to forwarding unregistered packets on all ports."

> Regards, Linus

Linus, thanks a lot for the great feedback. I really appreciate it!
