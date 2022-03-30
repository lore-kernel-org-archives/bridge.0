Return-Path: <wintera@linux.ibm.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Rf/rgxd6qNOBM/p+PYQJHBSjZyI1VzCDF2pZLHjtnSA=;
 b=nO9SF6KTVOOVUo9F2l32qBIM6p0GJFL0DJ5IKi4zSMZs7M27fArYzBWCu3ZVAI+Qhk2s
 C8L2nZtIowYRD7IYCB0rzZNOcurMJiepfR6YsbLGiMtCHA/Myevch+nokCTWGiEEJFjH
 xLk5AzthuAt0Q7c9+K9i/n5KuYKQdhxKRzzHuCevIRVzUpGAgpAGPN3R+zC2GaVq9LRL
 vDFqXaQd7x0aC7FdRNn7jiikV2B4MmNM9tGs/O4KllR1F8kx8VprsdyWZk8jaKup2HRg
 qadra0sHA1cX3hayB1TVwJuZCGRHNyaTT/3qPYrhbM+hxTakRqtFyJXN/M950txluLP1 xA== 
Message-ID: <c1ec0612-063b-dbfa-e10a-986786178c93@linux.ibm.com>
Date: Wed, 30 Mar 2022 13:14:12 +0200
Content-Language: en-US
References: <20220329114052.237572-1-wintera@linux.ibm.com>
 <20220329175421.4a6325d9@kernel.org>
 <d2e45c4a-ed34-10d3-58cd-01b1c19bd004@blackwall.org>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <d2e45c4a-ed34-10d3-58cd-01b1c19bd004@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v2] veth: Support bonding events
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@nvidia.com>



On 30.03.22 12:23, Nikolay Aleksandrov wrote:
> On 30/03/2022 03:54, Jakub Kicinski wrote:
>> Dropping the BPF people from CC and adding Hangbin, bridge and
>> bond/team. Please exercise some judgment when sending patches.
Thank you. 
I did  'scripts/get_maintainer.pl drivers/net/veth.c'
but was a bit surprised about the outcome.

>>
>> On Tue, 29 Mar 2022 13:40:52 +0200 Alexandra Winter wrote:
>>> Bonding drivers generate specific events during failover that trigger
>>> switch updates.  When a veth device is attached to a bridge with a
>>> bond interface, we want external switches to learn about the veth
>>> devices as well.
>>>
>>> Example:
>>>
>>> 	| veth_a2   |  veth_b2  |  veth_c2 |
>>> 	------o-----------o----------o------
>>> 	       \	  |	    /
>>> 		o	  o	   o
>>> 	      veth_a1  veth_b1  veth_c1
>>> 	      -------------------------
>>> 	      |        bridge         |
>>> 	      -------------------------
>>> 			bond0
>>> 			/  \
>>> 		     eth0  eth1
>>>
>>> In case of failover from eth0 to eth1, the netdev_notifier needs to be
>>> propagated, so e.g. veth_a2 can re-announce its MAC address to the
>>> external hardware attached to eth1.
>>>
>>> Without this patch we have seen cases where recovery after bond failover
>>> took an unacceptable amount of time (depending on timeout settings in the
>>> network).
>>>
>>> Due to the symmetric nature of veth special care is required to avoid
>>> endless notification loops. Therefore we only notify from a veth
>>> bridgeport to a peer that is not a bridgeport.
>>>
>>> References:
>>> Same handling as for macvlan:
>>> commit 4c9912556867 ("macvlan: Support bonding events")
>>> and vlan:
>>> commit 4aa5dee4d999 ("net: convert resend IGMP to notifier event")
>>>
>>> Alternatives:
>>> Propagate notifier events to all ports of a bridge. IIUC, this was
>>> rejected in https://www.spinics.net/lists/netdev/msg717292.html
>>
>> My (likely flawed) reading of Nik's argument was that (1) he was
>> concerned about GARP storms; (2) he didn't want the GARP to be
>> broadcast to all ports, just the bond that originated the request.
>>
> 
> Yes, that would be ideal. Trying to avoid unnecessary bcasts, that is
> especially important for large setups with lots of devices.

One way to target the bond that originated the request, would be if the
bridge itself would do GARPs/RARPS/..,  on this bond port for all MACs
that are in its FDB. What do you think about that?

> 
>> I'm not sure I follow (1), as Hangbin said the event is rare, plus 
>> GARP only comes from interfaces that have an IP addr, which IIUC
>> most bridge ports will not have.
>>
> 
> Indeed, such setups are not the most common ones.
> 
>> This patch in no way addresses (2). But then, again, if we put 
>> a macvlan on top of a bridge master it will shotgun its GARPS all 
>> the same. So it's not like veth would be special in that regard.
>>
>> Nik, what am I missing?
>>
> 
> If we're talking about macvlan -> bridge -> bond then the bond flap's
> notify peers shouldn't reach the macvlan. Generally broadcast traffic
> is quite expensive for the bridge, I have patches that improve on the
> technical side (consider ports only for the same bcast domain), but you also
> wouldn't want unnecessary bcast packets being sent around. :)
> There are setups with tens of bond devices and propagating that to all would be
> very expensive, but most of all unnecessary. It would also hurt setups with
> a lot of vlan devices on the bridge. There are setups with hundreds of vlans
> and hundreds of macvlans on top, propagating it up would send it to all of
> them and that wouldn't scale at all, these mostly have IP addresses too.
> 
> Perhaps we can enable propagation on a per-port or per-bridge basis, then we
> can avoid these walks. That is, make it opt-in.
> 
>>> It also seems difficult to avoid re-bouncing the notifier.
>>
>> syzbot will make short work of this patch, I think the potential
>> for infinite loops has to be addressed somehow. IIUC this is the 
>> first instance of forwarding those notifiers to a peer rather
>> than within a upper <> lower device hierarchy which is a DAG.

My concern was about the Hangbin's alternative proposal to notify all
bridge ports. I hope in my porposal I was able to avoid infinite loops.

>>
>>> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>>> --- 
>>>  drivers/net/veth.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 53 insertions(+)
>>>
>>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>>> index d29fb9759cc9..74b074453197 100644
>>> --- a/drivers/net/veth.c
>>> +++ b/drivers/net/veth.c
>>> @@ -1579,6 +1579,57 @@ static void veth_setup(struct net_device *dev)
>>>  	dev->mpls_features = NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE;
>>>  }
>>>  
>>> +static bool netif_is_veth(const struct net_device *dev)
>>> +{
>>> +	return (dev->netdev_ops == &veth_netdev_ops);
>>
>> brackets unnecessary 
>>
>>> +}
>>> +
>>> +static void veth_notify_peer(unsigned long event, const struct net_device *dev)
>>> +{
>>> +	struct net_device *peer;
>>> +	struct veth_priv *priv;
>>> +
>>> +	priv = netdev_priv(dev);
>>> +	peer = rtnl_dereference(priv->peer);
>>> +	/* avoid re-bounce between 2 bridges */
>>> +	if (!netif_is_bridge_port(peer))
>>> +		call_netdevice_notifiers(event, peer);
>>> +}
>>> +
>>> +/* Called under rtnl_lock */
>>> +static int veth_device_event(struct notifier_block *unused,
>>> +			     unsigned long event, void *ptr)
>>> +{
>>> +	struct net_device *dev, *lower;
>>> +	struct list_head *iter;
>>> +
>>> +	dev = netdev_notifier_info_to_dev(ptr);
>>> +
>>> +	switch (event) {
>>> +	case NETDEV_NOTIFY_PEERS:
>>> +	case NETDEV_BONDING_FAILOVER:
>>> +	case NETDEV_RESEND_IGMP:
>>> +		/* propagate to peer of a bridge attached veth */
>>> +		if (netif_is_bridge_master(dev)) {
>>
>> Having veth sift thru bridge ports seems strange.
>> In fact it could be beneficial to filter the event based on
>> port state (whether it's forwarding, vlan etc). But looking
>> at details of port state outside the bridge would be even stranger.
>>
>>> +			iter = &dev->adj_list.lower;
>>> +			lower = netdev_next_lower_dev_rcu(dev, &iter);
>>> +			while (lower) {
>>> +				if (netif_is_veth(lower))
>>> +					veth_notify_peer(event, lower);
>>> +				lower = netdev_next_lower_dev_rcu(dev, &iter);
>>
>> let's add netdev_for_each_lower_dev_rcu() rather than open-coding
>>
>>> +			}
>>> +		}
>>> +		break;
>>> +	default:
>>> +		break;
>>> +	}
>>> +	return NOTIFY_DONE;
>>> +}
>>> +
>>> +static struct notifier_block veth_notifier_block __read_mostly = {
>>> +		.notifier_call  = veth_device_event,
>>
>> extra tab here
>>
>>> +};
>>> +
>>>  /*
>>>   * netlink interface
>>>   */
>>> @@ -1824,12 +1875,14 @@ static struct rtnl_link_ops veth_link_ops = {
>>>  
>>>  static __init int veth_init(void)
>>>  {
>>> +	register_netdevice_notifier(&veth_notifier_block);
>>
>> this can fail
>>
>>>  	return rtnl_link_register(&veth_link_ops);
>>>  }
>>>  
>>>  static __exit void veth_exit(void)
>>>  {
>>>  	rtnl_link_unregister(&veth_link_ops);
>>> +	unregister_netdevice_notifier(&veth_notifier_block);
>>>  }
>>>  
>>>  module_init(veth_init);
>>
> 
