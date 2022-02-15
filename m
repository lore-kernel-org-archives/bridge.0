Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=MqEd8VO3pWd8SQKjx
 AoofoUTvP3sevVVpQLDzXC7wFE=; b=Pz+oyQxsNY3rMYGN2rUE8Q/ggVHBOL389
 VPPg6q4vxv1/NB5s1IFK6IvK2F+gN0mYWxciGiORo9QCBfL0QKdQYw8zpwcLA/Rm
 ylmUHvu1g2dUrtWoV+1lgT7RRyTZQ6azCc9MdwAHuZ2wc2cf+kHZUa7mTSBFp+GR
 QsPA1yuwLoOjlRAtIGlBJ77vnBKyhZjXKLdDhOq4hnyWxikoK+2Gt629AWMdWIpM
 0eYF6pV/gVz+TWla6ocFX0uQmny1P6BLnzxpoYsrgC8UPFQglhULmRvQgznaKB8z
 SFDnWqphhZyOYmCap08dwCoA1V+6OIdYcfiMgqv6g6xVbGJ1V2t3A==
Date: Tue, 15 Feb 2022 15:34:56 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YgusADHmOIwQiI3a@shredder>
References: <20220211131426.5433-1-oleksandr.mazur@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211131426.5433-1-oleksandr.mazur@plvision.eu>
Subject: Re: [Bridge] [PATCH] net: bridge: multicast: notify switchdev
 driver whenever MC processing gets disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Fri, Feb 11, 2022 at 03:14:26PM +0200, Oleksandr Mazur wrote:
> Whenever bridge driver hits the max capacity of MDBs, it disables
> the MC processing (by setting corresponding bridge option), but never
> notifies switchdev about such change (the notifiers are called only upon
> explicit setting of this option, through the registered netlink interface).
> 
> This could lead to situation when Software MDB processing gets disabled,
> but this event never gets offloaded to the underlying Hardware.
> 
> Fix this by adding a notify message in such case.
> 
> Signed-off-by: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
> ---
>  net/bridge/br_multicast.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index de2409889489..d53c08906bc8 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -82,6 +82,9 @@ static void br_multicast_find_del_pg(struct net_bridge *br,
>  				     struct net_bridge_port_group *pg);
>  static void __br_multicast_stop(struct net_bridge_mcast *brmctx);
>  
> +static int br_mc_disabled_update(struct net_device *dev, bool value,
> +				 struct netlink_ext_ack *extack);
> +
>  static struct net_bridge_port_group *
>  br_sg_port_find(struct net_bridge *br,
>  		struct net_bridge_port_group_sg_key *sg_p)
> @@ -1156,6 +1159,8 @@ struct net_bridge_mdb_entry *br_multicast_new_group(struct net_bridge *br,
>  		return mp;
>  
>  	if (atomic_read(&br->mdb_hash_tbl.nelems) >= br->hash_max) {
> +		err = br_mc_disabled_update(br->dev, false, NULL);
> +		WARN_ON(err && err != -EOPNOTSUPP);

What is the purpose of the WARN_ON()? There are a lot of operations that
can fail in rollback paths, but we never WARN_ON() there

I suggest:

br_mc_disabled_update(br->dev, false, NULL);

>  		br_opt_toggle(br, BROPT_MULTICAST_ENABLED, false);
>  		return ERR_PTR(-E2BIG);
>  	}
> -- 
> 2.17.1
> 
