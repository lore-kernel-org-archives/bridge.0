Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599425766;
 bh=YThGDUg5nFUL/+bjdVbPqJVWfsFNLrETXsYiWQzi5OY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fO6J4lmEt5iR8ZPfMlUXpIDsp+0Jl6zGRs+kynqyq2vIRj2CcXOrCVPLct1WUq0+3
 unNwwaTqrm7UesoZ+Xld0RlC88nisPq70+IMtppn1Z/AXym1N19He1UkRyCTui41i9
 BXcr03y7QyxNPVM74tQgDRXJIUFejBYyXCL+Go24=
Date: Sun, 6 Sep 2020 13:56:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20200906135604.4d47b7a8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200905082410.2230253-6-nikolay@cumulusnetworks.com>
References: <20200905082410.2230253-1-nikolay@cumulusnetworks.com>
 <20200905082410.2230253-6-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 05/15] net: bridge: mcast: factor
 out port group del
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

On Sat,  5 Sep 2020 11:24:00 +0300 Nikolay Aleksandrov wrote:
> @@ -843,24 +843,11 @@ static int __br_mdb_del(struct net_bridge *br, struct br_mdb_entry *entry)
>  		if (!p->port || p->port->dev->ifindex != entry->ifindex)
>  			continue;
>  
> -		if (!hlist_empty(&p->src_list)) {
> -			err = -EINVAL;
> -			goto unlock;
> -		}
> -
>  		if (p->port->state == BR_STATE_DISABLED)
>  			goto unlock;
>  
> -		__mdb_entry_fill_flags(entry, p->flags);

Just from staring at the code it's unclear why the list_empty() check
and this __mdb_entry_fill_flags() are removed as well.

> -		rcu_assign_pointer(*pp, p->next);
> -		hlist_del_init(&p->mglist);
> -		del_timer(&p->timer);
> -		kfree_rcu(p, rcu);
> +		br_multicast_del_pg(mp, p, pp);
>  		err = 0;
> -
> -		if (!mp->ports && !mp->host_joined &&
> -		    netif_running(br->dev))
> -			mod_timer(&mp->timer, jiffies);
>  		break;


> +void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
> +			 struct net_bridge_port_group *pg,
> +			 struct net_bridge_port_group __rcu **pp)
> +{
> +	struct net_bridge *br = pg->port->br;
> +	struct net_bridge_group_src *ent;
> +	struct hlist_node *tmp;
> +
> +	rcu_assign_pointer(*pp, pg->next);
> +	hlist_del_init(&pg->mglist);
> +	del_timer(&pg->timer);
> +	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
> +		br_multicast_del_group_src(ent);
> +	br_mdb_notify(br->dev, pg->port, &pg->addr, RTM_DELMDB, pg->flags);
> +	kfree_rcu(pg, rcu);
> +
> +	if (!mp->ports && !mp->host_joined && netif_running(br->dev))
> +		mod_timer(&mp->timer, jiffies);
> +}

> @@ -1641,16 +1647,7 @@ br_multicast_leave_group(struct net_bridge *br,
>  			if (p->flags & MDB_PG_FLAGS_PERMANENT)
>  				break;
>  
> -			rcu_assign_pointer(*pp, p->next);
> -			hlist_del_init(&p->mglist);
> -			del_timer(&p->timer);
> -			kfree_rcu(p, rcu);
> -			br_mdb_notify(br->dev, port, group, RTM_DELMDB,
> -				      p->flags | MDB_PG_FLAGS_FAST_LEAVE);

And here we'll loose MDB_PG_FLAGS_FAST_LEAVE potentially?

> -			if (!mp->ports && !mp->host_joined &&
> -			    netif_running(br->dev))
> -				mod_timer(&mp->timer, jiffies);
> +			br_multicast_del_pg(mp, p, pp);
