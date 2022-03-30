Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648601663;
 bh=ubFHj+K9Ba1I+teDUAJ4JZ4+3y1MplBuqIus6GiwDiw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=CBmVsgFhCDd+NEOP2ZOO8xSxJYSrIIdrIXwb0PPG+cVPwXOeRa9wHuJhuD7X0rKua
 lAfcF+KsgnVj1artMm1qqfYlEOH96q6yGvdVKRY2JmaggOVzX9fhFjtTCVnCuA2ybb
 v0gzV9pyn3829oLYBnWI0jqN3eB7O64Q/RcXPTvl/GChNzGvLoZEBSBT6dIysui+MD
 KQ3nJAvXV+Fp4XfUXBfocdC6dRUmOs1dgJ6qqb7nllxWtGO7Q9VEr0SX+GIj7RHSGz
 8Yx0QDNvFuNo+aVCXfEZ1Hd7keBsarI+Qr/reW1y+7im0i/82dpbHYszks7ICxy5Wo
 VC/PXLSMeyVrA==
Date: Tue, 29 Mar 2022 17:54:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220329175421.4a6325d9@kernel.org>
In-Reply-To: <20220329114052.237572-1-wintera@linux.ibm.com>
References: <20220329114052.237572-1-wintera@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] veth: Support bonding events
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alexandra Winter <wintera@linux.ibm.com>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@nvidia.com>

Dropping the BPF people from CC and adding Hangbin, bridge and
bond/team. Please exercise some judgment when sending patches.

On Tue, 29 Mar 2022 13:40:52 +0200 Alexandra Winter wrote:
> Bonding drivers generate specific events during failover that trigger
> switch updates.  When a veth device is attached to a bridge with a
> bond interface, we want external switches to learn about the veth
> devices as well.
> 
> Example:
> 
> 	| veth_a2   |  veth_b2  |  veth_c2 |
> 	------o-----------o----------o------
> 	       \	  |	    /
> 		o	  o	   o
> 	      veth_a1  veth_b1  veth_c1
> 	      -------------------------
> 	      |        bridge         |
> 	      -------------------------
> 			bond0
> 			/  \
> 		     eth0  eth1
> 
> In case of failover from eth0 to eth1, the netdev_notifier needs to be
> propagated, so e.g. veth_a2 can re-announce its MAC address to the
> external hardware attached to eth1.
> 
> Without this patch we have seen cases where recovery after bond failover
> took an unacceptable amount of time (depending on timeout settings in the
> network).
> 
> Due to the symmetric nature of veth special care is required to avoid
> endless notification loops. Therefore we only notify from a veth
> bridgeport to a peer that is not a bridgeport.
> 
> References:
> Same handling as for macvlan:
> commit 4c9912556867 ("macvlan: Support bonding events")
> and vlan:
> commit 4aa5dee4d999 ("net: convert resend IGMP to notifier event")
> 
> Alternatives:
> Propagate notifier events to all ports of a bridge. IIUC, this was
> rejected in https://www.spinics.net/lists/netdev/msg717292.html

My (likely flawed) reading of Nik's argument was that (1) he was
concerned about GARP storms; (2) he didn't want the GARP to be
broadcast to all ports, just the bond that originated the request.

I'm not sure I follow (1), as Hangbin said the event is rare, plus 
GARP only comes from interfaces that have an IP addr, which IIUC
most bridge ports will not have.

This patch in no way addresses (2). But then, again, if we put 
a macvlan on top of a bridge master it will shotgun its GARPS all 
the same. So it's not like veth would be special in that regard.

Nik, what am I missing?

> It also seems difficult to avoid re-bouncing the notifier.

syzbot will make short work of this patch, I think the potential
for infinite loops has to be addressed somehow. IIUC this is the 
first instance of forwarding those notifiers to a peer rather
than within a upper <> lower device hierarchy which is a DAG.

> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
>  drivers/net/veth.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index d29fb9759cc9..74b074453197 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1579,6 +1579,57 @@ static void veth_setup(struct net_device *dev)
>  	dev->mpls_features = NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE;
>  }
>  
> +static bool netif_is_veth(const struct net_device *dev)
> +{
> +	return (dev->netdev_ops == &veth_netdev_ops);

brackets unnecessary 

> +}
> +
> +static void veth_notify_peer(unsigned long event, const struct net_device *dev)
> +{
> +	struct net_device *peer;
> +	struct veth_priv *priv;
> +
> +	priv = netdev_priv(dev);
> +	peer = rtnl_dereference(priv->peer);
> +	/* avoid re-bounce between 2 bridges */
> +	if (!netif_is_bridge_port(peer))
> +		call_netdevice_notifiers(event, peer);
> +}
> +
> +/* Called under rtnl_lock */
> +static int veth_device_event(struct notifier_block *unused,
> +			     unsigned long event, void *ptr)
> +{
> +	struct net_device *dev, *lower;
> +	struct list_head *iter;
> +
> +	dev = netdev_notifier_info_to_dev(ptr);
> +
> +	switch (event) {
> +	case NETDEV_NOTIFY_PEERS:
> +	case NETDEV_BONDING_FAILOVER:
> +	case NETDEV_RESEND_IGMP:
> +		/* propagate to peer of a bridge attached veth */
> +		if (netif_is_bridge_master(dev)) {

Having veth sift thru bridge ports seems strange.
In fact it could be beneficial to filter the event based on
port state (whether it's forwarding, vlan etc). But looking
at details of port state outside the bridge would be even stranger.

> +			iter = &dev->adj_list.lower;
> +			lower = netdev_next_lower_dev_rcu(dev, &iter);
> +			while (lower) {
> +				if (netif_is_veth(lower))
> +					veth_notify_peer(event, lower);
> +				lower = netdev_next_lower_dev_rcu(dev, &iter);

let's add netdev_for_each_lower_dev_rcu() rather than open-coding

> +			}
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block veth_notifier_block __read_mostly = {
> +		.notifier_call  = veth_device_event,

extra tab here

> +};
> +
>  /*
>   * netlink interface
>   */
> @@ -1824,12 +1875,14 @@ static struct rtnl_link_ops veth_link_ops = {
>  
>  static __init int veth_init(void)
>  {
> +	register_netdevice_notifier(&veth_notifier_block);

this can fail

>  	return rtnl_link_register(&veth_link_ops);
>  }
>  
>  static __exit void veth_exit(void)
>  {
>  	rtnl_link_unregister(&veth_link_ops);
> +	unregister_netdevice_notifier(&veth_notifier_block);
>  }
>  
>  module_init(veth_init);

