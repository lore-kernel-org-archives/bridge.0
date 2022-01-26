Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPp14XIVYAgUDAZDl8SmIvOGlme1mCn9bJPoVGoEuhY=;
 b=ITrQK3SOuTvKwGazvP7Qs4w7lP6YJ3+vQ2GDh0+90XsQDRbHTyhcH4JWdH+L+xGu4k9az5rn5qmQxOS4HNIcVtmxtzPxmaNppf7LY9uXqL2RFc6cbJ6JABkIQRgm+UTScKKATxKkdPnPRDehG9GYaWxAgrh0yWXfFjm3Y6/rKn4hO47Z+5ndoQU+pH3dOi8adUuXWLtbd7nZU0Ibs2r9B2JaP0sgWiFVc6gXjkrqPaE0pmyUufmq5M49p7lXiOnbuqenlaDKpWvn098BF6v8oA+t83ZxEHwdqSI97hxt1+Oe7ekiJcK+PVt6FNhKBqeHaqfg7ID9V/Y/+etr/yJCeg==
Message-ID: <113d070a-6df1-66c2-1586-94591bc5aada@nvidia.com>
Date: Wed, 26 Jan 2022 14:39:37 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1643044381.git.lorenzo@kernel.org>
 <720907692575488526f06edc2cf5c8f783777d4f.1643044381.git.lorenzo@kernel.org>
 <61553c87-a3d3-07ae-8c2f-93cf0cb52263@nvidia.com>
 <YfEwLrB6JqNpdUc0@lore-desk>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <YfEwLrB6JqNpdUc0@lore-desk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC bpf-next 1/2] net: bridge: add unstable
 br_fdb_find_port_from_ifindex helper
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, daniel@iogearbox.net, Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org, dsahern@kernel.org, toke@redhat.com, komachi.yoshiki@gmail.com, ast@kernel.org, davem@davemloft.net, Ido Schimmel <idosch@idosch.org>, memxor@gmail.com, brouer@redhat.com, kuba@kernel.org, bpf@vger.kernel.org, andrii.nakryiko@gmail.com, lorenzo.bianconi@redhat.com

On 26/01/2022 13:27, Lorenzo Bianconi wrote:
>> On 24/01/2022 19:20, Lorenzo Bianconi wrote:
>>> Similar to bpf_xdp_ct_lookup routine, introduce
>>> br_fdb_find_port_from_ifindex unstable helper in order to accelerate
>>> linux bridge with XDP. br_fdb_find_port_from_ifindex will perform a
>>> lookup in the associated bridge fdb table and it will return the
>>> output ifindex if the destination address is associated to a bridge
>>> port or -ENODEV for BOM traffic or if lookup fails.
>>>
>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>> ---
>>>  net/bridge/br.c         | 21 +++++++++++++
>>>  net/bridge/br_fdb.c     | 67 +++++++++++++++++++++++++++++++++++------
>>>  net/bridge/br_private.h | 12 ++++++++
>>>  3 files changed, 91 insertions(+), 9 deletions(-)
>>>
>>
>> Hi Lorenzo,
> 
> Hi Nikolay,
> 
> thx for the review.
> 
>> Please CC bridge maintainers for bridge-related patches, I've added Roopa and the
>> bridge mailing list as well. Aside from that, the change is certainly interesting, I've been
>> thinking about a similar helper for some time now, few comments below.
> 
> yes, sorry for that. I figured it out after sending the series out.
> 
>>
>> Have you thought about the egress path and if by the current bridge state the packet would
>> be allowed to egress through the found port from the lookup? I'd guess you have to keep updating
>> the active ports list based on netlink events, but there's a lot of egress bridge logic that
>> either have to be duplicated or somehow synced. Check should_deliver() (br_forward.c) and later
>> egress stages, but I see how this is a good first step and perhaps we can build upon it.
>> There are a few possible solutions, but I haven't tried anything yet, most obvious being
>> yet another helper. :)
> 
> ack, right but I am bit worried about adding too much logic and slow down xdp
> performances. I guess we can investigate first the approach proposed by Alexei
> and then revaluate. Agree?
> 

Sure, that approach sounds very interesting, but my point was that bypassing the ingress
and egress logic defeats most of the bridge features. You just get an fdb hash table which
you can build today with ebpf without any changes to the kernel. :) You have multiple states,
flags and options for each port and each vlan which can change dynamically based on external
events (e.g. STP, config changes etc) and they can affect forwarding even if the fdbs remain
in the table.
One (untested, potential) way is to speedup full flows that have successfully passed from ingress to
egress for some period of time and flush them based on related events that might have affected
them, but that is very different. Another way would be to replicate some of that logic in ebpf
which would hit performance, and would probably also require more helpers. It would be interesting
to see how this problem would be solved.

>>
>>> diff --git a/net/bridge/br.c b/net/bridge/br.c
>>> index 1fac72cc617f..d2d1c2341d9c 100644
>>> --- a/net/bridge/br.c
>>> +++ b/net/bridge/br.c
>>> @@ -16,6 +16,8 @@
>>>  #include <net/llc.h>
>>>  #include <net/stp.h>
>>>  #include <net/switchdev.h>
>>> +#include <linux/btf.h>
>>> +#include <linux/btf_ids.h>
>>>  
>>>  #include "br_private.h"
>>>  
>>> @@ -365,6 +367,17 @@ static const struct stp_proto br_stp_proto = {
>>>  	.rcv	= br_stp_rcv,
>>>  };
>>>  
>>> +#if (IS_ENABLED(CONFIG_DEBUG_INFO_BTF) || IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
>>> +BTF_SET_START(br_xdp_fdb_check_kfunc_ids)
>>> +BTF_ID(func, br_fdb_find_port_from_ifindex)
>>> +BTF_SET_END(br_xdp_fdb_check_kfunc_ids)
>>> +
>>> +static const struct btf_kfunc_id_set br_xdp_fdb_kfunc_set = {
>>> +	.owner     = THIS_MODULE,
>>> +	.check_set = &br_xdp_fdb_check_kfunc_ids,
>>> +};
>>> +#endif
>>> +
>>>  static int __init br_init(void)
>>>  {
>>>  	int err;
>>> @@ -417,6 +430,14 @@ static int __init br_init(void)
>>>  		"need this.\n");
>>>  #endif
>>>  
>>> +#if (IS_ENABLED(CONFIG_DEBUG_INFO_BTF) || IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
>>> +	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &br_xdp_fdb_kfunc_set);
>>> +	if (err < 0) {
>>> +		br_netlink_fini();
>>> +		goto err_out6;
>>
>> Add err_out7 and handle it there please. Let's keep it consistent.
>> Also I cannot find register_btf_kfunc_id_set() in net-next or Linus' master, but
>> should it be paired with an unregister on unload (br_deinit) ?
> 
> I guess at the time I sent the series it was just in bpf-next but now it should
> be in net-next too.
> I do not think we need a unregister here.
> @Kumar: agree?
> 

Oh, my bad. I obviously should've looked at the bpf tree. :)

>>
>>> +	}
>>> +#endif
>>> +
>>>  	return 0;
>>>  
>>>  err_out6:
>>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>>> index 6ccda68bd473..cd3afa240298 100644
>>> --- a/net/bridge/br_fdb.c
>>> +++ b/net/bridge/br_fdb.c
>>> @@ -235,30 +235,79 @@ static struct net_bridge_fdb_entry *br_fdb_find(struct net_bridge *br,
>>>  	return fdb;
>>>  }
>>>  
>>> -struct net_device *br_fdb_find_port(const struct net_device *br_dev,
>>> -				    const unsigned char *addr,
>>> -				    __u16 vid)
>>> +static struct net_device *
>>> +__br_fdb_find_port(const struct net_device *br_dev,
>>> +		   const unsigned char *addr,
>>> +		   __u16 vid, bool ts_update)
>>>  {
>>>  	struct net_bridge_fdb_entry *f;
>>> -	struct net_device *dev = NULL;
>>>  	struct net_bridge *br;
>>>  
>>> -	ASSERT_RTNL();
>>> -
>>>  	if (!netif_is_bridge_master(br_dev))
>>>  		return NULL;
>>>  
>>>  	br = netdev_priv(br_dev);
>>> -	rcu_read_lock();
>>>  	f = br_fdb_find_rcu(br, addr, vid);
>>> -	if (f && f->dst)
>>> -		dev = f->dst->dev;
>>> +
>>> +	if (f && f->dst) {
>>> +		f->updated = jiffies;
>>> +		f->used = f->updated;
>>
>> This is wrong, f->updated should be set only if anything changed for the fdb.
>> Also you can optimize f->used a little bit if you check if jiffies != current value
>> before setting, you can have millions of packets per sec dirtying that cache line.
> 
> ack, right. I will fix it.
> 
>>
>> Aside from the above, it will change expected behaviour for br_fdb_find_port users
>> (mlxsw, added Ido to CC as well) because it will mark the fdb as active and refresh it
>> which should be done only for the ebpf helper, or might be exported through another helper
>> so ebpf users can decide if they want it updated. There are 2 different use cases and it is
>> not ok for both as we'll start refreshing fdbs that have been inactive for a while
>> and would've expired otherwise.
> 
> This is a bug actually. I forgot to check ts_update in the if condition,
> something like:
> 
> if (f && f->dst && ts_update) {
>  ...
>  }
> 
>>
>>> +		return f->dst->dev;
>>
>> This is wrong as well, f->dst can become NULL (fdb switched to point to the bridge itself).
>> You should make sure to read f->dst only once and work with the result. I know it's
>> been like that, but it was ok when accessed with rtnl held.
> 
> uhm, right. I will fix it.
> 
>>
>>> +	}
>>> +	return NULL;
>>> +}
>>> +
>>> +struct net_device *br_fdb_find_port(const struct net_device *br_dev,
>>> +				    const unsigned char *addr,
>>> +				    __u16 vid)
>>> +{
>>> +	struct net_device *dev;
>>> +
>>> +	ASSERT_RTNL();
>>> +
>>> +	rcu_read_lock();
>>> +	dev = __br_fdb_find_port(br_dev, addr, vid, false);
>>>  	rcu_read_unlock();
>>>  
>>>  	return dev;
>>>  }
>>>  EXPORT_SYMBOL_GPL(br_fdb_find_port);
>>>  
>>> +int br_fdb_find_port_from_ifindex(struct xdp_md *xdp_ctx,
>>> +				  struct bpf_fdb_lookup *opt,
>>> +				  u32 opt__sz)
>>> +{
>>> +	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
>>> +	struct net_bridge_port *port;
>>> +	struct net_device *dev;
>>> +	int ret = -ENODEV;
>>> +
>>> +	BUILD_BUG_ON(sizeof(struct bpf_fdb_lookup) != NF_BPF_FDB_OPTS_SZ);
>>> +	if (!opt || opt__sz != sizeof(struct bpf_fdb_lookup))
>>> +		return -ENODEV;
>>> +
>>> +	rcu_read_lock();
>>> +
>>> +	dev = dev_get_by_index_rcu(dev_net(ctx->rxq->dev), opt->ifindex);
>>> +	if (!dev)
>>> +		goto out;
>>> +
>>> +	if (unlikely(!netif_is_bridge_port(dev)))
>>> +		goto out;
>>
>> This check shouldn't be needed if the port checks below succeed.
> 
> ack, I will fix it.
> 
> Regards,
> Lorenzo
> 
>>
>>> +
>>> +	port = br_port_get_check_rcu(dev);
>>> +	if (unlikely(!port || !port->br))
>>> +		goto out;
>>> +
>>> +	dev = __br_fdb_find_port(port->br->dev, opt->addr, opt->vid, true);
>>> +	if (dev)
>>> +		ret = dev->ifindex;
>>> +out:
>>> +	rcu_read_unlock();
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>  struct net_bridge_fdb_entry *br_fdb_find_rcu(struct net_bridge *br,
>>>  					     const unsigned char *addr,
>>>  					     __u16 vid)
>>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>>> index 2661dda1a92b..64d4f1727da2 100644
>>> --- a/net/bridge/br_private.h
>>> +++ b/net/bridge/br_private.h
>>> @@ -18,6 +18,7 @@
>>>  #include <linux/if_vlan.h>
>>>  #include <linux/rhashtable.h>
>>>  #include <linux/refcount.h>
>>> +#include <linux/bpf.h>
>>>  
>>>  #define BR_HASH_BITS 8
>>>  #define BR_HASH_SIZE (1 << BR_HASH_BITS)
>>> @@ -2094,4 +2095,15 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
>>>  void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
>>>  		       u16 vid, struct net_bridge_port *p, struct nd_msg *msg);
>>>  struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb, struct nd_msg *m);
>>> +
>>> +#define NF_BPF_FDB_OPTS_SZ	12
>>> +struct bpf_fdb_lookup {
>>> +	u8	addr[ETH_ALEN]; /* ETH_ALEN */
>>> +	u16	vid;
>>> +	u32	ifindex;
>>> +};
>>> +
>>> +int br_fdb_find_port_from_ifindex(struct xdp_md *xdp_ctx,
>>> +				  struct bpf_fdb_lookup *opt,
>>> +				  u32 opt__sz);
>>>  #endif
>>
>> Thanks,
>>  Nik

