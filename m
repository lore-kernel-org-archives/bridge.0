Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxngR24Xun8w7PYnV9RV909Yu9fnBY0je9+WfuAMWEY=;
 b=E7zmfQA2PKRZXXASn4OD1rLunWt8lZ44x21Prm03ipI50ZGlIGq/dsJpD3+jwKKqU11O82jp8SPv7isZ1yTOlP8A71vr4f3WJUX8OKs7Xx19bgyK/KqysD+OiaxyeylWOZQoPhQBxWN4vSsDt73EidMtS//MkCC8OlrtIa4jCVIHrBPy8wQSYrrgDWSpiUR/a/URlk8gdfsetmhKY5wz9lZMHCiWgmFCX4GOEZ8W0ubbAYk8HureY+soFXPz8aZjOuA3xl7dAKzTVedLY9dPVVGRmaD+lT7bDqpr1teh3IMjk+gOspyIlquxH2EcEJIKV2jdI7cW/tsKuQs7SIrQsA==
References: <20210426170411.1789186-1-tobias@waldekranz.com>
 <20210426170411.1789186-4-tobias@waldekranz.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <26e631b0-f5d0-343e-194d-c15b4a8dc7aa@nvidia.com>
Date: Tue, 27 Apr 2021 13:42:00 +0300
In-Reply-To: <20210426170411.1789186-4-tobias@waldekranz.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC net-next 3/9] net: bridge: switchdev: Recycle
	unused hwdoms
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net, kuba@kernel.org
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@idosch.org, roopa@nvidia.com, olteanv@gmail.com, vivien.didelot@gmail.com

On 26/04/2021 20:04, Tobias Waldekranz wrote:
> Since hwdoms has thus far only been used for equality comparisons, the
> bridge has used the simplest possible assignment policy; using a
> counter to keep track of the last value handed out.
> 
> With the upcoming transmit offloading, we need to perform set
> operations efficiently based on hwdoms, e.g. we want to answer
> questions like "has this skb been forwarded to any port within this
> hwdom?"
> 
> Move to a bitmap-based allocation scheme that recycles hwdoms once all
> members leaves the bridge. This means that we can use a single
> unsigned long to keep track of the hwdoms that have received an skb.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  net/bridge/br_if.c        |  4 +-
>  net/bridge/br_private.h   | 29 +++++++++---
>  net/bridge/br_switchdev.c | 94 ++++++++++++++++++++++++++-------------
>  3 files changed, 87 insertions(+), 40 deletions(-)
> 
> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index 73fa703f8df5..adaf78e45c23 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -349,6 +349,7 @@ static void del_nbp(struct net_bridge_port *p)
>  	nbp_backup_clear(p);
>  
>  	nbp_update_port_count(br);
> +	nbp_switchdev_del(p);
>  
>  	netdev_upper_dev_unlink(dev, br->dev);
>  
> @@ -643,7 +644,7 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
>  	if (err)
>  		goto err5;
>  
> -	err = nbp_switchdev_hwdom_set(p);
> +	err = nbp_switchdev_add(p);
>  	if (err)
>  		goto err6;
>  
> @@ -704,6 +705,7 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
>  	list_del_rcu(&p->list);
>  	br_fdb_delete_by_port(br, p, 0, 1);
>  	nbp_update_port_count(br);
> +	nbp_switchdev_del(p);
>  err6:
>  	netdev_upper_dev_unlink(dev, br->dev);
>  err5:
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 53248715f631..aba92864d285 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -29,6 +29,8 @@
>  
>  #define BR_MULTICAST_DEFAULT_HASH_MAX 4096
>  
> +#define BR_HWDOM_MAX BITS_PER_LONG
> +
>  #define BR_VERSION	"2.3"
>  
>  /* Control of forwarding link local multicast */
> @@ -54,6 +56,8 @@ typedef struct bridge_id bridge_id;
>  typedef struct mac_addr mac_addr;
>  typedef __u16 port_id;
>  
> +typedef DECLARE_BITMAP(br_hwdom_map_t, BR_HWDOM_MAX);
> +

You can avoid the typedef and DECLARE_BITMAP() and just use an
unsigned long below. In general avoiding new typedefs is a good thing. :)

>  struct bridge_id {
>  	unsigned char	prio[2];
>  	unsigned char	addr[ETH_ALEN];
> @@ -472,7 +476,7 @@ struct net_bridge {
>  	u32				auto_cnt;
>  
>  #ifdef CONFIG_NET_SWITCHDEV
> -	int last_hwdom;
> +	br_hwdom_map_t			busy_hwdoms;
>  #endif
>  	struct hlist_head		fdb_list;
>  
> @@ -1593,7 +1597,6 @@ static inline void br_sysfs_delbr(struct net_device *dev) { return; }
>  
>  /* br_switchdev.c */
>  #ifdef CONFIG_NET_SWITCHDEV
> -int nbp_switchdev_hwdom_set(struct net_bridge_port *p);
>  void nbp_switchdev_frame_mark(const struct net_bridge_port *p,
>  			      struct sk_buff *skb);
>  bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
> @@ -1607,17 +1610,15 @@ void br_switchdev_fdb_notify(const struct net_bridge_fdb_entry *fdb,
>  int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags,
>  			       struct netlink_ext_ack *extack);
>  int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid);
> +int nbp_switchdev_add(struct net_bridge_port *p);
> +void nbp_switchdev_del(struct net_bridge_port *p);
> +void br_switchdev_init(struct net_bridge *br);
>  
>  static inline void br_switchdev_frame_unmark(struct sk_buff *skb)
>  {
>  	skb->offload_fwd_mark = 0;
>  }
>  #else
> -static inline int nbp_switchdev_hwdom_set(struct net_bridge_port *p)
> -{
> -	return 0;
> -}
> -
>  static inline void nbp_switchdev_frame_mark(const struct net_bridge_port *p,
>  					    struct sk_buff *skb)
>  {
> @@ -1657,6 +1658,20 @@ br_switchdev_fdb_notify(const struct net_bridge_fdb_entry *fdb, int type)
>  static inline void br_switchdev_frame_unmark(struct sk_buff *skb)
>  {
>  }
> +
> +static inline int nbp_switchdev_add(struct net_bridge_port *p)
> +{
> +	return 0;
> +}
> +
> +static inline void nbp_switchdev_del(struct net_bridge_port *p)
> +{
> +}
> +
> +static inline void br_switchdev_init(struct net_bridge *br)
> +{
> +}
> +
>  #endif /* CONFIG_NET_SWITCHDEV */
>  
>  /* br_arp_nd_proxy.c */
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index bc085077ae71..54bd7205bfb5 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -8,38 +8,6 @@
>  
>  #include "br_private.h"
>  
> -static int br_switchdev_hwdom_get(struct net_bridge *br, struct net_device *dev)
> -{
> -	struct net_bridge_port *p;
> -
> -	/* dev is yet to be added to the port list. */
> -	list_for_each_entry(p, &br->port_list, list) {
> -		if (netdev_port_same_parent_id(dev, p->dev))
> -			return p->hwdom;
> -	}
> -
> -	return ++br->last_hwdom;
> -}
> -
> -int nbp_switchdev_hwdom_set(struct net_bridge_port *p)
> -{
> -	struct netdev_phys_item_id ppid = { };
> -	int err;
> -
> -	ASSERT_RTNL();
> -
> -	err = dev_get_port_parent_id(p->dev, &ppid, true);
> -	if (err) {
> -		if (err == -EOPNOTSUPP)
> -			return 0;
> -		return err;
> -	}
> -
> -	p->hwdom = br_switchdev_hwdom_get(p->br, p->dev);
> -
> -	return 0;
> -}
> -
>  void nbp_switchdev_frame_mark(const struct net_bridge_port *p,
>  			      struct sk_buff *skb)
>  {
> @@ -156,3 +124,65 @@ int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid)
>  
>  	return switchdev_port_obj_del(dev, &v.obj);
>  }
> +
> +static int nbp_switchdev_hwdom_set(struct net_bridge_port *joining)
> +{
> +	struct net_bridge *br = joining->br;
> +	struct net_bridge_port *p;
> +	int hwdom;
> +
> +	/* joining is yet to be added to the port list. */
> +	list_for_each_entry(p, &br->port_list, list) {
> +		if (netdev_port_same_parent_id(joining->dev, p->dev)) {
> +			joining->hwdom = p->hwdom;
> +			return 0;
> +		}
> +	}
> +
> +	hwdom = find_next_zero_bit(br->busy_hwdoms, BR_HWDOM_MAX, 1);
> +	if (hwdom >= BR_HWDOM_MAX)
> +		return -EBUSY;
> +
> +	set_bit(hwdom, br->busy_hwdoms);
> +	joining->hwdom = hwdom;
> +	return 0;
> +}
> +
> +static void nbp_switchdev_hwdom_put(struct net_bridge_port *leaving)
> +{
> +	struct net_bridge *br = leaving->br;
> +	struct net_bridge_port *p;
> +
> +	/* leaving is no longer in the port list. */
> +	list_for_each_entry(p, &br->port_list, list) {
> +		if (p->hwdom == leaving->hwdom)
> +			return;
> +	}
> +
> +	clear_bit(leaving->hwdom, br->busy_hwdoms);
> +}
> +
> +int nbp_switchdev_add(struct net_bridge_port *p)
> +{
> +	struct netdev_phys_item_id ppid = { };
> +	int err;
> +
> +	ASSERT_RTNL();
> +
> +	err = dev_get_port_parent_id(p->dev, &ppid, true);
> +	if (err) {
> +		if (err == -EOPNOTSUPP)
> +			return 0;
> +		return err;
> +	}
> +
> +	return nbp_switchdev_hwdom_set(p);
> +}
> +
> +void nbp_switchdev_del(struct net_bridge_port *p)
> +{
> +	ASSERT_RTNL();
> +
> +	if (p->hwdom)
> +		nbp_switchdev_hwdom_put(p);
> +}
> 

