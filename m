Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=CHszZK7LblPbIXozkASGXG0KNy6kheJ5G3pXtlHdYnQ=;
 b=k6bHhtUS4olAAtkrAOahBxLSc5WpKrfi4zD12DHNMLUAjYB6RGAXtjuP4hmnDJGhIy
 xUowlwnIr1SvmdcLgavdkJpQs1ajPmjaIqxezkolP5XvjRWlSuMB6qiACRyd8Nz7SqQB
 4Mbqj6cHA272gLGFBZ6FfpvDLTHDdjE5v/zn3ZhVvHJUYR9g/XwJ4q0vjJRTv/F+2fqx
 pmCcjQ4Y5yGc18g9k2DxfXm18Bs7JuyNhnzsGeeD6Qb5X3lRJVyoHFzxb6h3kLtDtLU0
 FGunUYRveXcjLVzUFE/NzElQ3hysDDDBtfWjDc2aFWsvXDbHHBbn+YUUfBfrLnSH3A16
 MPwA==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <20210504230409.kohxoc4cl7sjpkrg@skbuf>
References: <20210426170411.1789186-1-tobias@waldekranz.com>
 <20210426170411.1789186-7-tobias@waldekranz.com>
 <20210427101747.n3y6w6o7thl5cz3r@skbuf> <878s4uo8xc.fsf@waldekranz.com>
 <20210504152106.oppawchuruapg4sb@skbuf> <874kfintzh.fsf@waldekranz.com>
 <20210504205823.j5wg547lgyw776rl@skbuf> <87y2cum9mo.fsf@waldekranz.com>
 <20210504230409.kohxoc4cl7sjpkrg@skbuf>
Date: Wed, 05 May 2021 11:01:09 +0200
Message-ID: <87pmy5mu5m.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [RFC net-next 6/9] net: dsa: Forward offloading
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@idosch.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On Wed, May 05, 2021 at 02:04, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Wed, May 05, 2021 at 12:12:15AM +0200, Tobias Waldekranz wrote:
>> > and you create a dependency between the tagger and the switch driver
>> > which was supposed by design to not exist.
>> 
>> Sure, but _why_ should it not exist? Many fields in the tag can only be
>> correctly generated/interpreted in combination with knowledge of the
>> current configuration, which is the driver's domain. The dependency is
>> already there, etched in silicon.
>
> I'm a bit more of a pragmatic person,

Excuse me sir, I believe you left your dagger IN MY HEART :)

> it's not so much that I think that
> Lennert Buytenhek's original DSA design from 2008 was the holy grail and
> that we should do everything we can to preserve it intact. Far from it.
> But I actually like having the option to inject a DSA-tagged packet
> using Spirent TestCenter and measure IP forwarding between dsa_loop
> "switch" ports (actually a one-armed router is what it is). I also like,
> as a reviewer, to be able to test, if I want to, how a tail tagger
> behaves even if I don't own a switch with tail tagging. And this
> separation between the switch driver and the tag protocol driver makes
> that possible, just see it as a nice perk which we don't want to lose.

Completely understandable. I was trying to extrapolate where we will end
up with this separation as we add more and more features and couple the
tagger closer to the driver, and see if the current architecture was
still the optimal one. Trying to be ...pragmatic, if you will.

> As for more advanced features, like "the hardware requires me to invent
> a unique number based on a rolling counter, call it a TX timestamp ID,
> put it in the DSA header, then when transmission is done, an IRQ will be
> raised, and I need to match that TX timestamp that just became available
> to me, which is identifiable via the timestamp ID that I put in the DSA
> header, with the original skb", of course you can't do that without
> communication between the tagger and the driver itself, unless you make
> the tagger handle interrupts (and then there's the whole issue that the
> tagging protocol driver needs to be instantiated per switch, if it's
> going to be stateful), or the switch driver send packets. As a general
> rule of thumb, just don't break dsa_loop and we should be fine. For
> example, yes, PTP requires driver <-> tagger communication, but PTP
> timestamping is also not enabled by default, and guarded by an ioctl
> which dsa_loop doesn't implement. So the tagger can never trigger faulty
> code, dereferencing a ds->priv pointer which it thinks is "struct
> mv88e6xxx_chip" but is actually "struct dsa_loop_priv".

This should also hold for forward offloading, since dsa_loop would not
implement .ndo_dfwd_{add,del}_station.

Alright, include/linux/dsa/mv88e6xxx.h here I come!
