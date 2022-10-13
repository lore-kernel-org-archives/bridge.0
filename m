Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F295B403C8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 20A5340390
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyjqTXnskcfRWQYYTQfpNjb32qwOoO4IhxQhv3iAAXY=;
 b=NnZnyY3BV3Bt8xHNlzTznDHMRib6T6KKvRGyy6Xm5Lp/dujUEvWgT2oJ7FpCcJfhZtP7EKimZ6idHL4tjKFtN9FIQMa4/FanuQk80GWigBlju+r/0K2t/TF3iZReNoBqy/nn06LQJwz41HkaQDuw5Er17LF5XC4liN5S02fNpd4tIQWn7WrYo8HfbGyozKK3waoyzahN3ppifq2Ukr2RpVZq2RL7yelxJI1EJI7xzl9uQco+tU/AFZB4HkmU96+jHuqNPDCuYgxELlQcDoGVWCfHmxvY64bUUAMKuN/AeA23XbRZrwkhJ/4GIoh2JthoSZ8Xtx2KMrrFPuuCnOMMJw==
Date: Thu, 13 Oct 2022 16:29:42 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y0gSxhIEQD9BC/SE@shredder>
References: <20221009174052.1927483-1-netdev@kapio-technology.com>
 <20221009174052.1927483-3-netdev@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009174052.1927483-3-netdev@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v7 net-next 2/9] net: bridge: add blackhole fdb
	entry flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Hans J. Schultz" <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Sun, Oct 09, 2022 at 07:40:45PM +0200, Hans J. Schultz wrote:
> @@ -1018,8 +1020,9 @@ static bool fdb_handle_notify(struct net_bridge_fdb_entry *fdb, u8 notify)
>  /* Update (create or replace) forwarding database entry */
>  static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>  			 const u8 *addr, struct ndmsg *ndm, u16 flags, u16 vid,
> -			 struct nlattr *nfea_tb[])
> +			 u32 ext_flags, struct nlattr *nfea_tb[])
>  {
> +	bool blackhole = !!(ext_flags & NTF_EXT_BLACKHOLE);
>  	bool is_sticky = !!(ndm->ndm_flags & NTF_STICKY);
>  	bool refresh = !nfea_tb[NFEA_DONT_REFRESH];
>  	struct net_bridge_fdb_entry *fdb;
> @@ -1092,6 +1095,14 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>  		modified = true;
>  	}
>  
> +	if (blackhole != test_bit(BR_FDB_BLACKHOLE, &fdb->flags)) {
> +		change_bit(BR_FDB_BLACKHOLE, &fdb->flags);
> +		modified = true;
> +	}
> +
> +	if (blackhole)
> +		set_bit(BR_FDB_LOCAL, &fdb->flags);

We should instead validate earlier that NTF_EXT_BLACKHOLE is only
specified with NUD_PERMANENT. See more below.

> +
>  	if (test_and_clear_bit(BR_FDB_LOCKED, &fdb->flags))
>  		modified = true;
>  
> @@ -1113,7 +1124,7 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>  static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
>  			struct net_bridge_port *p, const unsigned char *addr,
>  			u16 nlh_flags, u16 vid, struct nlattr *nfea_tb[],
> -			struct netlink_ext_ack *extack)
> +			u32 ext_flags, struct netlink_ext_ack *extack)
>  {
>  	int err = 0;
>  
> @@ -1138,9 +1149,12 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
>  			return -EINVAL;
>  		}
>  		err = br_fdb_external_learn_add(br, p, addr, vid, true);
> +	} else if ((ext_flags & NTF_EXT_BLACKHOLE) && p) {
> +		NL_SET_ERR_MSG_MOD(extack, "Blackhole FDB entry cannot be applied on a port");
> +		return -EINVAL;

This is too late. I can do:

# bridge fdb add 00:aa:bb:cc:dd:ee dev dummy1 master extern_learn blackhole
# bridge fdb get 00:aa:bb:cc:dd:ee br br0 
00:aa:bb:cc:dd:ee dev dummy1 extern_learn master br0 

Nothing will explode, but it's not ideal either.

Since we force blackhole entries to be permanent they cannot be aged by
the kernel. I'm not sure what is the use case for user space adding
externally learned blackhole entries.

How about:

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index d6f22e2e018a..9257a46544dd 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1100,9 +1100,6 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 		modified = true;
 	}
 
-	if (blackhole)
-		set_bit(BR_FDB_LOCAL, &fdb->flags);
-
 	if (test_and_clear_bit(BR_FDB_LOCKED, &fdb->flags))
 		modified = true;
 
@@ -1149,9 +1146,6 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 			return -EINVAL;
 		}
 		err = br_fdb_external_learn_add(br, p, addr, vid, false, false, false, true);
-	} else if ((ext_flags & NTF_EXT_BLACKHOLE) && p) {
-		NL_SET_ERR_MSG_MOD(extack, "Blackhole FDB entry cannot be applied on a port");
-		return -EINVAL;
 	} else {
 		spin_lock_bh(&br->hash_lock);
 		err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, ext_flags, nfea_tb);
@@ -1214,6 +1208,21 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 		return -EINVAL;
 	}
 
+	if (ext_flags & NTF_EXT_BLACKHOLE) {
+		if (!(ndm->ndm_state & NUD_PERMANENT)) {
+			NL_SET_ERR_MSG_MOD(extack, "Blackhole FDB entry must be permanent");
+			return -EINVAL;
+		}
+		if (p) {
+			NL_SET_ERR_MSG_MOD(extack, "Blackhole FDB entry cannot be applied on a port");
+			return -EINVAL;
+		}
+		if (ndm->ndm_flags & NTF_EXT_LEARNED) {
+			NL_SET_ERR_MSG_MOD(extack, "Blackhole FDB entry cannot be added as externally learned");
+			return -EINVAL;
+		}
+	}
+
 	if (tb[NDA_FDB_EXT_ATTRS]) {
 		attr = tb[NDA_FDB_EXT_ATTRS];
 		err = nla_parse_nested(nfea_tb, NFEA_MAX, attr,

With which I get:

# bridge fdb add 00:aa:bb:cc:dd:ee dev dummy1 master extern_learn blackhole
Error: bridge: Blackhole FDB entry cannot be applied on a port.

# bridge fdb add 00:aa:bb:cc:dd:ee dev br0 self extern_learn blackhole
Error: bridge: Blackhole FDB entry cannot be added as externally learned.

>  	} else {
>  		spin_lock_bh(&br->hash_lock);
> -		err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, nfea_tb);
> +		err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, ext_flags, nfea_tb);
>  		spin_unlock_bh(&br->hash_lock);
>  	}
>  
> @@ -1219,10 +1233,10 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
>  
>  		/* VID was specified, so use it. */
>  		err = __br_fdb_add(ndm, br, p, addr, nlh_flags, vid, nfea_tb,
> -				   extack);
> +				   ext_flags, extack);
>  	} else {
>  		err = __br_fdb_add(ndm, br, p, addr, nlh_flags, 0, nfea_tb,
> -				   extack);
> +				   ext_flags, extack);
>  		if (err || !vg || !vg->num_vlans)
>  			goto out;
>  
> @@ -1234,7 +1248,7 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
>  			if (!br_vlan_should_use(v))
>  				continue;
>  			err = __br_fdb_add(ndm, br, p, addr, nlh_flags, v->vid,
> -					   nfea_tb, extack);
> +					   nfea_tb, ext_flags, extack);
>  			if (err)
>  				goto out;
>  		}
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 068fced7693c..665d1d6bdc75 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -193,8 +193,11 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  	if (dst) {
>  		unsigned long now = jiffies;
>  
> -		if (test_bit(BR_FDB_LOCAL, &dst->flags))
> +		if (test_bit(BR_FDB_LOCAL, &dst->flags)) {
> +			if (unlikely(test_bit(BR_FDB_BLACKHOLE, &dst->flags)))
> +				goto drop;
>  			return br_pass_frame_up(skb);
> +		}
>  
>  		if (now != dst->used)
>  			dst->used = now;
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 4ce8b8e5ae0b..e7a08657c7ed 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -253,6 +253,7 @@ enum {
>  	BR_FDB_NOTIFY,
>  	BR_FDB_NOTIFY_INACTIVE,
>  	BR_FDB_LOCKED,
> +	BR_FDB_BLACKHOLE,
>  };
>  
>  struct net_bridge_fdb_key {
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 8008ceb45605..ae641dfea5f2 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -4054,7 +4054,7 @@ int ndo_dflt_fdb_add(struct ndmsg *ndm,
>  	if (tb[NDA_FLAGS_EXT])
>  		ext_flags = nla_get_u32(tb[NDA_FLAGS_EXT]);
>  
> -	if (ext_flags & NTF_EXT_LOCKED) {
> +	if (ext_flags & (NTF_EXT_LOCKED | NTF_EXT_BLACKHOLE)) {
>  		netdev_info(dev, "invalid flags given to default FDB implementation\n");
>  		return err;
>  	}
> -- 
> 2.34.1
> 
