Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396241A7044
	for <bridge@lists.linux.dev>; Mon, 14 Oct 2024 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917181; cv=none; b=dirIixmCj9yqeeJ09vIhNa/lx531KBqseJoic98bxJ3obEsbY/AuVsSkfAN4oWylkIJ1qBYRHw8/pqMxeC6ZFTjjuZceku1aBoiviptd2BAUwEJohsMqfpRol1RosQOcvhh4+tM0vyQrK4P0kAjqC4ddengkZTQD4iveW3GC/94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917181; c=relaxed/simple;
	bh=k2uQWd7iswZDi+HVtJAsEETlLzBCW8Ql3yT+TWiS9GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUq97UoFESfjq6Rt4pxxvpgg+ma4yu9DsD16oFao2t1MtRDj09eakKtJ/MIRbreCMj0H2TcMhifoW7n+dA5RaUYaeEj5IN+8mr6+kJybeQ67QyPSvBdePbWHx3Hdr+6gWWX2rVlw4wbcZQxjnJh7d8lSO9icSQa9UyGOhYZV0yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCUwU4WB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCUwU4WB"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43112524af7so6730965e9.3
        for <bridge@lists.linux.dev>; Mon, 14 Oct 2024 07:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728917177; x=1729521977; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=toAdeYu7YM++Cxc6jEpju3gZivvLZBwOrQ+Xf1nUCvc=;
        b=KCUwU4WBxAPZPrQztGL/IPQ3aGdD5zR1BCtapJCr3V69pqTwo31LfHEQiFRkE0UEtm
         Z+/RIVt58XFkg63d9zIpj+41KK333JqdubK6RL94D1T+e9sxOTlz4Th1ky0KBtVOUgxI
         Ip3/o/S3GJsUtLNPu8NS/fAxdIwsoNMONg7ntqou7FICLGLf2o5pcVBJWVeoR7Y7uzXz
         eJ1v5gyUTTtCA8KloUGedMwK6qEOBJwJ53MvoaOV5F574Bkmllwt8wGJiobPGJEInNy1
         PvGfbR74cdbEqlyft8giTov3xuyZfXpPu3dn/b1kRufULeB0u7kAb/94sZPdjNBtDGnp
         Ue6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728917177; x=1729521977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toAdeYu7YM++Cxc6jEpju3gZivvLZBwOrQ+Xf1nUCvc=;
        b=f3mHV5haTVZf12tNLUvt6fmVp2/kPIaZrx+3N93kEX0pb6Imzh/UhXlq8fg119RZEQ
         884sjvEIO4Pn8Jr+3wAFzBmXdk8xEWwqcSooi9YEBuUX57Z5flA3zFHBkN0vl49ej1IG
         cZ5wdtv8YubJ7KMklKtFMAMY4NX3hhX6YcYC0MgY+SBhxlA/Dn0g4b2jdpzZBoEn2hT9
         KCkq2Co+kcr/9L0gd86pZnLulW2RhSmNV1icIR0LMHLwF/IzUFj4IPf+tkf8dN4OCPhb
         swS+3bcNh+f/H05bMTpXJAq5VAa+zWGxIjBjaf4gUevd0Y9LnE99leEqEXgfJEaLMA8L
         MaEg==
X-Forwarded-Encrypted: i=1; AJvYcCVu2VLbx6JUC4678I+XuLAntE29pnydmub8Grq7aFFLjJD3e40Ymj72lKVwOaK5+fGnkN5rNbI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxqx1qmMYJz5qQzT0+7HJ0vRBNRaUs31zXOHA/+kVR8aTDvOJvl
	xl3irEjbit42e96SZyaDpxYDtpfSnVZQO/6BikOttpSVxSNXaxl2
X-Google-Smtp-Source: AGHT+IHnyoTO36H7Xhyv3DPKerYRmIm0V8WWjqWCmc69d+AosbpQg92p6SCpOjFVzfiFZSzf4BgSUQ==
X-Received: by 2002:a05:600c:358f:b0:42c:bfd6:9d1f with SMTP id 5b1f17b1804b1-4311debbe68mr44024185e9.1.1728917177205;
        Mon, 14 Oct 2024 07:46:17 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431183062ddsm123553365e9.27.2024.10.14.07.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 07:46:16 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:46:13 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH RFC v1 net-next 11/12] bridge:
 br_vlan_fill_forward_path_mode no _UNTAG_HW for dsa
Message-ID: <20241014144613.mkc62dvfzp3vr7rj@skbuf>
References: <20241013185509.4430-1-ericwouds@gmail.com>
 <20241013185509.4430-12-ericwouds@gmail.com>
 <281cce27-c832-41c8-87d0-fbac05b8e802@blackwall.org>
 <6209405e-7100-43f9-b415-3be8fbcc6352@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6209405e-7100-43f9-b415-3be8fbcc6352@blackwall.org>

Keeping the full email body untrimmed for extra context for the newly
added people.

On Mon, Oct 14, 2024 at 09:22:07AM +0300, Nikolay Aleksandrov wrote:
> On 14/10/2024 09:18, Nikolay Aleksandrov wrote:
> > On 13/10/2024 21:55, Eric Woudstra wrote:
> >> In network setup as below:
> >>
> >>              fastpath bypass
> >>  .----------------------------------------.
> >> /                                          \
> >> |                        IP - forwarding    |
> >> |                       /                \  v
> >> |                      /                  wan ...
> >> |                     /
> >> |                     |
> >> |                     |
> >> |                   brlan.1
> >> |                     |
> >> |    +-------------------------------+
> >> |    |           vlan 1              |
> >> |    |                               |
> >> |    |     brlan (vlan-filtering)    |
> >> |    |               +---------------+
> >> |    |               |  DSA-SWITCH   |
> >> |    |    vlan 1     |               |
> >> |    |      to       |               |
> >> |    |   untagged    1     vlan 1    |
> >> |    +---------------+---------------+
> >> .         /                   \
> >>  ----->wlan1                 lan0
> >>        .                       .
> >>        .                       ^
> >>        ^                     vlan 1 tagged packets
> >>      untagged packets
> >>
> >> Now that DEV_PATH_MTK_WDMA is added to nft_dev_path_info() the forward
> >> path is filled also when ending with the mediatek wlan1, info.indev not
> >> NULL now in nft_dev_forward_path(). This results in a direct transmit
> >> instead of a neighbor transmit. This is how it should be, But this fails.
> >>
> >> br_vlan_fill_forward_path_mode() sets DEV_PATH_BR_VLAN_UNTAG_HW when
> >> filling in from brlan.1 towards wlan1. But it should be set to
> >> DEV_PATH_BR_VLAN_UNTAG in this case. Using BR_VLFLAG_ADDED_BY_SWITCHDEV
> >> is not correct. The dsa switchdev adds it as a foreign port.
> >>
> >> Use BR_VLFLAG_TAGGING_BY_SWITCHDEV to make sure DEV_PATH_BR_VLAN_UNTAG is
> >> set when there is a dsa-switch inside the bridge.
> >>
> >> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> >> ---
> >>  net/bridge/br_private.h |  1 +
> >>  net/bridge/br_vlan.c    | 18 +++++++++++++++++-
> >>  2 files changed, 18 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> >> index 8da7798f9368..7d427214cc7c 100644
> >> --- a/net/bridge/br_private.h
> >> +++ b/net/bridge/br_private.h
> >> @@ -180,6 +180,7 @@ enum {
> >>  	BR_VLFLAG_MCAST_ENABLED = BIT(2),
> >>  	BR_VLFLAG_GLOBAL_MCAST_ENABLED = BIT(3),
> >>  	BR_VLFLAG_NEIGH_SUPPRESS_ENABLED = BIT(4),
> >> +	BR_VLFLAG_TAGGING_BY_SWITCHDEV = BIT(5),
> >>  };
> >>  
> >>  /**
> >> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> >> index 1830d7d617cd..b7877724b969 100644
> >> --- a/net/bridge/br_vlan.c
> >> +++ b/net/bridge/br_vlan.c
> >> @@ -3,6 +3,7 @@
> >>  #include <linux/netdevice.h>
> >>  #include <linux/rtnetlink.h>
> >>  #include <linux/slab.h>
> >> +#include <net/dsa.h>
> >>  #include <net/switchdev.h>
> >>  
> >>  #include "br_private.h"
> >> @@ -100,6 +101,19 @@ static void __vlan_flags_commit(struct net_bridge_vlan *v, u16 flags)
> >>  	__vlan_flags_update(v, flags, true);
> >>  }
> >>  
> >> +static inline bool br_vlan_tagging_by_switchdev(struct net_bridge *br)
> > 
> > no inline in .c files and also constify br
> > 
> >> +{
> >> +#if IS_ENABLED(CONFIG_NET_DSA)
> >> +	struct net_bridge_port *p;
> >> +
> >> +	list_for_each_entry(p, &br->port_list, list) {
> >> +		if (dsa_user_dev_check(p->dev))
> > 
> > I don't think this can change at runtime, so please keep a counter in
> > the bridge and don't walk the port list on every vlan add.
> > 
> 
> you can use an internal bridge opt (check br_private.h) with a private opt
> that's set when such device is added as a port, no need for a full counter
> obviously

To continue on Nikolay's line of thought...

Can you abstractly describe which functional behavior do you need the
bridge port to perform, rather than "it needs to be a DSA user port"?

switchdev_bridge_port_offload() has a mechanism to inform the bridge
core of extra abilities (like tx_fwd_offload). Perhaps you could modify
the DSA drivers you need to set a similar bit to inform the bridge of
their presence and ability. That would also work when the bridge port is
a LAG over a DSA user port.

Also, please also CC DSA maintainers when you use DSA API outside
net/dsa/ and drivers/net/dsa/. I am in the process of revamping the
public DSA API and would like to be in touch with changes as they are
made.

> >> +			return false;
> >> +	}
> >> +#endif
> >> +	return true;
> >> +}
> >> +
> >>  static int __vlan_vid_add(struct net_device *dev, struct net_bridge *br,
> >>  			  struct net_bridge_vlan *v, u16 flags,
> >>  			  struct netlink_ext_ack *extack)
> >> @@ -113,6 +127,8 @@ static int __vlan_vid_add(struct net_device *dev, struct net_bridge *br,
> >>  	if (err == -EOPNOTSUPP)
> >>  		return vlan_vid_add(dev, br->vlan_proto, v->vid);
> >>  	v->priv_flags |= BR_VLFLAG_ADDED_BY_SWITCHDEV;
> >> +	if (br_vlan_tagging_by_switchdev(br))
> >> +		v->priv_flags |= BR_VLFLAG_TAGGING_BY_SWITCHDEV;
> >>  	return err;
> >>  }
> >>  
> >> @@ -1491,7 +1507,7 @@ int br_vlan_fill_forward_path_mode(struct net_bridge *br,
> >>  
> >>  	if (path->bridge.vlan_mode == DEV_PATH_BR_VLAN_TAG)
> >>  		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_KEEP;
> >> -	else if (v->priv_flags & BR_VLFLAG_ADDED_BY_SWITCHDEV)
> >> +	else if (v->priv_flags & BR_VLFLAG_TAGGING_BY_SWITCHDEV)
> >>  		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG_HW;
> >>  	else
> >>  		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG;
> > 
