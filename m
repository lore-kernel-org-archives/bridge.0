Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-transfer-encoding;
 bh=IKRDa23hbXU9zh7lvaHhdJ8fhl6aua5us85s76CYpJw=;
 b=WBqg4U5x6lGVvxw+ZA24unq6NKmqUfAFFhe4tJj+tlICv1Yyk+1azA30VrmCisiTa/
 6jBn4b9hEocjtiPOfUyqiePBLEQkdkjxdITJcDtRkutLcrBnt4RskhG5NPCLkveDSsb5
 hVWEFvdgLFA/923UvNWFfg8AwdJOAXzAM309M2C/PUMGdfL265AtMYbDxq+8z833/Fk3
 VYB0W5aCwz+HHqB0O1hnEkjL3LQRQKK0Tnsfm6LYpnR2u34OlUkL5i3oYg5GZUiUxke/
 oVkSahXtVWaQINSqif+KbG5d21gtKcacpi8CDZHDb145U/DIzPmennjq76I9hDuhxfMV
 B37g==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <YgD5MglBy/UbN0uX@shredder>
References: <20220207100742.15087-1-schultz.hans+netdev@gmail.com>
 <20220207100742.15087-2-schultz.hans+netdev@gmail.com>
 <YgD5MglBy/UbN0uX@shredder>
Date: Tue, 08 Feb 2022 11:26:24 +0100
Message-ID: <8635ktvelr.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next 1/4] net: bridge: Add support for
 bridge port in locked mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>, Hans Schultz <schultz.hans@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, davem@davemloft.net

On m=C3=A5n, feb 07, 2022 at 12:49, Ido Schimmel <idosch@idosch.org> wrote:
> On Mon, Feb 07, 2022 at 11:07:39AM +0100, Hans Schultz wrote:
>> In a 802.1X scenario, clients connected to a bridge port shall not
>> be allowed to have traffic forwarded until fully authenticated.
>> A static fdb entry of the clients MAC address for the bridge port
>> unlocks the client and allows bidirectional communication.
>>=20
>> This scenario is facilitated with setting the bridge port in locked
>> mode, which is also supported by various switchcore chipsets.
>>=20
>> Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
>> ---
>>  include/linux/if_bridge.h    |  1 +
>>  include/uapi/linux/if_link.h |  1 +
>>  net/bridge/br_input.c        | 10 +++++++++-
>>  net/bridge/br_netlink.c      |  6 +++++-
>>  4 files changed, 16 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
>> index 509e18c7e740..3aae023a9353 100644
>> --- a/include/linux/if_bridge.h
>> +++ b/include/linux/if_bridge.h
>> @@ -58,6 +58,7 @@ struct br_ip_list {
>>  #define BR_MRP_LOST_CONT	BIT(18)
>>  #define BR_MRP_LOST_IN_CONT	BIT(19)
>>  #define BR_TX_FWD_OFFLOAD	BIT(20)
>> +#define BR_PORT_LOCKED		BIT(21)
>>=20=20
>>  #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
>>=20=20
>> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
>> index 6218f93f5c1a..8fa2648fbc83 100644
>> --- a/include/uapi/linux/if_link.h
>> +++ b/include/uapi/linux/if_link.h
>> @@ -532,6 +532,7 @@ enum {
>>  	IFLA_BRPORT_GROUP_FWD_MASK,
>>  	IFLA_BRPORT_NEIGH_SUPPRESS,
>>  	IFLA_BRPORT_ISOLATED,
>> +	IFLA_BRPORT_LOCKED,
>
> Please add it at the end to avoid breaking uAPI
>

Shall do.

>>  	IFLA_BRPORT_BACKUP_PORT,
>>  	IFLA_BRPORT_MRP_RING_OPEN,
>>  	IFLA_BRPORT_MRP_IN_OPEN,
>> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
>> index b50382f957c1..469e3adbce07 100644
>> --- a/net/bridge/br_input.c
>> +++ b/net/bridge/br_input.c
>> @@ -69,6 +69,7 @@ int br_handle_frame_finish(struct net *net, struct soc=
k *sk, struct sk_buff *skb
>>  	struct net_bridge_port *p =3D br_port_get_rcu(skb->dev);
>>  	enum br_pkt_type pkt_type =3D BR_PKT_UNICAST;
>>  	struct net_bridge_fdb_entry *dst =3D NULL;
>> +	struct net_bridge_fdb_entry *fdb_entry;
>>  	struct net_bridge_mcast_port *pmctx;
>>  	struct net_bridge_mdb_entry *mdst;
>>  	bool local_rcv, mcast_hit =3D false;
>> @@ -81,6 +82,8 @@ int br_handle_frame_finish(struct net *net, struct soc=
k *sk, struct sk_buff *skb
>>  	if (!p || p->state =3D=3D BR_STATE_DISABLED)
>>  		goto drop;
>>=20=20
>> +	br =3D p->br;
>> +
>>  	brmctx =3D &p->br->multicast_ctx;
>>  	pmctx =3D &p->multicast_ctx;
>>  	state =3D p->state;
>> @@ -88,10 +91,15 @@ int br_handle_frame_finish(struct net *net, struct s=
ock *sk, struct sk_buff *skb
>>  				&state, &vlan))
>>  		goto out;
>>=20=20
>> +	if (p->flags & BR_PORT_LOCKED) {
>> +		fdb_entry =3D br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
>> +		if (!(fdb_entry && fdb_entry->dst =3D=3D p))
>> +			goto drop;
>
> I'm not familiar with 802.1X so I have some questions:
>
> 1. Do we need to differentiate between no FDB entry and an FDB entry
> pointing to a different port than we expect?
>
> 2. Does user space care about SAs that did not pass the check? That is,
> does it need to see notifications? Counters?
>

2. As of now there are no counters, notifications on a locked port.

>> +	}
>> +
>>  	nbp_switchdev_frame_mark(p, skb);
>>=20=20
>>  	/* insert into forwarding database after filtering to avoid spoofing */
>> -	br =3D p->br;
>>  	if (p->flags & BR_LEARNING)
>>  		br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, 0);
>>=20=20
>> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
>> index 2ff83d84230d..7d4432ca9a20 100644
>> --- a/net/bridge/br_netlink.c
>> +++ b/net/bridge/br_netlink.c
>> @@ -184,6 +184,7 @@ static inline size_t br_port_info_size(void)
>>  		+ nla_total_size(1)	/* IFLA_BRPORT_VLAN_TUNNEL */
>>  		+ nla_total_size(1)	/* IFLA_BRPORT_NEIGH_SUPPRESS */
>>  		+ nla_total_size(1)	/* IFLA_BRPORT_ISOLATED */
>> +		+ nla_total_size(1)	/* IFLA_BRPORT_LOCKED */
>>  		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_ROOT_I=
D */
>>  		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_BRIDGE=
_ID */
>>  		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_DESIGNATED_PORT */
>> @@ -269,7 +270,8 @@ static int br_port_fill_attrs(struct sk_buff *skb,
>>  							  BR_MRP_LOST_CONT)) ||
>>  	    nla_put_u8(skb, IFLA_BRPORT_MRP_IN_OPEN,
>>  		       !!(p->flags & BR_MRP_LOST_IN_CONT)) ||
>> -	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)))
>> +	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)) =
||
>> +	    nla_put_u8(skb, IFLA_BRPORT_LOCKED, !!(p->flags & BR_PORT_LOCKED)))
>>  		return -EMSGSIZE;
>>=20=20
>>  	timerval =3D br_timer_value(&p->message_age_timer);
>> @@ -827,6 +829,7 @@ static const struct nla_policy br_port_policy[IFLA_B=
RPORT_MAX + 1] =3D {
>>  	[IFLA_BRPORT_GROUP_FWD_MASK] =3D { .type =3D NLA_U16 },
>>  	[IFLA_BRPORT_NEIGH_SUPPRESS] =3D { .type =3D NLA_U8 },
>>  	[IFLA_BRPORT_ISOLATED]	=3D { .type =3D NLA_U8 },
>> +	[IFLA_BRPORT_LOCKED] =3D { .type =3D NLA_U8 },
>>  	[IFLA_BRPORT_BACKUP_PORT] =3D { .type =3D NLA_U32 },
>>  	[IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT] =3D { .type =3D NLA_U32 },
>>  };
>> @@ -893,6 +896,7 @@ static int br_setport(struct net_bridge_port *p, str=
uct nlattr *tb[],
>>  	br_set_port_flag(p, tb, IFLA_BRPORT_VLAN_TUNNEL, BR_VLAN_TUNNEL);
>>  	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_SUPPRESS, BR_NEIGH_SUPPRESS);
>>  	br_set_port_flag(p, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
>> +	br_set_port_flag(p, tb, IFLA_BRPORT_LOCKED, BR_PORT_LOCKED);
>>=20=20
>>  	changed_mask =3D old_flags ^ p->flags;
>>=20=20
>> --=20
>> 2.30.2
>>=20
