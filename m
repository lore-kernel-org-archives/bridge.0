Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED1118437B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0D9F8437C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AaGDSW9Uo5gk30Lai/grQJHvjoamn5mhkN1P8X3Mr1c=;
 b=XDGSk4LCApoml0aEWA/O3LLO/VsZONiWFe/ectvtscueo6IjH7ZUf9RlJhwtFSIpxQ
 vY++6qdmYZb+oW7zRT7cjXr+GC9giXFUnuCNfw5DiA7j8d1qyob8iMM2osLiToYj1ohv
 MjMD+t1N0GGFjY33uJZGAYwRCYC6M7/DErNQH5hOggVnb9DHFCdUYjpqVdRqokBrlh96
 GkyL6AI+ywx2J+ZQLZtQKEdIhoDTpnzcQvXN+CYIRxi0BkkuQTsDRuTeav78lyAHPmv8
 k8jEA+WOuluVDUj0nveiEfMCshL90NJVUri95IyjOMeZiW8GRh6YgwpYdwZ7tEn6iimD
 AnFA==
Date: Thu, 20 Oct 2022 18:25:54 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221020152554.rck3skqqdd45fu46@skbuf>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-6-netdev@kapio-technology.com>
 <20221018165619.134535-6-netdev@kapio-technology.com>
 <20221020130224.6ralzvteoxfdwseb@skbuf> <Y1FMAI9BzDRUPi5Y@shredder>
 <20221020133506.76wroc7owpwjzrkg@skbuf> <Y1FTzyPdTbAF+ODT@shredder>
 <20221020140400.h4czo4wwv7erncy7@skbuf> <Y1FiImF3i4s0bLuD@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1FiImF3i4s0bLuD@shredder>
Subject: Re: [Bridge] [PATCH v8 net-next 05/12] net: dsa: propagate the
 locked flag down through the DSA layer
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, "Hans J. Schultz" <netdev@kapio-technology.com>, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, davem@davemloft.net

On Thu, Oct 20, 2022 at 05:58:42PM +0300, Ido Schimmel wrote:
> My understanding is that mv88e6xxx only reads the SMAC and FID/VID from
> hardware and notifies them to the bridge driver. It does not need to
> parse them out of the Ethernet frame that triggered the "violation".
> This is the "ugly" part (in my opinion).

I think that the Marvell approach is uglier, but maybe that's just me.
Between parsing a MAC SA/VLAN ID from an Ethernet frame than having to
concern myself with rate limiting IRQs which need MDIO access, I'd
rather parse Ethernet frames all day long.

With Ethernet we have all sorts of coping mechanisms, NAPI, IRQ
coalescing. The Ethernet interrupts are designed to be very high
bandwidth. You can even put a storm policer on Ethernet traffic and rate
limit the learn frames. I don't like where the Marvell specific impl is
going, I don't think it is a good first implementation of a new feature,
since it will inevitably shape the way in which other hardware with CPU
assisted learning will do things. For example, not sure if blackhole FDB
entries are going to be needed by other implementations as well.

I kind of thought that the Linux bridge would be more resilient to DoS
than it actually is. Now I'm not sure if me and Andrew gave bad advice
with the whole protection mechanisms put in place as UAPI for mv88e6xxx's
quirks.

> > The learn frames are "special" in the sense that they don't belong to
> > the data path of the software bridge*, they are just hardware specific
> > information which the driver must deal with, using a channel that
> > happens to be Ethernet and not an IRQ/MDIO.
> 
> I think we misunderstand each other because I don't understand why you
> call them "special" nor "hardware specific information" :/

I call them special because there is no need to present these packets to
application software. Understood and agreed that they are identical to
the original packet which triggered the trap (plus some metadata which
denotes the trap reason, presumably), although I don't think this really
matters too much.

> We don't inject to the software data path some hardware specific
> frames, but rather the original Ethernet frames that triggered the
> violation. The same thing happens with packets that encountered a
> neighbour miss during routing or whose TTL was decremented to zero.
> The hardware can't generate ARP or ICMP packets, so the original
> packet is injected to the Rx path so that the kernel will generate the
> necessary control packets in response.

Can't speak for IP forwarding offload unfortunately, but it seems like
you presented a different/unrelated situation here. CPU assisted
learning is not slow path processing, because nothing needs to be done
further with that packet except for extracting its MAC SA/VID, and
learning it. The rest of the original packet is really not necessary.

> > *in other words, a bridge with proper RX filtering should not even
> > receive these frames, or would need special casing for BR_PORT_MAB to
> > not drop them in the first place.
> > 
> > I would incline towards an unified approach for CPU assisted learning,
> > regardless of this (minor, IMO) difference between Marvell and other
> > vendors.
> 
> OK, understood. Assuming you don't like the above, I need to check if we
> can do something similar to what mv88e6xxx is doing (because I don't
> think mv88e6xxx can do anything else).

No no, I like having an Ethernet channel (see the first reply to this
email), I think it has benefits and I don't want to make Spectrum follow
an inferior route just because that's the model.

But on the other hand, nobody right now needs the mechanism that Hans
put in place for setting BR_FDB_LOCKED in software, and notifying it
back to the driver. Moreover, when Ethernet-based CPU assisted learning
will come, this mechanism will not be the only possibility, and that
should be a separate discussion. I still think that generic helpers to
emit SWITCHDEV_FDB_ADD_TO_BRIDGE based on an skb are an equally valid
approach, and would diverge significantly less from Marvell without
imposing any real limitation. In the implementation proposed here, we
have variation for the sake of variation, and we come up with
hypothetical examples of how they might be useful. At least half this
patch set is full of maybes, I can't really say I like that.
