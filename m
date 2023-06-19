Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E676841028
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5063A40C1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHQRAfrOs8cAqcloifhRR4ZwCmIWn3ddM4tCJBqgv0U=;
 b=si6uWvDp7Baxk0/T0qL8l+wqebMOkGbToI9yPeRvuC3iSmWBi6qDiMx7erUuz6SgkOBuXST1WKJUDHzZyQehYKvPufugd5PTmTDZXSNM4874FyVsgdyuDAb/dP+I/wXbx7u2RhGY3s0gkj91J6PuRT1NpYe703IWKJsoEgUIhxxco2Q9G/GWzP+Sf6lIOTVO5u/uGBQxA1oIap1P/E642ox6ltZp30LW1KCiOpzlrd7fjCvY73h5OGFShvBLCPg6HMOClb8vRLlKnIr4n+CuqDRyCzzD/3po8yjO1vuQHhMVkj0XrF0x2wACjGS5ZU2BjC1O575LibE329yYMGagcg==
Date: Mon, 19 Jun 2023 18:34:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZJB1j0Vk4g0yW3dc@shredder>
References: <20230619071444.14625-1-jnixdorf-oss@avm.de>
 <20230619071444.14625-3-jnixdorf-oss@avm.de>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230619071444.14625-3-jnixdorf-oss@avm.de>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v2 2/3] bridge: Add a limit on learned
 FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc: Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, Oleksij Rempel <linux@rempel-privat.de>, Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Mon, Jun 19, 2023 at 09:14:42AM +0200, Johannes Nixdorf wrote:
> A malicious actor behind one bridge port may spam the kernel with packets
> with a random source MAC address, each of which will create an FDB entry,
> each of which is a dynamic allocation in the kernel.
> 
> There are roughly 2^48 different MAC addresses, further limited by the
> rhashtable they are stored in to 2^31. Each entry is of the type struct
> net_bridge_fdb_entry, which is currently 128 bytes big. This means the
> maximum amount of memory allocated for FDB entries is 2^31 * 128B =
> 256GiB, which is too much for most computers.
> 
> Mitigate this by adding a bridge netlink setting
> IFLA_BR_FDB_MAX_LEARNED_ENTRIES, which, if nonzero, limits the amount
> of learned entries to a user specified maximum.
> 
> For backwards compatibility the default setting of 0 disables the limit.
> 
> User-added entries by netlink or from bridge or bridge port addresses
> are never blocked and do not count towards that limit.
> 
> All changes to fdb_n_entries are under br->hash_lock, which means we do
> not need additional locking. The call paths are (✓ denotes that
> br->hash_lock is taken around the next call):
> 
>  - fdb_delete <-+- fdb_delete_local <-+- br_fdb_changeaddr ✓
>                 |                     +- br_fdb_change_mac_address ✓
>                 |                     +- br_fdb_delete_by_port ✓
>                 +- br_fdb_find_delete_local ✓
>                 +- fdb_add_local <-+- br_fdb_changeaddr ✓
>                 |                  +- br_fdb_change_mac_address ✓
>                 |                  +- br_fdb_add_local ✓
>                 +- br_fdb_cleanup ✓
>                 +- br_fdb_flush ✓
>                 +- br_fdb_delete_by_port ✓
>                 +- fdb_delete_by_addr_and_port <--- __br_fdb_delete ✓
>                 +- br_fdb_external_learn_del ✓
>  - fdb_create <-+- fdb_add_local <-+- br_fdb_changeaddr ✓
>                 |                  +- br_fdb_change_mac_address ✓
>                 |                  +- br_fdb_add_local ✓
>                 +- br_fdb_update ✓
>                 +- fdb_add_entry <--- __br_fdb_add ✓
>                 +- br_fdb_external_learn_add ✓
> 
> The flags that imply an entry does not come from learning
> (BR_FDB_NOT_LEARNED_MASK) are now only set or cleared under br->hash_lock
> as well, and when the boolean value of (fdb->flags &
> BR_FDB_NOT_LEARNED_MASK) changes the accounting is updated.
> 
> This introduces one additional locked update in br_fdb_update if
> BR_FDB_ADDED_BY_USER was set. This is only the case when creating a new
> entry via netlink, and never in the packet handling fast path.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> 
> ---
> 
> Changes since v1:
>  - Do not initialize fdb_*_entries to 0. (from review)
>  - Do not skip decrementing on 0. (from review)
>  - Moved the counters to a conditional hole in struct net_bridge to
>    avoid growing the struct. (from review, it still grows the struct as
>    there are 2 32-bit values)
>  - Add IFLA_BR_FDB_CUR_LEARNED_ENTRIES (from review)
>  - Fix br_get_size()
>  - Only limit learned entries, rename to
>    *_(CUR|MAX)_LEARNED_ENTRIES. (from review)
> 
> Obsolete v1 review comments:
>  - Return better errors to users: Due to limiting the limit to
>    automatically created entries, netlink fdb add requests and changing
>    bridge ports are never rejected, so they do not yet need a more
>    friendly error returned.
> 
>  include/uapi/linux/if_link.h |  2 ++
>  net/bridge/br_fdb.c          | 67 +++++++++++++++++++++++++++++++++---
>  net/bridge/br_netlink.c      | 13 ++++++-
>  net/bridge/br_private.h      |  6 ++++

To minimize the number of changes per patch and make review easier, try
to first maintain the count and the maximum and then in a separate patch
expose them via netlink. See b57e8d870d52 and a1aee20d5db2, for example.
Merge commit is cb3086cee656.

>  4 files changed, 83 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 4ac1000b0ef2..165b9014379b 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -510,6 +510,8 @@ enum {
>  	IFLA_BR_VLAN_STATS_PER_PORT,
>  	IFLA_BR_MULTI_BOOLOPT,
>  	IFLA_BR_MCAST_QUERIER_STATE,
> +	IFLA_BR_FDB_CUR_LEARNED_ENTRIES,
> +	IFLA_BR_FDB_MAX_LEARNED_ENTRIES,
>  	__IFLA_BR_MAX,
>  };
>  
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index ac1dc8723b9c..bc61d1fd5fcf 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -301,6 +301,38 @@ static void fdb_add_hw_addr(struct net_bridge *br, const unsigned char *addr)
>  	}
>  }
>  
> +/* Set a FDB flag that implies the entry was not learned, and account
> + * for changes in the learned status.
> + */
> +static void __fdb_set_flag_not_learned(struct net_bridge *br,
> +				       struct net_bridge_fdb_entry *fdb,
> +				       long nr)
> +{
> +	WARN_ON_ONCE(!(BIT(nr) & BR_FDB_NOT_LEARNED_MASK));
> +
> +	/* learned before, but we set a flag that implies it's manually added */
> +	if (!(fdb->flags & BR_FDB_NOT_LEARNED_MASK))
> +		br->fdb_cur_learned_entries--;
> +	set_bit(nr, &fdb->flags);
> +}
> +
> +/* Set a FDB flag that implies the entry was not learned, and account
> + * for changes in the learned status.
> + *
> + * This function takes a lock, so ensure it is not called in the fast
> + * path.
> + */
> +static void fdb_set_flag_not_learned(struct net_bridge *br,
> +				     struct net_bridge_fdb_entry *fdb,
> +				     long nr)
> +{
> +	spin_lock_bh(&br->hash_lock);
> +
> +	__fdb_set_flag_not_learned(br, fdb, nr);
> +
> +	spin_unlock_bh(&br->hash_lock);
> +}
> +
>  /* When a static FDB entry is deleted, the HW address from that entry is
>   * also removed from the bridge private HW address list and updates all
>   * the ports with needed information.
> @@ -321,6 +353,8 @@ static void fdb_del_hw_addr(struct net_bridge *br, const unsigned char *addr)
>  static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f,
>  		       bool swdev_notify)
>  {
> +	bool learned = !(f->flags & BR_FDB_NOT_LEARNED_MASK);
> +
>  	trace_fdb_delete(br, f);
>  
>  	if (test_bit(BR_FDB_STATIC, &f->flags))
> @@ -329,11 +363,16 @@ static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f,
>  	hlist_del_init_rcu(&f->fdb_node);
>  	rhashtable_remove_fast(&br->fdb_hash_tbl, &f->rhnode,
>  			       br_fdb_rht_params);
> +	br->fdb_cur_learned_entries -= learned;
>  	fdb_notify(br, f, RTM_DELNEIGH, swdev_notify);
>  	call_rcu(&f->rcu, fdb_rcu_free);
>  }
>  
> -/* Delete a local entry if no other port had the same address. */
> +/* Delete a local entry if no other port had the same address.
> + *
> + * This function should only be called on entries with BR_FDB_LOCAL set,
> + * so clear_bit never removes the last bit in BR_FDB_NOT_LEARNED_MASK.
> + */
>  static void fdb_delete_local(struct net_bridge *br,
>  			     const struct net_bridge_port *p,
>  			     struct net_bridge_fdb_entry *f)
> @@ -390,6 +429,11 @@ static struct net_bridge_fdb_entry *fdb_create(struct net_bridge *br,
>  {
>  	struct net_bridge_fdb_entry *fdb;
>  	int err;
> +	bool learned = !(flags & BR_FDB_NOT_LEARNED_MASK);

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

> +
> +	if (unlikely(learned && br->fdb_max_learned_entries &&
> +		     br->fdb_cur_learned_entries >= br->fdb_max_learned_entries))

This function is not run with RTNL held and so 'fdb_max_learned_entries'
can be updated concurrently from user space. You will need READ_ONCE() /
WRITE_ONCE() to silence KCSAN.

> +		return NULL;
>  
>  	fdb = kmem_cache_alloc(br_fdb_cache, GFP_ATOMIC);
>  	if (!fdb)
> @@ -409,6 +453,8 @@ static struct net_bridge_fdb_entry *fdb_create(struct net_bridge *br,
>  
>  	hlist_add_head_rcu(&fdb->fdb_node, &br->fdb_list);
>  
> +	br->fdb_cur_learned_entries += learned;

Don't remember seeing bool being added to a u32...

> +
>  	return fdb;
>  }
>  
> @@ -894,7 +940,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
>  			}
>  
>  			if (unlikely(test_bit(BR_FDB_ADDED_BY_USER, &flags)))
> -				set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
> +				fdb_set_flag_not_learned(br, fdb, BR_FDB_ADDED_BY_USER);
>  			if (unlikely(fdb_modified)) {
>  				trace_br_fdb_update(br, source, addr, vid, flags);
>  				fdb_notify(br, fdb, RTM_NEWNEIGH, true);
> @@ -1070,6 +1116,8 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>  			modified = true;
>  		}
>  
> +		if (!(fdb->flags & BR_FDB_NOT_LEARNED_MASK))
> +			br->fdb_cur_learned_entries--;
>  		set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
>  	}
>  
> @@ -1440,10 +1488,10 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>  		}
>  
>  		if (swdev_notify)
> -			set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
> +			__fdb_set_flag_not_learned(br, fdb, BR_FDB_ADDED_BY_USER);
>  
>  		if (!p)
> -			set_bit(BR_FDB_LOCAL, &fdb->flags);
> +			__fdb_set_flag_not_learned(br, fdb, BR_FDB_LOCAL);
>  
>  		if (modified)
>  			fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
> @@ -1508,3 +1556,14 @@ void br_fdb_clear_offload(const struct net_device *dev, u16 vid)
>  	spin_unlock_bh(&p->br->hash_lock);
>  }
>  EXPORT_SYMBOL_GPL(br_fdb_clear_offload);
> +
> +u32 br_fdb_get_cur_learned_entries(struct net_bridge *br)
> +{
> +	u32 ret;
> +
> +	spin_lock_bh(&br->hash_lock);
> +	ret = br->fdb_cur_learned_entries;

I believe that for MDB Nik asked not to take a spin lock for each dump
and we used READ_ONCE() / WRITE_ONCE() instead.

> +	spin_unlock_bh(&br->hash_lock);
> +
> +	return ret;
> +}
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 05c5863d2e20..954c468d52ec 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -1527,6 +1527,12 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
>  			return err;
>  	}
>  
> +	if (data[IFLA_BR_FDB_MAX_LEARNED_ENTRIES]) {

Please add this attribute to 'br_policy' and in a separate patch convert
the policy to use 'strict_start_type' so that future submissions will be
forced to update the policy. See c00041cf1cb82 for example.

I suggest writing a selftest to verify the expected behavior and to make
sure this feature does not regress. There are a lot of examples under
tools/testing/selftests/net/ and tools/testing/selftests/net/forwarding
in particular. You can post another version before writing a test, but
mark it as RFC so that it doesn't get applied by mistake.

Thanks

> +		u32 val = nla_get_u32(data[IFLA_BR_FDB_MAX_LEARNED_ENTRIES]);
> +
> +		br->fdb_max_learned_entries = val;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1581,6 +1587,8 @@ static size_t br_get_size(const struct net_device *brdev)
>  	       nla_total_size_64bit(sizeof(u64)) + /* IFLA_BR_TOPOLOGY_CHANGE_TIMER */
>  	       nla_total_size_64bit(sizeof(u64)) + /* IFLA_BR_GC_TIMER */
>  	       nla_total_size(ETH_ALEN) +       /* IFLA_BR_GROUP_ADDR */
> +	       nla_total_size(sizeof(u32)) +    /* IFLA_BR_FDB_CUR_LEARNED_ENTRIES */
> +	       nla_total_size(sizeof(u32)) +    /* IFLA_BR_FDB_MAX_LEARNED_ENTRIES */
>  #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
>  	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_MCAST_ROUTER */
>  	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_MCAST_SNOOPING */
> @@ -1620,6 +1628,7 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
>  	u32 stp_enabled = br->stp_enabled;
>  	u16 priority = (br->bridge_id.prio[0] << 8) | br->bridge_id.prio[1];
>  	u8 vlan_enabled = br_vlan_enabled(br->dev);
> +	u32 fdb_cur_learned_entries = br_fdb_get_cur_learned_entries(br);
>  	struct br_boolopt_multi bm;
>  	u64 clockval;
>  
> @@ -1656,7 +1665,9 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
>  	    nla_put_u8(skb, IFLA_BR_TOPOLOGY_CHANGE_DETECTED,
>  		       br->topology_change_detected) ||
>  	    nla_put(skb, IFLA_BR_GROUP_ADDR, ETH_ALEN, br->group_addr) ||
> -	    nla_put(skb, IFLA_BR_MULTI_BOOLOPT, sizeof(bm), &bm))
> +	    nla_put(skb, IFLA_BR_MULTI_BOOLOPT, sizeof(bm), &bm) ||
> +	    nla_put_u32(skb, IFLA_BR_FDB_CUR_LEARNED_ENTRIES, fdb_cur_learned_entries) ||
> +	    nla_put_u32(skb, IFLA_BR_FDB_MAX_LEARNED_ENTRIES, br->fdb_max_learned_entries))
>  		return -EMSGSIZE;
>  
>  #ifdef CONFIG_BRIDGE_VLAN_FILTERING
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 2119729ded2b..df079191479e 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -275,6 +275,8 @@ enum {
>  	BR_FDB_LOCKED,
>  };
>  
> +#define BR_FDB_NOT_LEARNED_MASK (BIT(BR_FDB_LOCAL) | BIT(BR_FDB_ADDED_BY_USER))
> +
>  struct net_bridge_fdb_key {
>  	mac_addr addr;
>  	u16 vlan_id;
> @@ -553,6 +555,9 @@ struct net_bridge {
>  	struct kobject			*ifobj;
>  	u32				auto_cnt;
>  
> +	u32				fdb_max_learned_entries;
> +	u32				fdb_cur_learned_entries;
> +
>  #ifdef CONFIG_NET_SWITCHDEV
>  	/* Counter used to make sure that hardware domains get unique
>  	 * identifiers in case a bridge spans multiple switchdev instances.
> @@ -838,6 +843,7 @@ int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
>  			      bool swdev_notify);
>  void br_fdb_offloaded_set(struct net_bridge *br, struct net_bridge_port *p,
>  			  const unsigned char *addr, u16 vid, bool offloaded);
> +u32 br_fdb_get_cur_learned_entries(struct net_bridge *br);
>  
>  /* br_forward.c */
>  enum br_pkt_type {
> -- 
> 2.40.1
> 
