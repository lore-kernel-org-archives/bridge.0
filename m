Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Jhw14S
 7gzUfxDfXY3MFGd9GM2K8HzhgZoqO1xwIOyI8=; b=XSA4aEVKrOLqFVMFHen/+J
 U6nQ81UiLHi0PhCffPAtMnqtR1/rCMIfmRJbmPNSy8se+SAE7G63ax9MF9SFqpLT
 sn6CTKZuxpKMPXvQMoPn9vLkdFxjX60R1z/i3pdTXMjwpH42p+qul+A3SnieudiI
 3itCJCzG0MqIt7OE4kxR/Jqdh6wFdoSv/T6CL9s7YadNkQnZQAfHOyqSB2e3zJeX
 QWhcFKvqeRm6q2U4LWmaZI/w8QL65WN1jFdXcgh4DrM36gdF356OUxm1Q89jmnET
 x6z8U6R5h2Zn+S5a3Q++JIgjf4qXQBea/V9daTppn5u1VtuXNtwJWWZd/vOGRpyg
 ==
Date: Thu, 11 Feb 2021 09:44:43 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20210211074443.GB324421@shredder.lan>
References: <20210209151936.97382-1-olteanv@gmail.com>
 <20210209151936.97382-5-olteanv@gmail.com>
 <20210209185100.GA266253@shredder.lan>
 <20210209202045.obayorcud4fg2qqb@skbuf>
 <20210209220124.GA271860@shredder.lan>
 <20210209225153.j7u6zwnpdgskvr2v@skbuf>
 <20210210105949.GB287766@shredder.lan>
 <20210210232352.m7nqzvs2g4i74rx4@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210232352.m7nqzvs2g4i74rx4@skbuf>
Subject: Re: [Bridge] [PATCH v2 net-next 04/11] net: bridge: offload initial
 and final port flags through switchdev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Taras Chornyi <tchornyi@marvell.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com, "David S. Miller" <davem@davemloft.net>

On Thu, Feb 11, 2021 at 01:23:52AM +0200, Vladimir Oltean wrote:
> On Wed, Feb 10, 2021 at 12:59:49PM +0200, Ido Schimmel wrote:
> > > > The reverse, during unlinking, would be to refuse unlinking if the upper
> > > > has uppers of its own. netdev_upper_dev_unlink() needs to learn to
> > > > return an error and callers such as team/bond need to learn to handle
> > > > it, but it seems patchable.
> > >
> > > Again, this was treated prior to my deletion in this series and not by
> > > erroring out, I just really didn't think it through.
> > >
> > > So you're saying that if we impose that all switchdev drivers restrict
> > > the house of cards to be constructed from the bottom up, and destructed
> > > from the top down, then the notification of bridge port flags can stay
> > > in the bridge layer?
> >
> > I actually don't think it's a good idea to have this in the bridge in
> > any case. I understand that it makes sense for some devices where
> > learning, flooding, etc are port attributes, but in other devices these
> > can be {port,vlan} attributes and then you need to take care of them
> > when a vlan is added / deleted and not only when a port is removed from
> > the bridge. So for such devices this really won't save anything. I would
> > thus leave it to the lower levels to decide.
> 
> Just for my understanding, how are per-{port,vlan} attributes such as
> learning and flooding managed by the Linux bridge? How can I disable
> flooding only in a certain VLAN?

You can't (currently). But it does not change the fact that in some
devices these are {port,vlan} attributes and we are talking here about
the interface towards these devices. Having these as {port,vlan}
attributes allows you to support use cases such as a port being enslaved
to a VLAN-aware bridge and its VLAN upper(s) enslaved to VLAN unaware
bridge(s). Obviously you need to ensure there is no conflict between the
VLANs used by the VLAN-aware bridge and the VLAN device(s).
