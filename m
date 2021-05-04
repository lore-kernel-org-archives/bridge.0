Return-Path: <andrew@lunn.ch>
Date: Tue, 4 May 2021 22:33:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <YJGvkJBKPj2WloXf@lunn.ch>
References: <20210426170411.1789186-1-tobias@waldekranz.com>
 <20210426170411.1789186-7-tobias@waldekranz.com>
 <20210427101747.n3y6w6o7thl5cz3r@skbuf>
 <878s4uo8xc.fsf@waldekranz.com>
 <20210504152106.oppawchuruapg4sb@skbuf>
 <874kfintzh.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kfintzh.fsf@waldekranz.com>
Subject: Re: [Bridge] [RFC net-next 6/9] net: dsa: Forward offloading
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@idosch.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

> There is really no need to recompute the static parts of the tags on
> each skb. It would mean moving some knowledge of the tagging format to
> the driver. But that boundary is pretty artificial for
> mv88e6xxx. tag_dsa has no use outside of mv88e6xxx, and mv88e6xxx does
> not work with any other tagger. I suppose you could even move the whole
> tagger to drivers/net/dsa/mv88e6xxx/?
> 
> What do you think?
> 
> Andrew?

We have resisted this before.

What information do you actually need to share between the tagger and
the driver? Both tag_lan9303.c and tag_ocelot_8021q.c do reference
their switch driver data structures, so some sharing is allowed. But
please try to keep the surface areas down.

       Andrew
