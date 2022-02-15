Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=son9GE6MNPo/omZeWV9C14oF3rNQ7vb3sPP1hI/9TbA=;
 b=nurn70IUDOZRn0l2zr3yo/dPd9jmowbEwXvRIfnOJwxNTSTLvC5XTxkah8YQuyIZLanb2hspBaFqFp25qmwkafln61p/qkbttuEIXE+/Hvqc5zMNdt0zyiiyi++hjvw5j1BHgsv9QLyfTOHF9TCmlN/TSv57NeOYnGtnhLhallFvmjPsjCJIJkS6oxaMKDjROBST+42KBj8l5xVqlgmrR7sKVy5S7SIlT4553+ROSl2+vVm74PfJLXGnMkP8xiIN8cd0p85oWUpjK6/k/MC6zOsWPgY6Uurztq3eUrtEAnhu9LawPeL3nL3OWNSUwk07GeI5fPE1mkKQcpVVjGUWIw==
Message-ID: <8a3b1ec5-f43c-03ba-f51c-5d1ba809657e@nvidia.com>
Date: Tue, 15 Feb 2022 18:56:31 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220215165303.31908-1-oleksandr.mazur@plvision.eu>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20220215165303.31908-1-oleksandr.mazur@plvision.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v2] net: bridge: multicast: notify
 switchdev driver whenever MC processing gets disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Oleksandr Mazur <oleksandr.mazur@plvision.eu>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Yotam Gigi <yotamg@mellanox.com>, Nogah Frankel <nogahf@mellanox.com>, Jiri Pirko <jiri@mellanox.com>
Cc: taras.chornyi@plvision.eu, vladimir.oltean@nxp.com, bridge@lists.linux-foundation.org, volodymyr.mytnyk@plvision.eu, linux-kernel@vger.kernel.org, mickeyr@marvell.com, netdev@vger.kernel.org

On 15/02/2022 18:53, Oleksandr Mazur wrote:
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
> Fixes: 147c1e9b902c ("switchdev: bridge: Offload multicast disabled")
> 
> Signed-off-by: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
> ---
> V2:
>   - target 'net' tree;
>   - add missed 'Fixes' tag;
>   - remove mc_disabled retcode check, as well as WARN_ON in case of err;
> ---
>  net/bridge/br_multicast.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index de2409889489..db4f2641d1cd 100644
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
> @@ -1156,6 +1159,7 @@ struct net_bridge_mdb_entry *br_multicast_new_group(struct net_bridge *br,
>  		return mp;
>  
>  	if (atomic_read(&br->mdb_hash_tbl.nelems) >= br->hash_max) {
> +		br_mc_disabled_update(br->dev, false, NULL);
>  		br_opt_toggle(br, BROPT_MULTICAST_ENABLED, false);
>  		return ERR_PTR(-E2BIG);
>  	}

nit: you don't have to leave empty new line between Fixes and Signed-off-by.
Patch looks good to me.

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

