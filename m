Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 103AA414A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0903F410D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sInxKAvWLrMiI4fj8yMPqsC6tYHDJ+LuR9I4DU3L8N4=;
 b=C0/uDINpzs13oxx0s5AE72rKVpMHz0zuD3NZ9ti5IZ6TL4EumMAJ+YO8DWegNoILKJ
 pEfV8UwZ59XNbeHBrG//Eo7m1KM9+Y5aUj3rUj81RDYaDbsetkUD6TSMskO7ZkPtzebn
 PUxHKoT3owEDE/O35e8vt+82aGJNm70nUwL4P4/t4prX1Qg6pP1C2c9V9ZkMPpdpD8ud
 FPo6pE0WVbRlaF3nyAnzh2IpQu8XmkA6te8nzGCuPTSU2S0a5xSNhY3/ln5WKotzwzn5
 yWKWqz5T6qUNKZwF9K/S9nVnBsppwDBE+WinzzXSaVJxAtd7edX8S2EFNbAov24AXhrU
 fpSg==
Message-ID: <38bcf2b8-83eb-1df7-b836-d2de4db851a0@blackwall.org>
Date: Fri, 9 Dec 2022 10:08:48 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221208152839.1016350-1-idosch@nvidia.com>
 <20221208152839.1016350-13-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221208152839.1016350-13-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 12/14] bridge: mcast: Support
 replacement of MDB port group entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 08/12/2022 17:28, Ido Schimmel wrote:
> Now that user space can specify additional attributes of port group
> entries such as filter mode and source list, it makes sense to allow
> user space to atomically modify these attributes by replacing entries
> instead of forcing user space to delete the entries and add them back.
> 
> Replace MDB port group entries when the 'NLM_F_REPLACE' flag is
> specified in the netlink message header.
> 
> When a (*, G) entry is replaced, update the following attributes: Source
> list, state, filter mode, protocol and flags. If the entry is temporary
> and in EXCLUDE mode, reset the group timer to the group membership
> interval. If the entry is temporary and in INCLUDE mode, reset the
> source timers of associated sources to the group membership interval.
> 
> Examples:
> 
>  # bridge mdb replace dev br0 port dummy10 grp 239.1.1.1 permanent source_list 192.0.2.1,192.0.2.2 filter_mode include
>  # bridge -d -s mdb show
>  dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.2 permanent filter_mode include proto static     0.00
>  dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.1 permanent filter_mode include proto static     0.00
>  dev br0 port dummy10 grp 239.1.1.1 permanent filter_mode include source_list 192.0.2.2/0.00,192.0.2.1/0.00 proto static     0.00
> 
>  # bridge mdb replace dev br0 port dummy10 grp 239.1.1.1 permanent source_list 192.0.2.1,192.0.2.3 filter_mode exclude proto zebra
>  # bridge -d -s mdb show
>  dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.3 permanent filter_mode include proto zebra  blocked    0.00
>  dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.1 permanent filter_mode include proto zebra  blocked    0.00
>  dev br0 port dummy10 grp 239.1.1.1 permanent filter_mode exclude source_list 192.0.2.3/0.00,192.0.2.1/0.00 proto zebra     0.00
> 
>  # bridge mdb replace dev br0 port dummy10 grp 239.1.1.1 temp source_list 192.0.2.4,192.0.2.3 filter_mode include proto bgp
>  # bridge -d -s mdb show
>  dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.4 temp filter_mode include proto bgp     0.00
>  dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.3 temp filter_mode include proto bgp     0.00
>  dev br0 port dummy10 grp 239.1.1.1 temp filter_mode include source_list 192.0.2.4/259.44,192.0.2.3/259.44 proto bgp     0.00
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c     | 103 ++++++++++++++++++++++++++++++++++++++--
>  net/bridge/br_private.h |   1 +
>  2 files changed, 99 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index 72d4e53193e5..98d899427c03 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -802,6 +802,28 @@ __br_mdb_choose_context(struct net_bridge *br,
>  	return brmctx;
>  }
>  
> +static int br_mdb_replace_group_sg(const struct br_mdb_config *cfg,
> +				   struct net_bridge_mdb_entry *mp,
> +				   struct net_bridge_port_group *pg,
> +				   struct net_bridge_mcast *brmctx,
> +				   unsigned char flags,
> +				   struct netlink_ext_ack *extack)

extack seems unused here

> +{
> +	unsigned long now = jiffies;
> +
> +	pg->flags = flags;
> +	pg->rt_protocol = cfg->rt_protocol;
> +	if (!(flags & MDB_PG_FLAGS_PERMANENT) && !cfg->src_entry)
> +		mod_timer(&pg->timer,
> +			  now + brmctx->multicast_membership_interval);
> +	else
> +		del_timer(&pg->timer);
> +
> +	br_mdb_notify(cfg->br->dev, mp, pg, RTM_NEWMDB);
> +
> +	return 0;
> +}
> +
>  static int br_mdb_add_group_sg(const struct br_mdb_config *cfg,
>  			       struct net_bridge_mdb_entry *mp,
>  			       struct net_bridge_mcast *brmctx,
[snip]
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index cdc9e040f1f6..2473add41e16 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -107,6 +107,7 @@ struct br_mdb_config {
>  	struct br_mdb_src_entry		*src_entries;
>  	int				num_src_entries;
>  	u8				rt_protocol;
> +	u32				nlflags;

nlmsg_flags is u16 (__u16), also I'd add it before rt_protocol

>  };
>  #endif
>  

