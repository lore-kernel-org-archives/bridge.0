Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=vBxCLD
 8Z9lSYgq7+MTO7O7SI2l1GNxu2hWV7szFNHTw=; b=h22xYJ/DTwMWQIQGejc4cA
 588jMPBczATNQ2fXqhKHjaiTBJ17BpEVE6Edk+vjPBbzhagBjMDjlL8eQ1pCw6Pl
 N3jdL8oI8RTLNkVuc36NyGKn5YKMchJWSxDEdUJ8iOvDBglL3DUB93qhl7SFsDp0
 5Wo13H4sbAYrLTtc/8278pZCuk1eEY1DkId1U0G5+9MUzncerjjVxV8DoevUzona
 z2zS9sZewRLouLOwT2/5hfr6dpJfq13fNvT58IuQVlaGlsU5hdiaNU6ml94LxbzY
 e/NQfXAFeSn/Euf57H/4Dlin4GoKl7kkrEtlvWgw83ehG4W5jPv+f2kyeI2Qrb9g
 ==
Date: Mon, 9 Aug 2021 15:16:40 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YREcqAdU+6IpT0+w@shredder>
References: <20210801231730.7493-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801231730.7493-1-vladimir.oltean@nxp.com>
Subject: Re: [Bridge] [PATCH net] net: bridge: validate the NUD_PERMANENT
 bit when adding an extern_learn FDB entry
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, nikolay@nvidia.com
Cc: syzbot+9ba1174359adba5a5b7c@syzkaller.appspotmail.com, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Mon, Aug 02, 2021 at 02:17:30AM +0300, Vladimir Oltean wrote:
> diff --git a/net/bridge/br.c b/net/bridge/br.c
> index ef743f94254d..bbab9984f24e 100644
> --- a/net/bridge/br.c
> +++ b/net/bridge/br.c
> @@ -166,7 +166,8 @@ static int br_switchdev_event(struct notifier_block *unused,
>  	case SWITCHDEV_FDB_ADD_TO_BRIDGE:
>  		fdb_info = ptr;
>  		err = br_fdb_external_learn_add(br, p, fdb_info->addr,
> -						fdb_info->vid, false);
> +						fdb_info->vid,
> +						fdb_info->is_local, false);

When 'is_local' was added in commit 2c4eca3ef716 ("net: bridge:
switchdev: include local flag in FDB notifications") it was not
initialized in all the call sites that emit
'SWITCHDEV_FDB_ADD_TO_BRIDGE' notification, so it can contain garbage.

>  		if (err) {
>  			err = notifier_from_errno(err);
>  			break;

[...]

> @@ -1281,6 +1292,10 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>  
>  		if (swdev_notify)
>  			flags |= BIT(BR_FDB_ADDED_BY_USER);
> +
> +		if (is_local)
> +			flags |= BIT(BR_FDB_LOCAL);

I have at least once selftest where I forgot the 'static' keyword:

bridge fdb add de:ad:be:ef:13:37 dev $swp1 master extern_learn vlan 1

This patch breaks the test when run against both the kernel and hardware
data paths. I don't mind patching these tests, but we might get more
reports in the future.

Nik, what do you think?

> +
>  		fdb = fdb_create(br, p, addr, vid, flags);
>  		if (!fdb) {
>  			err = -ENOMEM;
> @@ -1307,6 +1322,9 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>  		if (swdev_notify)
>  			set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
>  
> +		if (is_local)
> +			set_bit(BR_FDB_LOCAL, &fdb->flags);
> +
>  		if (modified)
>  			fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
>  	}
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 2b48b204205e..aa64d8d63ca3 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -711,7 +711,7 @@ int br_fdb_get(struct sk_buff *skb, struct nlattr *tb[], struct net_device *dev,
>  int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p);
>  void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p);
>  int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
> -			      const unsigned char *addr, u16 vid,
> +			      const unsigned char *addr, u16 vid, bool is_local,
>  			      bool swdev_notify);
>  int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
>  			      const unsigned char *addr, u16 vid,
> -- 
> 2.25.1
> 
