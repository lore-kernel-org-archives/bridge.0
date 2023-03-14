Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 360BB6080A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F9D360742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112; t=1678794115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rjlDp8/x86m0U9/yRYrRz5qP8F6BLrKqt+GnbXWpvvs=;
 b=yZjWeLZUuHe0uTj6f6sCkvlOZ0FPf6xndFi7lz65TugOvuKB0mpMEVEZvSdzvLFxcn
 pUIs5j9eRnh7U1sKYqKWfOZeq2P41SERtY4tC/PA3k/RZNFOoaVYMwxHx3dGCJBVmOwm
 5qeAm567+QUgx9LxWgnqdPMCQw5hduuuj8rAzRW7RXIczY6JCFA2OHQB7mWmlLhOcDgC
 o2uAVeOpvi/xHhM/nOluL2yy+3u04jaoKAz1zryGYCywXlCJLF/QQlZbA7S+MNQUI3J9
 2mNo2f67hqLD1txbdZk+VA5uhOXHIh6XYx1NjiTJbr2nhAlDq920cqxy3kDHJZT6d9XK
 8Nnw==
Message-ID: <36d6a40a-8f5a-3152-a694-d15bdb3578b4@blackwall.org>
Date: Tue, 14 Mar 2023 13:41:53 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230313145349.3557231-1-idosch@nvidia.com>
 <20230313145349.3557231-2-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230313145349.3557231-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 01/11] net: Add MDB net device
	operations
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 13/03/2023 16:53, Ido Schimmel wrote:
> Add MDB net device operations that will be invoked by rtnetlink code in
> response to received RTM_{NEW,DEL,GET}MDB messages. Subsequent patches
> will implement these operations in the bridge and VXLAN drivers.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  include/linux/netdevice.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index ee483071cf59..23b0d7eaaadd 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1307,6 +1307,17 @@ struct netdev_net_notifier {
>   *	Used to add FDB entries to dump requests. Implementers should add
>   *	entries to skb and update idx with the number of entries.
>   *
> + * int (*ndo_mdb_add)(struct net_device *dev, struct nlattr *tb[],
> + *		      u16 nlmsg_flags, struct netlink_ext_ack *extack);
> + *	Adds an MDB entry to dev.
> + * int (*ndo_mdb_del)(struct net_device *dev, struct nlattr *tb[],
> + *		      struct netlink_ext_ack *extack);
> + *	Deletes the MDB entry from dev.
> + * int (*ndo_mdb_dump)(struct net_device *dev, struct sk_buff *skb,
> + *		       struct netlink_callback *cb);
> + *	Dumps MDB entries from dev. The first argument (marker) in the netlink
> + *	callback is used by core rtnetlink code.
> + *
>   * int (*ndo_bridge_setlink)(struct net_device *dev, struct nlmsghdr *nlh,
>   *			     u16 flags, struct netlink_ext_ack *extack)
>   * int (*ndo_bridge_getlink)(struct sk_buff *skb, u32 pid, u32 seq,
> @@ -1569,6 +1580,16 @@ struct net_device_ops {
>  					       const unsigned char *addr,
>  					       u16 vid, u32 portid, u32 seq,
>  					       struct netlink_ext_ack *extack);
> +	int			(*ndo_mdb_add)(struct net_device *dev,
> +					       struct nlattr *tb[],
> +					       u16 nlmsg_flags,
> +					       struct netlink_ext_ack *extack);
> +	int			(*ndo_mdb_del)(struct net_device *dev,
> +					       struct nlattr *tb[],
> +					       struct netlink_ext_ack *extack);
> +	int			(*ndo_mdb_dump)(struct net_device *dev,
> +						struct sk_buff *skb,
> +						struct netlink_callback *cb);
>  	int			(*ndo_bridge_setlink)(struct net_device *dev,
>  						      struct nlmsghdr *nlh,
>  						      u16 flags,

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

