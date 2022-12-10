Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E1A824037E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C2D8A40347
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2toN10eNhv4HMWKFSZK+9VKl4CVOBThXiT0ZKUDwpuE=;
 b=OL+RNn+JPRMvesKemlCHHqCrTnCg18zSVl6ocuu4sV/k+xaqDUXWaBKaTpnd7qTqAm/jEzYhmmnm8UGsmNhkRgGII7SbRBJ80qGK6Dj9ODr1lfB5mtuA+PKaKS528s7Nlssrwxu01q1/FvsUMZ2utVja7nnBnl5fxFhsvG+tQEgt3Rps1hkqmr5ZUPk8NQ/A8MnZ9bgH+7qOivlvX46OX69AuIV6/MJAZskOOJ7Nj5sn3ftQItlUoF5CZESUjgyWA+zNQ4LaxUc3MA/WOTnK4r+gTcCqCQcWbeKhqayTilZOax4T2uGnIT/I/benwjgoB7jzslrQEW/I1tGuNZv2qg==
Date: Sat, 10 Dec 2022 15:59:14 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y5SQsuAiiZUO4mrL@shredder>
References: <20221208152839.1016350-1-idosch@nvidia.com>
 <20221208152839.1016350-13-idosch@nvidia.com>
 <38bcf2b8-83eb-1df7-b836-d2de4db851a0@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38bcf2b8-83eb-1df7-b836-d2de4db851a0@blackwall.org>
MIME-Version: 1.0
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
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On Fri, Dec 09, 2022 at 10:08:48AM +0200, Nikolay Aleksandrov wrote:
> On 08/12/2022 17:28, Ido Schimmel wrote:
> > +static int br_mdb_replace_group_sg(const struct br_mdb_config *cfg,
> > +				   struct net_bridge_mdb_entry *mp,
> > +				   struct net_bridge_port_group *pg,
> > +				   struct net_bridge_mcast *brmctx,
> > +				   unsigned char flags,
> > +				   struct netlink_ext_ack *extack)
> 
> extack seems unused here

Oops, will remove. Audited the code and didn't find more places where
extack is passed unnecessarily.

> 
> > +{
> > +	unsigned long now = jiffies;
> > +
> > +	pg->flags = flags;
> > +	pg->rt_protocol = cfg->rt_protocol;
> > +	if (!(flags & MDB_PG_FLAGS_PERMANENT) && !cfg->src_entry)
> > +		mod_timer(&pg->timer,
> > +			  now + brmctx->multicast_membership_interval);
> > +	else
> > +		del_timer(&pg->timer);
> > +
> > +	br_mdb_notify(cfg->br->dev, mp, pg, RTM_NEWMDB);
> > +
> > +	return 0;
> > +}
> > +
> >  static int br_mdb_add_group_sg(const struct br_mdb_config *cfg,
> >  			       struct net_bridge_mdb_entry *mp,
> >  			       struct net_bridge_mcast *brmctx,
> [snip]
> > diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> > index cdc9e040f1f6..2473add41e16 100644
> > --- a/net/bridge/br_private.h
> > +++ b/net/bridge/br_private.h
> > @@ -107,6 +107,7 @@ struct br_mdb_config {
> >  	struct br_mdb_src_entry		*src_entries;
> >  	int				num_src_entries;
> >  	u8				rt_protocol;
> > +	u32				nlflags;
> 
> nlmsg_flags is u16 (__u16), also I'd add it before rt_protocol

Not sure why I used u32... Changed to u16 and moved it after
'filter_mode' to fill in the 2 bytes hole:

struct br_mdb_config {
        struct net_bridge *        br;                   /*     0     8 */
        struct net_bridge_port *   p;                    /*     8     8 */
        struct br_mdb_entry *      entry;                /*    16     8 */
        struct br_ip               group;                /*    24    36 */
        bool                       src_entry;            /*    60     1 */
        u8                         filter_mode;          /*    61     1 */
        u16                        nlflags;              /*    62     2 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        struct br_mdb_src_entry *  src_entries;          /*    64     8 */
        int                        num_src_entries;      /*    72     4 */
        u8                         rt_protocol;          /*    76     1 */

        /* size: 80, cachelines: 2, members: 10 */
        /* padding: 3 */
        /* last cacheline: 16 bytes */
};

Thanks!
