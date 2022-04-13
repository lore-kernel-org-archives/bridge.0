Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1649852424; x=
 1649938824; bh=zRtVpMslhEM9FCA8X5eI7aYkFrjVVyS1PZ9+HOH6SRM=; b=p
 JjxwG15BHkty0EjvKyb7p3j+jgCzeOvCl0wvHSuvw8mjPK9M4Y2CfWWbMnYL2Ijc
 33OLQbi02VgrnDfJu1Mu17vga4W4hECd7y7TLlqG5BDlWcFJ1mmasT0X8DoLLXbG
 LKA0Fws7GGPWbsi9YN2B7GYwzg8gDX291/RqpbotoVGW/QvYOj/PPq6sCYLRiFfl
 JjBhqseMD2s6LxzCMmTzUrJVPFX/iKooAOu3O5q9I/Me8S07sX7hvIFyi7zQXBmF
 /QzT6QOX+iFu33vALE0RJgA7MuSg2fvYfNN66nF0ygb9jgUQd9CXx/noaCHVoQEx
 vj6tJcn8/clf3X9/IKFTg==
Date: Wed, 13 Apr 2022 15:20:21 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YlbABWs3ICeeiKsq@shredder>
References: <20220413105202.2616106-1-razor@blackwall.org>
 <20220413105202.2616106-8-razor@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413105202.2616106-8-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next v4 07/12] net: rtnetlink: add
 NLM_F_BULK support to rtnl_fdb_del
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, bridge@lists.linux-foundation.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On Wed, Apr 13, 2022 at 01:51:57PM +0300, Nikolay Aleksandrov wrote:
> When NLM_F_BULK is specified in a fdb del message we need to handle it
> differently. First since this is a new call we can strictly validate the
> passed attributes, at first only ifindex and vlan are allowed as these
> will be the initially supported filter attributes, any other attribute
> is rejected. The mac address is no longer mandatory, but we use it
> to error out in older kernels because it cannot be specified with bulk
> request (the attribute is not allowed) and then we have to dispatch
> the call to ndo_fdb_del_bulk if the device supports it. The del bulk
> callback can do further validation of the attributes if necessary.
> 
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
> v4: mark PF_BRIDGE/RTM_DELNEIGH with RTNL_FLAG_BULK_DEL_SUPPORTED
> 
>  net/core/rtnetlink.c | 67 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 48 insertions(+), 19 deletions(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 63c7df52a667..520d50fcaaea 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -4169,22 +4169,34 @@ int ndo_dflt_fdb_del(struct ndmsg *ndm,
>  }
>  EXPORT_SYMBOL(ndo_dflt_fdb_del);
>  
> +static const struct nla_policy fdb_del_bulk_policy[NDA_MAX + 1] = {
> +	[NDA_VLAN]	= { .type = NLA_U16 },

In earlier versions br_vlan_valid_id() was used to validate the VLAN,
but I don't see it anymore. Maybe use 

NLA_POLICY_RANGE(1, VLAN_N_VID - 2)

?

I realize that invalid values won't do anything, but I think it's better
to only allow valid ranges.

> +	[NDA_IFINDEX]	= NLA_POLICY_MIN(NLA_S32, 1),
> +};
> +
>  static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
>  			struct netlink_ext_ack *extack)
>  {
> +	bool del_bulk = !!(nlh->nlmsg_flags & NLM_F_BULK);
>  	struct net *net = sock_net(skb->sk);
> +	const struct net_device_ops *ops;
>  	struct ndmsg *ndm;
>  	struct nlattr *tb[NDA_MAX+1];
>  	struct net_device *dev;
> -	__u8 *addr;
> +	__u8 *addr = NULL;
>  	int err;
>  	u16 vid;
>  
>  	if (!netlink_capable(skb, CAP_NET_ADMIN))
>  		return -EPERM;
>  
> -	err = nlmsg_parse_deprecated(nlh, sizeof(*ndm), tb, NDA_MAX, NULL,
> -				     extack);
> +	if (!del_bulk) {
> +		err = nlmsg_parse_deprecated(nlh, sizeof(*ndm), tb, NDA_MAX,
> +					     NULL, extack);
> +	} else {
> +		err = nlmsg_parse(nlh, sizeof(*ndm), tb, NDA_MAX,
> +				  fdb_del_bulk_policy, extack);
> +	}
>  	if (err < 0)
>  		return err;
>  
> @@ -4200,9 +4212,12 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
>  		return -ENODEV;
>  	}
>  
> -	if (!tb[NDA_LLADDR] || nla_len(tb[NDA_LLADDR]) != ETH_ALEN) {
> -		NL_SET_ERR_MSG(extack, "invalid address");
> -		return -EINVAL;
> +	if (!del_bulk) {
> +		if (!tb[NDA_LLADDR] || nla_len(tb[NDA_LLADDR]) != ETH_ALEN) {
> +			NL_SET_ERR_MSG(extack, "invalid address");
> +			return -EINVAL;
> +		}
> +		addr = nla_data(tb[NDA_LLADDR]);
>  	}
>  
>  	if (dev->type != ARPHRD_ETHER) {
> @@ -4210,8 +4225,6 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
>  		return -EINVAL;
>  	}
>  
> -	addr = nla_data(tb[NDA_LLADDR]);
> -
>  	err = fdb_vid_parse(tb[NDA_VLAN], &vid, extack);
>  	if (err)
>  		return err;
> @@ -4222,10 +4235,16 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	if ((!ndm->ndm_flags || ndm->ndm_flags & NTF_MASTER) &&
>  	    netif_is_bridge_port(dev)) {
>  		struct net_device *br_dev = netdev_master_upper_dev_get(dev);
> -		const struct net_device_ops *ops = br_dev->netdev_ops;
>  
> -		if (ops->ndo_fdb_del)
> -			err = ops->ndo_fdb_del(ndm, tb, dev, addr, vid);
> +		ops = br_dev->netdev_ops;
> +		if (!del_bulk) {
> +			if (ops->ndo_fdb_del)
> +				err = ops->ndo_fdb_del(ndm, tb, dev, addr, vid);
> +		} else {
> +			if (ops->ndo_fdb_del_bulk)
> +				err = ops->ndo_fdb_del_bulk(ndm, tb, dev, vid,
> +							    extack);
> +		}
>  
>  		if (err)
>  			goto out;
> @@ -4235,15 +4254,24 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
>  
>  	/* Embedded bridge, macvlan, and any other device support */
>  	if (ndm->ndm_flags & NTF_SELF) {
> -		if (dev->netdev_ops->ndo_fdb_del)
> -			err = dev->netdev_ops->ndo_fdb_del(ndm, tb, dev, addr,
> -							   vid);
> -		else
> -			err = ndo_dflt_fdb_del(ndm, tb, dev, addr, vid);
> +		ops = dev->netdev_ops;
> +		if (!del_bulk) {
> +			if (ops->ndo_fdb_del)
> +				err = ops->ndo_fdb_del(ndm, tb, dev, addr, vid);
> +			else
> +				err = ndo_dflt_fdb_del(ndm, tb, dev, addr, vid);
> +		} else {
> +			/* in case err was cleared by NTF_MASTER call */
> +			err = -EOPNOTSUPP;
> +			if (ops->ndo_fdb_del_bulk)
> +				err = ops->ndo_fdb_del_bulk(ndm, tb, dev, vid,
> +							    extack);
> +		}
>  
>  		if (!err) {
> -			rtnl_fdb_notify(dev, addr, vid, RTM_DELNEIGH,
> -					ndm->ndm_state);
> +			if (!del_bulk)
> +				rtnl_fdb_notify(dev, addr, vid, RTM_DELNEIGH,
> +						ndm->ndm_state);
>  			ndm->ndm_flags &= ~NTF_SELF;
>  		}
>  	}
> @@ -6145,7 +6173,8 @@ void __init rtnetlink_init(void)
>  	rtnl_register(PF_UNSPEC, RTM_DELLINKPROP, rtnl_dellinkprop, NULL, 0);
>  
>  	rtnl_register(PF_BRIDGE, RTM_NEWNEIGH, rtnl_fdb_add, NULL, 0);
> -	rtnl_register(PF_BRIDGE, RTM_DELNEIGH, rtnl_fdb_del, NULL, 0);
> +	rtnl_register(PF_BRIDGE, RTM_DELNEIGH, rtnl_fdb_del, NULL,
> +		      RTNL_FLAG_BULK_DEL_SUPPORTED);
>  	rtnl_register(PF_BRIDGE, RTM_GETNEIGH, rtnl_fdb_get, rtnl_fdb_dump, 0);
>  
>  	rtnl_register(PF_BRIDGE, RTM_GETLINK, NULL, rtnl_bridge_getlink, 0);
> -- 
> 2.35.1
> 
