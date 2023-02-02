Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EEE4341825
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2641A41817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r0tSrbPo0mppNixGy3bcD3zoxtBfRCRHseQF+MrvYe0=;
 b=IlMCCSTh99qXjItVVqavOesUQAsEFyALPVE6zB+AK8ajU6ZKGhbIWHiMOAIL8ZVGB/
 wa6tcEgh8Ki+fQM7a2L3+h8YhMY6i/q1BbxCL71Aa/4UeFtQWZafOx+AoCQ3uPN/hYh7
 Kpo2vRuG5Od9PBnl4IfPZTyTGmhzkmqTPfxZfZK15flncA4ZKOEo2yw6WfH1SkdVvob2
 ycGYq0BWVfFkBYdHIQjnTHtcBCLD2GHN70K1+iBfMGtkWFC6mzDBT60K+cXJNdEWU5lV
 gjCOijow/ztU+e0yb7aBbANwyC1l6WijPI8g667Jy7ImwgeZIL0J0toFo5pIxyQTbNhY
 K5Qw==
Message-ID: <14fac71d-dc43-bc5c-4d77-3187e066cfc0@blackwall.org>
Date: Thu, 2 Feb 2023 11:02:40 +0200
MIME-Version: 1.0
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
References: <cover.1675271084.git.petrm@nvidia.com>
 <7b9f6524716a9e2ce33b9383e3216fed2f432201.1675271084.git.petrm@nvidia.com>
 <4ce2042b-26f7-00df-a035-567475add7f6@blackwall.org>
In-Reply-To: <4ce2042b-26f7-00df-a035-567475add7f6@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next mlxsw v2 08/16] net: bridge: Add
 netlink knobs for number / maximum MDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org

On 02/02/2023 10:52, Nikolay Aleksandrov wrote:
> On 01/02/2023 19:28, Petr Machata wrote:
>> The previous patch added accounting for number of MDB entries per port and
>> per port-VLAN, and the logic to verify that these values stay within
>> configured bounds. However it didn't provide means to actually configure
>> those bounds or read the occupancy. This patch does that.
>>
>> Two new netlink attributes are added for the MDB occupancy:
>> IFLA_BRPORT_MCAST_N_GROUPS for the per-port occupancy and
>> BRIDGE_VLANDB_ENTRY_MCAST_N_GROUPS for the per-port-VLAN occupancy.
>> And another two for the maximum number of MDB entries:
>> IFLA_BRPORT_MCAST_MAX_GROUPS for the per-port maximum, and
>> BRIDGE_VLANDB_ENTRY_MCAST_MAX_GROUPS for the per-port-VLAN one.
>>
>> Note that the two new IFLA_BRPORT_ attributes prompt bumping of
>> RTNL_SLAVE_MAX_TYPE to size the slave attribute tables large enough.
>>
>> The new attributes are used like this:
>>
>>  # ip link add name br up type bridge vlan_filtering 1 mcast_snooping 1 \
>>                                       mcast_vlan_snooping 1 mcast_querier 1
>>  # ip link set dev v1 master br
>>  # bridge vlan add dev v1 vid 2
>>
>>  # bridge vlan set dev v1 vid 1 mcast_max_groups 1
>>  # bridge mdb add dev br port v1 grp 230.1.2.3 temp vid 1
>>  # bridge mdb add dev br port v1 grp 230.1.2.4 temp vid 1
>>  Error: bridge: Port-VLAN is already a member in mcast_max_groups (1) groups.
>>
>>  # bridge link set dev v1 mcast_max_groups 1
>>  # bridge mdb add dev br port v1 grp 230.1.2.3 temp vid 2
>>  Error: bridge: Port is already a member in mcast_max_groups (1) groups.
>>
>>  # bridge -d link show
>>  5: v1@v2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br [...]
>>      [...] mcast_n_groups 1 mcast_max_groups 1
>>
>>  # bridge -d vlan show
>>  port              vlan-id
>>  br                1 PVID Egress Untagged
>>                      state forwarding mcast_router 1
>>  v1                1 PVID Egress Untagged
>>                      [...] mcast_n_groups 1 mcast_max_groups 1
>>                    2
>>                      [...] mcast_n_groups 0 mcast_max_groups 0
>>
>> Signed-off-by: Petr Machata <petrm@nvidia.com>
>> ---
>>
>> Notes:
>>     v2:
>>     - Drop locks around accesses in
>>       br_multicast_{port,vlan}_ngroups_{get,set_max}(),
>>     - Drop bounces due to max<n in
>>       br_multicast_{port,vlan}_ngroups_set_max().
>>
>>  include/uapi/linux/if_bridge.h |  2 ++
>>  include/uapi/linux/if_link.h   |  2 ++
>>  net/bridge/br_multicast.c      | 50 ++++++++++++++++++++++++++++++++++
>>  net/bridge/br_netlink.c        | 17 +++++++++++-
>>  net/bridge/br_private.h        | 15 +++++++++-
>>  net/bridge/br_vlan.c           | 11 +++++---
>>  net/bridge/br_vlan_options.c   | 33 +++++++++++++++++++++-
>>  net/core/rtnetlink.c           |  2 +-
>>  8 files changed, 124 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
>> index d9de241d90f9..d60c456710b3 100644
>> --- a/include/uapi/linux/if_bridge.h
>> +++ b/include/uapi/linux/if_bridge.h
>> @@ -523,6 +523,8 @@ enum {
>>  	BRIDGE_VLANDB_ENTRY_TUNNEL_INFO,
>>  	BRIDGE_VLANDB_ENTRY_STATS,
>>  	BRIDGE_VLANDB_ENTRY_MCAST_ROUTER,
>> +	BRIDGE_VLANDB_ENTRY_MCAST_N_GROUPS,
>> +	BRIDGE_VLANDB_ENTRY_MCAST_MAX_GROUPS,
>>  	__BRIDGE_VLANDB_ENTRY_MAX,
>>  };
>>  #define BRIDGE_VLANDB_ENTRY_MAX (__BRIDGE_VLANDB_ENTRY_MAX - 1)
>> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
>> index 1021a7e47a86..1bed3a72939c 100644
>> --- a/include/uapi/linux/if_link.h
>> +++ b/include/uapi/linux/if_link.h
>> @@ -564,6 +564,8 @@ enum {
>>  	IFLA_BRPORT_MCAST_EHT_HOSTS_CNT,
>>  	IFLA_BRPORT_LOCKED,
>>  	IFLA_BRPORT_MAB,
>> +	IFLA_BRPORT_MCAST_N_GROUPS,
>> +	IFLA_BRPORT_MCAST_MAX_GROUPS,
>>  	__IFLA_BRPORT_MAX
>>  };
>>  #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
>> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
>> index e7ae339a8757..393ffc21c3e8 100644
>> --- a/net/bridge/br_multicast.c
>> +++ b/net/bridge/br_multicast.c
>> @@ -768,6 +768,56 @@ static void br_multicast_port_ngroups_dec(struct net_bridge_port *port, u16 vid)
>>  	br_multicast_port_ngroups_dec_one(&port->multicast_ctx);
>>  }
>>  
>> +u32 br_multicast_port_ngroups_get(const struct net_bridge_port *port)
>> +{
>> +	return READ_ONCE(port->multicast_ctx.mdb_n_entries);
>> +}
>> +
>> +int br_multicast_vlan_ngroups_get(struct net_bridge *br,
>> +				  const struct net_bridge_vlan *v,
>> +				  u32 *n)
>> +{
>> +	if (br_multicast_port_ctx_vlan_disabled(&v->port_mcast_ctx))
>> +		return -EINVAL;
> 
> This check seems unnecessary since the helper is used only if !br_multicast_port_ctx_vlan_disabled()
> below.
> 
>> +
>> +	*n = READ_ONCE(v->port_mcast_ctx.mdb_n_entries);
>> +	return 0;
>> +}
>> +
>> +void br_multicast_port_ngroups_set_max(struct net_bridge_port *port, u32 max)
>> +{
>> +	WRITE_ONCE(port->multicast_ctx.mdb_max_entries, max);
>> +}
>> +
>> +int br_multicast_vlan_ngroups_set_max(struct net_bridge *br,
>> +				      struct net_bridge_vlan *v, u32 max,
>> +				      struct netlink_ext_ack *extack)
>> +{
>> +	if (br_multicast_port_ctx_vlan_disabled(&v->port_mcast_ctx)) {
>> +		NL_SET_ERR_MSG_MOD(extack, "Multicast snooping disabled on this VLAN");
>> +		return -EINVAL;
>> +	}
> 
> same comment about the check

Ok, not exactly the same. I see that for the max case this check is used, please pull it
in the vlan code and just drop this helper. Both read/write will be doing the same then.

> 
>> +
>> +	WRITE_ONCE(v->port_mcast_ctx.mdb_max_entries, max);
>> +	return 0;
>> +}
>> +
>> +u32 br_multicast_port_ngroups_get_max(const struct net_bridge_port *port)
>> +{
>> +	return READ_ONCE(port->multicast_ctx.mdb_max_entries);
>> +}
>> +
>> +int br_multicast_vlan_ngroups_get_max(struct net_bridge *br,
>> +				      const struct net_bridge_vlan *v,
>> +				      u32 *max)
>> +{
>> +	if (br_multicast_port_ctx_vlan_disabled(&v->port_mcast_ctx))
>> +		return -EINVAL;
>> +
>> +	*max = READ_ONCE(v->port_mcast_ctx.mdb_max_entries);
>> +	return 0;
>> +}
> 
> So I don't think we need special flavours for vlan and port, the point of using common
> port_mcast_ctx for both was to unify the code as much as possible. If the reason was
> to add that check then we already have it below before calling that code, no?
> Could we instead add one helper for each action that takes pmctx pointers and works on them?
> 
> Thanks,
>  Nik
> 
>> +
>>  static void br_multicast_destroy_port_group(struct net_bridge_mcast_gc *gc)
>>  {
>>  	struct net_bridge_port_group *pg;
>> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
>> index a6133d469885..968d0963d9a9 100644
>> --- a/net/bridge/br_netlink.c
>> +++ b/net/bridge/br_netlink.c
>> @@ -202,6 +202,8 @@ static inline size_t br_port_info_size(void)
>>  		+ nla_total_size_64bit(sizeof(u64)) /* IFLA_BRPORT_HOLD_TIMER */
>>  #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
>>  		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_MULTICAST_ROUTER */
>> +		+ nla_total_size(sizeof(u32))	/* IFLA_BRPORT_MCAST_N_GROUPS */
>> +		+ nla_total_size(sizeof(u32))	/* IFLA_BRPORT_MCAST_MAX_GROUPS */
>>  #endif
>>  		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_GROUP_FWD_MASK */
>>  		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_MRP_RING_OPEN */
>> @@ -298,7 +300,11 @@ static int br_port_fill_attrs(struct sk_buff *skb,
>>  	    nla_put_u32(skb, IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT,
>>  			p->multicast_eht_hosts_limit) ||
>>  	    nla_put_u32(skb, IFLA_BRPORT_MCAST_EHT_HOSTS_CNT,
>> -			p->multicast_eht_hosts_cnt))
>> +			p->multicast_eht_hosts_cnt) ||
>> +	    nla_put_u32(skb, IFLA_BRPORT_MCAST_N_GROUPS,
>> +			br_multicast_port_ngroups_get(p)) ||
>> +	    nla_put_u32(skb, IFLA_BRPORT_MCAST_MAX_GROUPS,
>> +			br_multicast_port_ngroups_get_max(p)))
>>  		return -EMSGSIZE;
>>  #endif
>>  
>> @@ -883,6 +889,8 @@ static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
>>  	[IFLA_BRPORT_MAB] = { .type = NLA_U8 },
>>  	[IFLA_BRPORT_BACKUP_PORT] = { .type = NLA_U32 },
>>  	[IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT] = { .type = NLA_U32 },
>> +	[IFLA_BRPORT_MCAST_N_GROUPS] = { .type = NLA_REJECT },
>> +	[IFLA_BRPORT_MCAST_MAX_GROUPS] = { .type = NLA_U32 },
>>  };
>>  
>>  /* Change the state of the port and notify spanning tree */
>> @@ -1017,6 +1025,13 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
>>  		if (err)
>>  			return err;
>>  	}
>> +
>> +	if (tb[IFLA_BRPORT_MCAST_MAX_GROUPS]) {
>> +		u32 max_groups;
>> +
>> +		max_groups = nla_get_u32(tb[IFLA_BRPORT_MCAST_MAX_GROUPS]);
>> +		br_multicast_port_ngroups_set_max(p, max_groups);
>> +	}
>>  #endif
>>  
>>  	if (tb[IFLA_BRPORT_GROUP_FWD_MASK]) {
>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>> index 49f411a0a1f1..98f3836efb84 100644
>> --- a/net/bridge/br_private.h
>> +++ b/net/bridge/br_private.h
>> @@ -978,6 +978,18 @@ void br_multicast_uninit_stats(struct net_bridge *br);
>>  void br_multicast_get_stats(const struct net_bridge *br,
>>  			    const struct net_bridge_port *p,
>>  			    struct br_mcast_stats *dest);
>> +u32 br_multicast_port_ngroups_get(const struct net_bridge_port *port);
>> +int br_multicast_vlan_ngroups_get(struct net_bridge *br,
>> +				  const struct net_bridge_vlan *v,
>> +				  u32 *n);
>> +void br_multicast_port_ngroups_set_max(struct net_bridge_port *port, u32 max);
>> +int br_multicast_vlan_ngroups_set_max(struct net_bridge *br,
>> +				      struct net_bridge_vlan *v, u32 max,
>> +				      struct netlink_ext_ack *extack);
>> +u32 br_multicast_port_ngroups_get_max(const struct net_bridge_port *port);
>> +int br_multicast_vlan_ngroups_get_max(struct net_bridge *br,
>> +				      const struct net_bridge_vlan *v,
>> +				      u32 *max);
>>  void br_mdb_init(void);
>>  void br_mdb_uninit(void);
>>  void br_multicast_host_join(const struct net_bridge_mcast *brmctx,
>> @@ -1761,7 +1773,8 @@ static inline u16 br_vlan_flags(const struct net_bridge_vlan *v, u16 pvid)
>>  #ifdef CONFIG_BRIDGE_VLAN_FILTERING
>>  bool br_vlan_opts_eq_range(const struct net_bridge_vlan *v_curr,
>>  			   const struct net_bridge_vlan *range_end);
>> -bool br_vlan_opts_fill(struct sk_buff *skb, const struct net_bridge_vlan *v);
>> +bool br_vlan_opts_fill(struct sk_buff *skb, const struct net_bridge_vlan *v,
>> +		       const struct net_bridge_port *p);
>>  size_t br_vlan_opts_nl_size(void);
>>  int br_vlan_process_options(const struct net_bridge *br,
>>  			    const struct net_bridge_port *p,
>> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
>> index bc75fa1e4666..8a3dbc09ba38 100644
>> --- a/net/bridge/br_vlan.c
>> +++ b/net/bridge/br_vlan.c
>> @@ -1816,6 +1816,7 @@ static bool br_vlan_stats_fill(struct sk_buff *skb,
>>  /* v_opts is used to dump the options which must be equal in the whole range */
>>  static bool br_vlan_fill_vids(struct sk_buff *skb, u16 vid, u16 vid_range,
>>  			      const struct net_bridge_vlan *v_opts,
>> +			      const struct net_bridge_port *p,
>>  			      u16 flags,
>>  			      bool dump_stats)
>>  {
>> @@ -1842,7 +1843,7 @@ static bool br_vlan_fill_vids(struct sk_buff *skb, u16 vid, u16 vid_range,
>>  		goto out_err;
>>  
>>  	if (v_opts) {
>> -		if (!br_vlan_opts_fill(skb, v_opts))
>> +		if (!br_vlan_opts_fill(skb, v_opts, p))
>>  			goto out_err;
>>  
>>  		if (dump_stats && !br_vlan_stats_fill(skb, v_opts))
>> @@ -1925,7 +1926,7 @@ void br_vlan_notify(const struct net_bridge *br,
>>  		goto out_kfree;
>>  	}
>>  
>> -	if (!br_vlan_fill_vids(skb, vid, vid_range, v, flags, false))
>> +	if (!br_vlan_fill_vids(skb, vid, vid_range, v, p, flags, false))
>>  		goto out_err;
>>  
>>  	nlmsg_end(skb, nlh);
>> @@ -2030,7 +2031,7 @@ static int br_vlan_dump_dev(const struct net_device *dev,
>>  
>>  			if (!br_vlan_fill_vids(skb, range_start->vid,
>>  					       range_end->vid, range_start,
>> -					       vlan_flags, dump_stats)) {
>> +					       p, vlan_flags, dump_stats)) {
>>  				err = -EMSGSIZE;
>>  				break;
>>  			}
>> @@ -2056,7 +2057,7 @@ static int br_vlan_dump_dev(const struct net_device *dev,
>>  		else if (!dump_global &&
>>  			 !br_vlan_fill_vids(skb, range_start->vid,
>>  					    range_end->vid, range_start,
>> -					    br_vlan_flags(range_start, pvid),
>> +					    p, br_vlan_flags(range_start, pvid),
>>  					    dump_stats))
>>  			err = -EMSGSIZE;
>>  	}
>> @@ -2131,6 +2132,8 @@ static const struct nla_policy br_vlan_db_policy[BRIDGE_VLANDB_ENTRY_MAX + 1] =
>>  	[BRIDGE_VLANDB_ENTRY_STATE]	= { .type = NLA_U8 },
>>  	[BRIDGE_VLANDB_ENTRY_TUNNEL_INFO] = { .type = NLA_NESTED },
>>  	[BRIDGE_VLANDB_ENTRY_MCAST_ROUTER]	= { .type = NLA_U8 },
>> +	[BRIDGE_VLANDB_ENTRY_MCAST_N_GROUPS]	= { .type = NLA_REJECT },
>> +	[BRIDGE_VLANDB_ENTRY_MCAST_MAX_GROUPS]	= { .type = NLA_U32 },
>>  };
>>  
>>  static int br_vlan_rtm_process_one(struct net_device *dev,
>> diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
>> index a2724d03278c..43d8f11ce79c 100644
>> --- a/net/bridge/br_vlan_options.c
>> +++ b/net/bridge/br_vlan_options.c
>> @@ -48,7 +48,8 @@ bool br_vlan_opts_eq_range(const struct net_bridge_vlan *v_curr,
>>  	       curr_mc_rtr == range_mc_rtr;
>>  }
>>  
>> -bool br_vlan_opts_fill(struct sk_buff *skb, const struct net_bridge_vlan *v)
>> +bool br_vlan_opts_fill(struct sk_buff *skb, const struct net_bridge_vlan *v,
>> +		       const struct net_bridge_port *p)
>>  {
>>  	if (nla_put_u8(skb, BRIDGE_VLANDB_ENTRY_STATE, br_vlan_get_state(v)) ||
>>  	    !__vlan_tun_put(skb, v))
>> @@ -58,6 +59,20 @@ bool br_vlan_opts_fill(struct sk_buff *skb, const struct net_bridge_vlan *v)
>>  	if (nla_put_u8(skb, BRIDGE_VLANDB_ENTRY_MCAST_ROUTER,
>>  		       br_vlan_multicast_router(v)))
>>  		return false;
>> +	if (p && !br_multicast_port_ctx_vlan_disabled(&v->port_mcast_ctx)) {
>> +		u32 mdb_max_entries;
>> +		u32 mdb_n_entries;
>> +
>> +		if (br_multicast_vlan_ngroups_get(p->br, v, &mdb_n_entries) ||
>> +		    nla_put_u32(skb, BRIDGE_VLANDB_ENTRY_MCAST_N_GROUPS,
>> +				mdb_n_entries))
>> +			return false;
>> +		if (br_multicast_vlan_ngroups_get_max(p->br, v,
>> +						      &mdb_max_entries) ||
>> +		    nla_put_u32(skb, BRIDGE_VLANDB_ENTRY_MCAST_MAX_GROUPS,
>> +				mdb_max_entries))
>> +			return false;
>> +	}
>>  #endif
>>  
>>  	return true;
>> @@ -70,6 +85,8 @@ size_t br_vlan_opts_nl_size(void)
>>  	       + nla_total_size(sizeof(u32)) /* BRIDGE_VLANDB_TINFO_ID */
>>  #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
>>  	       + nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_ENTRY_MCAST_ROUTER */
>> +	       + nla_total_size(sizeof(u32)) /* BRIDGE_VLANDB_ENTRY_MCAST_N_GROUPS */
>> +	       + nla_total_size(sizeof(u32)) /* BRIDGE_VLANDB_ENTRY_MCAST_MAX_GROUPS */
>>  #endif
>>  	       + 0;
>>  }
>> @@ -212,6 +229,20 @@ static int br_vlan_process_one_opts(const struct net_bridge *br,
>>  			return err;
>>  		*changed = true;
>>  	}
>> +	if (tb[BRIDGE_VLANDB_ENTRY_MCAST_MAX_GROUPS]) {
>> +		u32 val;
>> +
>> +		if (!p) {
>> +			NL_SET_ERR_MSG_MOD(extack, "Can't set mcast_max_groups for non-port vlans");
>> +			return -EINVAL;
>> +		}
>> +
>> +		val = nla_get_u32(tb[BRIDGE_VLANDB_ENTRY_MCAST_MAX_GROUPS]);
>> +		err = br_multicast_vlan_ngroups_set_max(p->br, v, val, extack);
>> +		if (err)
>> +			return err;
>> +		*changed = true;
>> +	}
>>  #endif
>>  
>>  	return 0;
>> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>> index 64289bc98887..e786255a8360 100644
>> --- a/net/core/rtnetlink.c
>> +++ b/net/core/rtnetlink.c
>> @@ -58,7 +58,7 @@
>>  #include "dev.h"
>>  
>>  #define RTNL_MAX_TYPE		50
>> -#define RTNL_SLAVE_MAX_TYPE	40
>> +#define RTNL_SLAVE_MAX_TYPE	42
>>  
>>  struct rtnl_link {
>>  	rtnl_doit_func		doit;
> 

