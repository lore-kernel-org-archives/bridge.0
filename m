Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D6CF881421
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EFE2F81411
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khDW3a22wMfvB0Ciwx9Vs3jJCDNLmXL+yGA1akJm1XY=;
 b=UWbEkhMjMveErCXb/dIh2QodYKPBO417vT7ckPjxFXAV0lAsdgJA+xkLUt9h1dgvnxnMmIzdymvk9x6M+855Wd6FW0tEUTISolG0RgoZqFvmIWsr+Q7bhBSXJbuMWIb/m5QGNZiRBGZwNMkseBQHT82zY7EAB/ZcBaCpJE828FOYov8WIQT/8t3iYpGTB1FA1VmyODppnpDLF/idFs6XzAJ7yr/OB8NLJm1LnN7UUnSuUPhDLAGgIl3lBNyv7yIgyA7Kh1TNPJ988b+Eaxj4F5WwG/apE3efkGaNH6AFTJF24bfo39VV20CJH/u5LFPqeQeH7Oo5XwxpGeho7bAQ3g==
Date: Sat, 27 Aug 2022 18:19:06 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Ywo16vHMqxxszWzX@shredder>
References: <20220826114538.705433-1-netdev@kapio-technology.com>
 <20220826114538.705433-2-netdev@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826114538.705433-2-netdev@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v5 net-next 1/6] net: bridge: add locked entry
 fdb flag to extend locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Fri, Aug 26, 2022 at 01:45:33PM +0200, Hans Schultz wrote:
> diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
> index a998bf761635..bc1440a56b70 100644
> --- a/include/uapi/linux/neighbour.h
> +++ b/include/uapi/linux/neighbour.h
> @@ -52,7 +52,9 @@ enum {
>  #define NTF_STICKY	(1 << 6)
>  #define NTF_ROUTER	(1 << 7)
>  /* Extended flags under NDA_FLAGS_EXT: */
> -#define NTF_EXT_MANAGED	(1 << 0)
> +#define NTF_EXT_MANAGED		(1 << 0)
> +#define NTF_EXT_LOCKED		(1 << 1)
> +#define NTF_EXT_BLACKHOLE	(1 << 2)

A few lines below in the file there is a comment explaining
NTF_EXT_MANAGED. Please document NTF_EXT_LOCKED and NTF_EXT_BLACKHOLE as
well.

>  
>  /*
>   *	Neighbor Cache Entry States.

[...]

> @@ -1082,6 +1095,16 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>  		modified = true;
>  	}
>  
> +	if (test_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags)) {
> +		clear_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags);
> +		modified = true;
> +	}

Should be able to use test_and_clear_bit():

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e7f4fccb6adb..e5561ee2bfac 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1082,6 +1082,9 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
                modified = true;
        }
 
+       if (test_and_clear_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags))
+               modified = true;
+
        if (fdb_handle_notify(fdb, notify))
                modified = true;

> +
> +	if (test_bit(BR_FDB_BLACKHOLE, &fdb->flags)) {
> +		clear_bit(BR_FDB_BLACKHOLE, &fdb->flags);
> +		modified = true;
> +	}

This will need to change to allow user space to set the flag.

> +
>  	if (fdb_handle_notify(fdb, notify))
>  		modified = true;
>  
> @@ -1178,6 +1201,12 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
>  		vg = nbp_vlan_group(p);
>  	}
>  
> +	if (tb[NDA_FLAGS_EXT] &&
> +	    (nla_get_u32(tb[NDA_FLAGS_EXT]) & (NTF_EXT_LOCKED | NTF_EXT_BLACKHOLE))) {
> +		pr_info("bridge: RTM_NEWNEIGH has invalid extended flags\n");
> +		return -EINVAL;
> +	}
> +
>  	if (tb[NDA_FDB_EXT_ATTRS]) {
>  		attr = tb[NDA_FDB_EXT_ATTRS];
>  		err = nla_parse_nested(nfea_tb, NFEA_MAX, attr,
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 68b3e850bcb9..3d48aa7fa778 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -110,8 +110,19 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  			br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
>  
>  		if (!fdb_src || READ_ONCE(fdb_src->dst) != p ||
> -		    test_bit(BR_FDB_LOCAL, &fdb_src->flags))
> +		    test_bit(BR_FDB_LOCAL, &fdb_src->flags) ||
> +		    test_bit(BR_FDB_ENTRY_LOCKED, &fdb_src->flags)) {
> +			if (!fdb_src || (READ_ONCE(fdb_src->dst) != p &&
> +					 (p->flags & BR_LEARNING))) {

It looks like you are allowing a locked port to:

1. Overtake a local entry. Actually, it will be rejected by
br_fdb_update() with a rate limited error message, but best to avoid it.

2. Overtake an entry pointing to an unlocked port. There is no reason
for an authorized port to lose communication because an unauthorized
port decided to spoof its MAC.

> +				unsigned long flags = 0;
> +
> +				if (p->flags & BR_PORT_MAB) {
> +					__set_bit(BR_FDB_ENTRY_LOCKED, &flags);
> +					br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, flags);
> +				}
> +			}
>  			goto drop;
> +		}
>  	}

How about the below (untested):

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 68b3e850bcb9..9143a94a1c57 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -109,9 +109,18 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
                struct net_bridge_fdb_entry *fdb_src =
                        br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
 
-               if (!fdb_src || READ_ONCE(fdb_src->dst) != p ||
-                   test_bit(BR_FDB_LOCAL, &fdb_src->flags))
+               if (!fdb_src) {
+                       if (p->flags & BR_PORT_MAB) {
+                               __set_bit(BR_FDB_ENTRY_LOCKED, &flags);
+                               br_fdb_update(br, p, eth_hdr(skb)->h_source,
+                                             vid, flags);
+                       }
+                       goto drop;
+               } else if (READ_ONCE(fdb_src->dst) != p ||
+                          test_bit(BR_FDB_LOCAL, &fdb_src->flags) ||
+                          test_bit(BR_FDB_LOCKED, &fdb_src->flags)) {
                        goto drop;
+               }
        }

The semantics are very clear, IMO. On FDB miss, add a locked FDB entry
and drop the packet. On FDB mismatch, drop the packet.

Entry can roam from an unauthorized port to an authorized port, but not
the other way around. Not sure what is the use case for allowing roaming
between unauthorized ports. 

Note that with the above, locked entries are not refreshed and will
therefore age out unless replaced by user space.

>  
>  	nbp_switchdev_frame_mark(p, skb);
> @@ -943,6 +946,10 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
>  	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_SUPPRESS, BR_NEIGH_SUPPRESS);
>  	br_set_port_flag(p, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
>  	br_set_port_flag(p, tb, IFLA_BRPORT_LOCKED, BR_PORT_LOCKED);
> +	br_set_port_flag(p, tb, IFLA_BRPORT_MAB, BR_PORT_MAB);
> +
> +	if (!(p->flags & BR_PORT_LOCKED))
> +		p->flags &= ~BR_PORT_MAB;

Any reason not to emit an error if MAB is enabled while the port is
unlocked? Something like this (untested):

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 5aeb3646e74c..18353a4c29e1 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -944,6 +944,12 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
        br_set_port_flag(p, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
        br_set_port_flag(p, tb, IFLA_BRPORT_LOCKED, BR_PORT_LOCKED);
 
+       if (!(p->flags & BR_PORT_LOCKED) && (p->flags & BR_PORT_MAB)) {
+               NL_SET_ERR_MSG(extack, "MAB cannot be enabled when port is unlocked");
+               p->flags = old_flags;
+               return -EINVAL;
+       }
+
        changed_mask = old_flags ^ p->flags;
 
        err = br_switchdev_set_port_flag(p, p->flags, changed_mask, extack);

>  
>  	changed_mask = old_flags ^ p->flags;
>  
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 06e5f6faa431..048e4afbc5a0 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -251,7 +251,9 @@ enum {
>  	BR_FDB_ADDED_BY_EXT_LEARN,
>  	BR_FDB_OFFLOADED,
>  	BR_FDB_NOTIFY,
> -	BR_FDB_NOTIFY_INACTIVE
> +	BR_FDB_NOTIFY_INACTIVE,
> +	BR_FDB_ENTRY_LOCKED,
> +	BR_FDB_BLACKHOLE,
>  };
>  
>  struct net_bridge_fdb_key {
> -- 
> 2.30.2
> 
