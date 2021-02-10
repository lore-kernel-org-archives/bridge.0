Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2NPoseU3+T4T+f+cn5abepjcDycycu9LCWGAa05SN3E=;
 b=HE6uBuptTXdUGANaII/WQiiYZJZFpbO8xPwk0jQG6BI9+8wbYqZeEtHkSrwaUJNC5A
 n61XWFq9B7QgH88rSSbipN2dQYkV0YwqwoRKtRQ7si+hB4VrWxD7jFVstJbfa42wNzRI
 6MBR2D32RCSl/kXapuAkVfO/MA9OT9vEBkvH6U7HeuKKKRCQa6kGIE4mWwj6f4qgPqhn
 2/S4izOkVM3uf+V/Ei2dNMCgZA1w6PBTBe7PCbI+PEsVlkvsblXDtVrLuUOcEfBAVj/v
 BBIrka+bIjfuHATphmnBwbKBYAzlySe8vfl1lBfM4i1cdaX3lUjccX628VlmiN8nWH6a
 MiTQ==
Date: Wed, 10 Feb 2021 14:01:06 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210210120106.g7blqje3wq4j5l6j@skbuf>
References: <20210210091445.741269-1-olteanv@gmail.com>
 <a8e9284b-f0a6-0343-175d-8c323371ef8d@nvidia.com>
 <20210210104549.ga3lgjafn5x3htwj@skbuf>
 <a58e9615-036c-0431-4ea6-004af4988b27@nvidia.com>
 <20210210110125.rw6fvjtsqmmuglcg@skbuf>
 <90b255e6-efd2-b234-7bfc-4285331e56b1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90b255e6-efd2-b234-7bfc-4285331e56b1@nvidia.com>
Subject: Re: [Bridge] [PATCH v3 net-next 00/11] Cleanup in brport flags
 switchdev offload for DSA
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com, "David S. Miller" <davem@davemloft.net>

On Wed, Feb 10, 2021 at 01:05:57PM +0200, Nikolay Aleksandrov wrote:
> On 10/02/2021 13:01, Vladimir Oltean wrote:
> > On Wed, Feb 10, 2021 at 12:52:33PM +0200, Nikolay Aleksandrov wrote:
> >> On 10/02/2021 12:45, Vladimir Oltean wrote:
> >>> Hi Nikolay,
> >>>
> >>> On Wed, Feb 10, 2021 at 12:31:43PM +0200, Nikolay Aleksandrov wrote:
> >>>> Hi Vladimir,
> >>>> Let's take a step back for a moment and discuss the bridge unlock/lock sequences
> >>>> that come with this set. I'd really like to avoid those as they're a recipe
> >>>> for future problems. The only good way to achieve that currently is to keep
> >>>> the PRE_FLAGS call and do that in unsleepable context but move the FLAGS call
> >>>> after the flags have been changed (if they have changed obviously). That would
> >>>> make the code read much easier since we'll have all our lock/unlock sequences
> >>>> in the same code blocks and won't play games to get sleepable context.
> >>>> Please let's think and work in that direction, rather than having:
> >>>> +	spin_lock_bh(&p->br->lock);
> >>>> +	if (err) {
> >>>> +		netdev_err(p->dev, "%s\n", extack._msg);
> >>>> +		return err;
> >>>>  	}
> >>>> +
> >>>>
> >>>> which immediately looks like a bug even though after some code checking we can
> >>>> verify it's ok. WDYT?
> >>>>
> >>>> I plan to get rid of most of the br->lock since it's been abused for a very long
> >>>> time because it's essentially STP lock, but people have started using it for other
> >>>> things and I plan to fix that when I get more time.
> >>>
> >>> This won't make the sysfs codepath any nicer, will it?
> >>>
> >>
> >> Currently we'll have to live with a hack that checks if the flags have changed. I agree
> >> it won't be pretty, but we won't have to unlock and lock again in the middle of the
> >> called function and we'll have all our locking in the same place, easier to verify and
> >> later easier to remove. Once I get rid of most of the br->lock usage we can revisit
> >> the drop of PRE_FLAGS if it's a problem. The alternative is to change the flags, then
> >> send the switchdev notification outside of the lock and revert the flags if it doesn't
> >> go through which doesn't sound much better.
> >> I'm open to any other suggestions, but definitely would like to avoid playing locking games.
> >> Even if it means casing out flag setting from all other store_ functions for sysfs.
> >
> > By casing out flag settings you mean something like this?
> >
> >
> > #define BRPORT_ATTR(_name, _mode, _show, _store)		\
> > const struct brport_attribute brport_attr_##_name = { 	        \
> > 	.attr = {.name = __stringify(_name), 			\
> > 		 .mode = _mode },				\
> > 	.show	= _show,					\
> > 	.store_unlocked	= _store,				\
> > };
> >
> > #define BRPORT_ATTR_FLAG(_name, _mask)				\
> > static ssize_t show_##_name(struct net_bridge_port *p, char *buf) \
> > {								\
> > 	return sprintf(buf, "%d\n", !!(p->flags & _mask));	\
> > }								\
> > static int store_##_name(struct net_bridge_port *p, unsigned long v) \
> > {								\
> > 	return store_flag(p, v, _mask);				\
> > }								\
> > static BRPORT_ATTR(_name, 0644,					\
> > 		   show_##_name, store_##_name)
> >
> > static ssize_t brport_store(struct kobject *kobj,
> > 			    struct attribute *attr,
> > 			    const char *buf, size_t count)
> > {
> > 	...
> >
> > 	} else if (brport_attr->store_unlocked) {
> > 		val = simple_strtoul(buf, &endp, 0);
> > 		if (endp == buf)
> > 			goto out_unlock;
> > 		ret = brport_attr->store_unlocked(p, val);
> > 	}
> >
>
> Yes, this can work but will need a bit more changes because of br_port_flags_change().
> Then the netlink side can be modeled in a similar way.

What I just don't understand is how others can get away with doing
sleepable work in atomic context but I can't make the notifier blocking
by dropping a spinlock which isn't needed there, because it looks ugly :D
