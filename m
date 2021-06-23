Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8TikY28p6MkkuEcz2trXOK3hF0Rob1pcXh2UsyjqsM=;
 b=JDxMLEScD4ShgSCy8lLXZ6B7zKeaohx4OC5ybA+DLTeCmMJ2dV68pSEGDcSJgRHf/dSSPbhQd1VFcIwSE6KgUijL5dsdnxVdj5nNROTrcUOrFw4kQx55dlRYDpElZgecjJJA49uWXZXs5QIPD0p3+qUhwb02pOA6UhIVvbiwyF7WtUWeRjxZWrq9HAhw11+sHsw0kazfxSqhGdhzDLagdW86HwZW4AswMyOKGnk5HTlkgXmqrctOrHP8vAk+IlBQydgYjxqUYPdteZuLDt6ZDJE/EG7P6SuEhBIwTH8WRJxbp7pVwQckNoUsYoCHx0GoqqRVs4E2CCcHAKRyUihcJw==
References: <20210623133426.2613847-1-wintera@linux.ibm.com>
 <20210623133426.2613847-3-wintera@linux.ibm.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <20640f73-c661-5901-f8f2-f4d88a79ea43@nvidia.com>
Date: Wed, 23 Jun 2021 16:53:08 +0300
In-Reply-To: <20210623133426.2613847-3-wintera@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 2/2] net/bridge: Update uc addr on
 LEARNING_SYNC bp
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alexandra Winter <wintera@linux.ibm.com>, roopa@nvidia.com, bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org, jwi@linux.ibm.com

On 23/06/2021 16:34, Alexandra Winter wrote:
> Whenever a unicast fdb entry is added or deleted in the software
> bridge's fdb, synchronize it to the hardware fdb of a bridgeport
> device, if the bridgeport has the attribute LEARNING_SYNC and is not
> isolated from the target of the changed fdb entry.
> 
> To inform HW, that messages with a specific unicast target address
> should be sent to the software bridge via this bridgeport, simply
> register this address with the device.
> 
> Without this patch smart NICs attached to a bridgeport of a software
> bridge can already do their own learning on the messages that the
> SW bridge sends out via this port. And otherwise accept/flood all
> unknown target messages to the SW bridge (promiscuous port).
> This patch gives the attached HW the chance to update its fdb, even
> when it does not see the respective message, because it is forwarded
> to another piece of HW attached to another bridgeport. Or when the NIC
> is not capable of learning or flooding.
> 
> An alternative solution would be to subscribe to the
> SWITCHDEV_FDB_ADD/DEL_TO_DEVICE switchdev notifiers in the respective
> device drivers. But as there's no HW-specific part in this
> implementation, it was felt that this should rather be implemented in
> the common layer of the bridge code.
> 
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
>  net/bridge/br_fdb.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 

Absolutely no way, I'm sorry but br_fdb_update() is called when learning on every packet,
walking the port list on every fdb port change is a disastrous overkill.
You already have specified the alternative yourself, please use the switchdev notifiers
that are there and already take up the necessary processing in the fast paths.

Nacked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 698b79747d32..2075b5da6db3 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -567,6 +567,32 @@ int br_fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
>  	return ret;
>  }
>  
> +static void br_fdb_learning_sync(struct net_bridge *br,
> +				 const struct net_bridge_fdb_entry *fdb,
> +				 int type)
> +{
> +	struct net_bridge_port *p;
> +
> +	if (!fdb->dst)
> +		return;
> +	list_for_each_entry(p, &br->port_list, list) {

You can't just walk the port list without any synchronization.

> +		if ((p->flags & BR_LEARNING_SYNC) && p != fdb->dst &&
> +		    (!(p->flags & BR_ISOLATED) ||

These flags can change while running...

> +		     !(fdb->dst->flags & BR_ISOLATED))) {
> +			switch (type) {
> +			case RTM_DELNEIGH:
> +				dev_uc_del(p->dev, fdb->key.addr.addr);
> +				break;
> +			case RTM_NEWNEIGH:
> +				dev_uc_add(p->dev, fdb->key.addr.addr);
> +				break;

... and you can end up having programmed a lot of dynamic fdbs that will never get removed.

> +			default:
> +				break;
> +			}
> +		}
> +	}
> +}
> +
>  /* returns true if the fdb was modified */
>  static bool __fdb_mark_active(struct net_bridge_fdb_entry *fdb)
>  {
> @@ -603,6 +629,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
>  			if (unlikely(source != fdb->dst &&
>  				     !test_bit(BR_FDB_STICKY, &fdb->flags))) {
>  				br_switchdev_fdb_notify(fdb, RTM_DELNEIGH);
> +				br_fdb_learning_sync(br, fdb, RTM_DELNEIGH);
>  				fdb->dst = source;
>  				fdb_modified = true;
>  				/* Take over HW learned entry */
> @@ -799,6 +826,7 @@ static void fdb_notify(struct net_bridge *br,
>  		goto errout;
>  	}
>  	rtnl_notify(skb, net, 0, RTNLGRP_NEIGH, NULL, GFP_ATOMIC);
> +	br_fdb_learning_sync(br, fdb, type);
>  	return;
>  errout:
>  	rtnl_set_sk_err(net, RTNLGRP_NEIGH, err);
> 

