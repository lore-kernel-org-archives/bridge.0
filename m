Return-Path: <linus.luessing@c0d3.blue>
Date: Wed, 3 Jul 2019 01:13:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
	t=1562109193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	in-reply-to:in-reply-to:references:references;
	bh=LoksQgMuk2Kt4j2B5li4KJCxEkwEChyK4NytrrYLJM0=;
	b=Iqv5pj9XwiKR2p5lOawMUFRwc1opH1IlECd+4FMHaJFhM5WSe3XO4/94//FDQFKNLXhxHP
	8ax+nnciW8IOALXXh6gy9RdPB9qZDKumLnbd86RF4QAPhFmxr2rKQOuo2J4ZBEHCLgyw4L
	dlg7J5ddPmdXEfQV1PQF13JFBboIsMa1N1AwVg35Jzzh7kIs1oZNb2UqWXM6rrrfTHtJ+D
	sTNalTQO+ncEaaIpSDpJmQAX+vkuAUMAHIq1IuTK4u0FUqDgWR7CRiQHC98BlmciwPaqVm
	2uVf6aLxnjLqigUypqCBzyKOhdu30SO/6PSw5+CCk0+dRoj8SjmA8OnU/W3/nw==
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190702231308.GA2414@otheros>
References: <20190620235639.24102-1-vivien.didelot@gmail.com>
	<5d653a4d-3270-8e53-a5e0-88ea5e7a4d3f@gmail.com>
	<20190621172952.GB9284@t480s.localdomain>
	<20190623070949.GB13466@splinter>
	<20190623072605.2xqb56tjydqz2jkx@shell.armlinux.org.uk>
	<20190623074427.GA21875@splinter> <20190629162945.GB17143@splinter>
	<20190630165601.GC2500@otheros> <20190702171158.GA7182@splinter>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190702171158.GA7182@splinter>
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
To: Ido Schimmel <idosch@idosch.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, b.a.t.m.a.n@lists.open-mesh.org, nikolay@cumulusnetworks.com, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

Hi Ido,

> Do you differentiate between IPv4 and IPv6 in batman-adv?

For most things, yes: The querier state is kept separately for
IPv4 and IPv6. And we do have something like a "router node"
flag to signalize that a node needs all multicast traffic, which
is split into IPv4 and IPv6.

The "MDB" equivalent in batman-adv (multicast entries in our "TT",
translation table) are on MAC address base right now, not on an IP
address base yet, so that sounds similar to what you do in mlxsw?

Regarding querier state, we periodically ask the
bridge via "br_multicast_has_querier_anywhere(dev, ETH_P_IP)"
and "br_multicast_has_querier_anywhere(dev, ETH_P_IPV6)".

(Something more event based with handler functions would probably
be nicer, but this was the easier thing to start with.)


> 1. All the IPv6 MDB entries need to be removed from the device. At least
> in mlxsw, we do not have a way to ignore only IPv6 entries. From the
> device's perspective, an MDB entry is just a multicast DMAC with a
> bitmap of ports packets should be replicated to.

Ah, I see, yes. We had a similar "issue". Initially we just always
added any multicast entry into our translation table offered by
the IP stack or bridge, no matter what a querier state or "router
node" state said. Which would have led to a node receiving two
copies of a multicast packet if it were both a querier or router
and were also having a listener announced via IGMP/MLD.

So there we also just recently changed that, to filter out
IPv6 multicast TT entries if this node were also announcing itself as
an MLD querier or IPv6 router. And same, independently for
IPv4/IGMP.

> 2. We need to split the flood tables used for IPv4 and IPv6 unregistered
> multicast packets. For IPv4, packets should only be flooded to mrouter
> ports whereas for IPv6 packets should be flooded to all the member
> ports.

This one I do not fully understand yet. Why don't you apply the
"flood to all ports" (in the no IGMP querier present case)
for IPv4, too?

Sure, for IPv4 nothing "essential" will break, as IPv4 unicast
does not rely on multicast (contrary to IPv6, due to NDP, as you
mentioned). But still there would be potential multicast packet loss
for a 239.x.x.x listener on the local link, for instance, wouldn't
there?


If I'm not mistaken, we do not apply differing behaviour for IPv4
vs. IPv6 in the bridge either and would flood on all ports for IPv4
with no querier present, too.

Regards, Linus
