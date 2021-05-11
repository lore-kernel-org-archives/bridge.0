Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnHV5mJNnwgq/koCsth+OHwF0qvxxSoE41hzLBBf3f4=;
 b=TaN2A0vg3d9w9dbXcQmcPA5d1mn7cM37G77LRleKGROWOvwSmhxav+aMOAoKLcfEVEqGFhAulhAk5pv5hdmsRdgxh8ZyjPfswXUHityz5pD6m3NbOy8vr3C3MjcdVs2f67kbyzcrY0OJKqE4TUHJief+SU7IQHfmnIZfMBIs9PH8zk1m1NbU89LT6hyQlBcvOoFGmP12u5Gr1cT9HPe2IicBQG1ZB3VceE4ww2YAi6Qs2mKM2FjM8kobp6wXXzjaSF0b7Q2oKZBDJ3n0DSrQU7WEEfETuC2Rp66Uoup3hyZi47OTrmL2VBbtJ2U7IJ63NImyr49Wvos2tWPExroCFw==
References: <20210509194509.10849-1-linus.luessing@c0d3.blue>
 <20210509194509.10849-3-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <971325eb-b0e9-d1a8-b7a1-b8a2b30fc267@nvidia.com>
Date: Tue, 11 May 2021 12:12:35 +0300
In-Reply-To: <20210509194509.10849-3-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [net-next v2 02/11] net: bridge: mcast: add wrappers
 for router node retrieval
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>

On 09/05/2021 22:45, Linus Lüssing wrote:
> In preparation for the upcoming split of multicast router state into
> their IPv4 and IPv6 variants and to avoid IPv6 #ifdef clutter later add
> two wrapper functions for router node retrieval in the payload
> forwarding code.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_forward.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index 3b67184..b5ec4f9 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -264,6 +264,16 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
>  	__br_forward(p, skb, local_orig);
>  }
>  
> +static inline struct hlist_node *
> +br_multicast_get_first_rport_node(struct net_bridge *b, struct sk_buff *skb) {
> +	return rcu_dereference(hlist_first_rcu(&b->ip4_mc_router_list));
> +}
> +
> +static inline struct net_bridge_port *
> +br_multicast_rport_from_node(struct hlist_node *rp, struct sk_buff *skb) {
> +	return hlist_entry_safe(rp, struct net_bridge_port, ip4_rlist);
> +}
> +

Inline functions in .c files are not allowed, please move these to br_private.h

>  /* called with rcu_read_lock */
>  void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
>  			struct sk_buff *skb,
> @@ -276,7 +286,8 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
>  	bool allow_mode_include = true;
>  	struct hlist_node *rp;
>  
> -	rp = rcu_dereference(hlist_first_rcu(&br->router_list));
> +	rp = br_multicast_get_first_rport_node(br, skb);
> +
>  	if (mdst) {
>  		p = rcu_dereference(mdst->ports);
>  		if (br_multicast_should_handle_mode(br, mdst->addr.proto) &&
> @@ -290,7 +301,7 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
>  		struct net_bridge_port *port, *lport, *rport;
>  
>  		lport = p ? p->key.port : NULL;
> -		rport = hlist_entry_safe(rp, struct net_bridge_port, ip4_rlist);
> +		rport = br_multicast_rport_from_node(rp, skb);
>  
>  		if ((unsigned long)lport > (unsigned long)rport) {
>  			port = lport;
> 

