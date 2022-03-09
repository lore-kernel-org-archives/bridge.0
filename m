Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=k141GwidNXRjahdS4nq6wClv46C5Je0axvt+W5lVMQk=;
 b=PdiEj+1Aa51J+awk55tE9/R3W0LIoQGtcEoKk9RtW5aNNQqg24erRB0bCZXjETVH+H
 NXhO1TaxSzmwuzxfs2+bIzZHdfGWKO6NLXGZjEOKiVDbB24HEUbAObdXvHvyt+7P0Nxj
 ufe+DHxvaGvH/P1e6uBxVTDUaryB7BnJV9ie1kmBDJAr3kwHftc7MOWcgP2pMq2FgSPA
 UEtNdjoZOxFTqcXMRlaHsr+2WEhhvpP/qKyAw+no8NrN+DjhLdaB9ZfyNlICJGqIvn3O
 YwdFkGTH6q9R4kMZs4hIhrCCgJ4u/x+EWIZMx+jPC4LsHrHsqBpRxuSqotPjhah/GN9o
 LRdA==
Date: Wed, 9 Mar 2022 19:03:50 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220309170350.fzp3d6jjpiskdhqv@skbuf>
References: <20220301100321.951175-1-tobias@waldekranz.com>
 <20220301100321.951175-7-tobias@waldekranz.com>
 <20220303222942.dkz7bfuagkv7hbpp@skbuf>
 <87pmmvm8ll.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmmvm8ll.fsf@waldekranz.com>
Subject: Re: [Bridge] [PATCH v2 net-next 06/10] net: dsa: Pass VLAN MSTI
 migration notifications to driver
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 04:47:02PM +0100, Tobias Waldekranz wrote:
> >> +int dsa_port_vlan_msti(struct dsa_port *dp, const struct switchdev_attr *attr)
> >> +{
> >> +	struct dsa_switch *ds = dp->ds;
> >> +
> >> +	if (!ds->ops->vlan_msti_set)
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	return ds->ops->vlan_msti_set(ds, attr);
> >
> > I guess this doesn't need to be a cross-chip notifier event for all
> > switches, because replication to all bridge ports is handled by
> > switchdev_handle_port_attr_set(). Ok. But isn't it called too many times
> > per switch?
> 
> It is certainly called more times than necessary. But I'm not aware of
> any way to limit it. Just as with other bridge-global settings like
> ageing timeout, the bridge will just replicate the event to each port,
> not knowing whether some of them belong to the same underlying ASIC or
> not.
> 
> We could leverage hwdoms in the bridge to figure that out, but then:

Hmm, uncalled for. Also, not sure how it helps (it just plain doesn't
work, as you've pointed out below yourself).

> 
> - Drivers that do not implement forward offloading would miss out on
>   this optimization. Unfortunate but not a big deal.
> - Since DSA presents multi-chip trees as a single switchdev, the DSA
>   layer would have to replicate the event out to each device. Doable,
>   but feels like a series of its own.

I've mentally walked through the alternatives and I don't see a practical
alternative than letting the driver cut out the duplicate calls.

Maybe it's worth raising awareness by adding a comment above the
dsa_switch_ops :: vlan_msti_set definition that drivers should be
prepared to handle such calls.

Case in point, in mv88e6xxx_vlan_msti_set() you could avoid some useless
MDIO transactions (a call to mv88e6xxx_vtu_loadpurge) with a simple
"if (vlan.sid != new_sid)" check. Basically just go through a refcount
bump followed by an immediate drop.
