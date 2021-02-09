Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=If0a9D
 G+vl8Jyo4MLhR7mY6t7WMqf7KoKRp8rDPToCk=; b=EijxwlpjAizDL0+dXE/wNW
 Muaw7NUG6HGq3B61vSEu12cmEUsUFET0BKJS3avziOX677RJdzJAlZmE6S/WX9wJ
 +MHJWCwuoIfyVT+Y9EpxZ35zAUtl0Dqw27zw44fJOq9wJunYvfOwUOGc6Mo7YDYj
 5BZbRNqXkjWCTfdA7KB0fFJmTN9CtkFHJzjO7hRYvpU2x75ExIpP1+9r3PKLTJer
 gFAHezuHUsK/j8aJuGan8NZ5pJhj9hjWx/LtlVx+rEDnuVRrHSj8w+RtmFfjnC5x
 U7pLm8EmM6ZDLhCngCR7PH9D0wfzX/+uEsC/9kPD9LuTjWhcn3zl8wmYGCapxF1w
 ==
Date: Wed, 10 Feb 2021 00:01:24 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20210209220124.GA271860@shredder.lan>
References: <20210209151936.97382-1-olteanv@gmail.com>
 <20210209151936.97382-5-olteanv@gmail.com>
 <20210209185100.GA266253@shredder.lan>
 <20210209202045.obayorcud4fg2qqb@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209202045.obayorcud4fg2qqb@skbuf>
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

On Tue, Feb 09, 2021 at 10:20:45PM +0200, Vladimir Oltean wrote:
> On Tue, Feb 09, 2021 at 08:51:00PM +0200, Ido Schimmel wrote:
> > On Tue, Feb 09, 2021 at 05:19:29PM +0200, Vladimir Oltean wrote:
> > > So switchdev drivers operating in standalone mode should disable address
> > > learning. As a matter of practicality, we can reduce code duplication in
> > > drivers by having the bridge notify through switchdev of the initial and
> > > final brport flags. Then, drivers can simply start up hardcoded for no
> > > address learning (similar to how they already start up hardcoded for no
> > > forwarding), then they only need to listen for
> > > SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS and their job is basically done, no
> > > need for special cases when the port joins or leaves the bridge etc.
> > 
> > How are you handling the case where a port leaves a LAG that is linked
> > to a bridge? In this case the port becomes a standalone port, but will
> > not get this notification.
> 
> Apparently the answer to that question is "I delete the code that makes
> this use case work", how smart of me. Thanks.

Not sure how you expect to interpret this.

> 
> Unless you have any idea how I could move the logic into the bridge, I
> guess I'm stuck with DSA and all the other switchdev drivers having this
> forest of corner cases to deal with. At least I can add a comment so I'm
> not tempted to delete it next time.

There are too many moving pieces with stacked devices. It is not only
LAG/bridge. In L3 you have VRFs, SVIs, macvlans etc. It might be better
to gracefully / explicitly not handle a case rather than pretending to
handle it correctly with complex / buggy code.

For example, you should refuse to be enslaved to a LAG that already has
upper devices such as a bridge. You are probably not handling this
correctly / at all. This is easy. Just a call to
netdev_has_any_upper_dev().

The reverse, during unlinking, would be to refuse unlinking if the upper
has uppers of its own. netdev_upper_dev_unlink() needs to learn to
return an error and callers such as team/bond need to learn to handle
it, but it seems patchable.
