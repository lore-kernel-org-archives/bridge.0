Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 30 Jun 2019 18:56:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
	t=1561913769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	in-reply-to:in-reply-to:references:references;
	bh=9nZ5bd9iTq8RpWHvycQewtEibB8Vs6Ksz9SsR8axNpk=;
	b=SjbnyvSc0ajFOTxwOiKUkhrFU+IUsDibQAmSQ2HdYNNuKFGix8F6SXPlZRM+PJlm2RZetV
	lJNW6GJQpVIkjXsHN0gJihlDzVfXyDAis1XTevoCZRmf11B6Xey9VjvmGhA/VUaUbWC7QE
	1TU/9kaf74lTF97kCWkdZIE7MGub/XJYsu6GXYgY4jrUZzufDQXV1AHwyIecXeDCE+U8i4
	wcvcWu0k/g4gmeq27SDAEMoNr0WDktO6jSncQ5mBgKlvAn8x1qKk2QALroJBiJlyCc2dvP
	1eZdtOYL92se5qLHbmIwUAtgtHcjaXZ/4mH7Yyx33wx5RfzUgOnGZokQY4LU3A==
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190630165601.GC2500@otheros>
References: <20190620235639.24102-1-vivien.didelot@gmail.com>
	<5d653a4d-3270-8e53-a5e0-88ea5e7a4d3f@gmail.com>
	<20190621172952.GB9284@t480s.localdomain>
	<20190623070949.GB13466@splinter>
	<20190623072605.2xqb56tjydqz2jkx@shell.armlinux.org.uk>
	<20190623074427.GA21875@splinter> <20190629162945.GB17143@splinter>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190629162945.GB17143@splinter>
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
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, b.a.t.m.a.n@lists.open-mesh.org, nikolay@cumulusnetworks.com, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, Russell King - ARM Linux admin <linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>, Ido Schimmel <idosch@mellanox.com>, Vivien Didelot <vivien.didelot@gmail.com>

On Sat, Jun 29, 2019 at 07:29:45PM +0300, Ido Schimmel wrote:
> I would like to avoid having drivers take the querier state into account
> as it will only complicate things further.

I absolutely share your pain. Initially in the early prototypes of
multicast awareness in batman-adv we did not consider the querier state.
And doing so later did indeed complicate the code a good bit in batman-adv
(together with the IGMP/MLD suppression issues). I would have loved to
avoid that.


> Is there anything we can do about it? Enable the bridge querier if no
> other querier was detected? Commit c5c23260594c ("bridge: Add
> multicast_querier toggle and disable queries by default") disabled
> queries by default, but I'm only suggesting to turn them on if no other
> querier was detected on the link. Do you think it's still a problem?

As soon as you start becoming the querier, you will not be able to reliably
detect anymore whether you are the only querier candidate.

If any random Linux host using a bridge device were potentially becoming
a querier, that would cause quite some trouble when this host is
behind some bad, bottleneck connection. This host will receive
all multicast traffic, not just IGMP/MLD reports. And with a
congested connection and then unreliable IGMP/MLD, multicast would
become unreliable overall in this domain. So it's important that
your querier is not running in the "dark, remote, dusty closet" of
your network (topologically speaking).

> On Sun, Jun 23, 2019 at 10:44:27AM +0300, Ido Schimmel wrote:
> > See commit b00589af3b04 ("bridge: disable snooping if there is no
> > querier"). I think that's unfortunate behavior that we need because
> > multicast snooping is enabled by default. If it weren't enabled by
> > default, then anyone enabling it would also make sure there's a querier
> > in the network.

I do not quite understand that point. In a way, that's what we
have right now, isn't it? By default it's disabled, because by
default there is no querier on the link. So anyone wanting to use
multicast snooping will need to make sure there's a querier in the
network.


Overall I think the querier (election) mechanism in the standards could
need an update. While the lowest-address first might have
worked well back then, in uniform, fully wired networks where the
position of the querier did not matter, this is not a good
solution anymore in networks involving wireless, dynamic connections.
Especially in wireless mesh networks this is a bit of an issue for
us. Ideally, the querier mechanism were dismissed in favour of simply
unsolicited, periodic IGMP/MLD reports...

But of course, updating IETF standards is no solution for now. 

While more complicated, it would not be impossible to consider the
querier state, would it? I mean you probably already need to
consider the case of a user disabling multicast snooping during
runtime, right? So similarly, you could react to appearing or
disappearing queriers?

Cheers, Linus
