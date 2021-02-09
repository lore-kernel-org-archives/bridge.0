Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=OJBJZoWtqasITVYW+Sh00YF0phZ4lq1R3a/gcaU0ls4=;
 b=o/AxlQl0i/wUD4989dM3BQ9Gi/UH+Je6cbHNhA84lwvzRqeUwuhW4S4haRyZI0GgPd
 Ej/r7H/wM6R3hOXnDtJJF14SNOLs40Wvo4qGFTwwD4QlpUsFij206pVp+GJb4kxAsY3F
 z65T8HrcYQbcL8vFhr2HcbobpEEWPUvqncsAmlpky62S2x5+q3vCbm2JTJId8ZDe3J8n
 VrW5z3qLoSpLdUyM43J9QjBj6MqZJ7WdU6UztgN2EideHqQQZevsC6BV7EoRN6w051Hr
 G2lyfCoI3UgEmrYW+DhPm9tOlmz3duWY6/FQFMvZd6sjKzVuJ0rn7BFROqc83Ob/Wvtd
 hRVQ==
Date: Tue, 9 Feb 2021 22:20:45 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210209202045.obayorcud4fg2qqb@skbuf>
References: <20210209151936.97382-1-olteanv@gmail.com>
 <20210209151936.97382-5-olteanv@gmail.com>
 <20210209185100.GA266253@shredder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209185100.GA266253@shredder.lan>
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
To: Ido Schimmel <idosch@idosch.org>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Taras Chornyi <tchornyi@marvell.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com, "David S. Miller" <davem@davemloft.net>

On Tue, Feb 09, 2021 at 08:51:00PM +0200, Ido Schimmel wrote:
> On Tue, Feb 09, 2021 at 05:19:29PM +0200, Vladimir Oltean wrote:
> > So switchdev drivers operating in standalone mode should disable address
> > learning. As a matter of practicality, we can reduce code duplication in
> > drivers by having the bridge notify through switchdev of the initial and
> > final brport flags. Then, drivers can simply start up hardcoded for no
> > address learning (similar to how they already start up hardcoded for no
> > forwarding), then they only need to listen for
> > SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS and their job is basically done, no
> > need for special cases when the port joins or leaves the bridge etc.
> 
> How are you handling the case where a port leaves a LAG that is linked
> to a bridge? In this case the port becomes a standalone port, but will
> not get this notification.

Apparently the answer to that question is "I delete the code that makes
this use case work", how smart of me. Thanks.

Unless you have any idea how I could move the logic into the bridge, I
guess I'm stuck with DSA and all the other switchdev drivers having this
forest of corner cases to deal with. At least I can add a comment so I'm
not tempted to delete it next time.
