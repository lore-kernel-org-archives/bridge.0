Return-Path: <jnixdorf-oss@avm.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C9E560B88
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F0E860804
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1693914590; bh=FPvR5S0dzh9pzA8i7ZAlkvgvOnkftZUu19pNgPk7n8s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=HDBeSAuHZ/4fkrzgwKx/s+KTaIHBGX4CbvwyqIVPxdAwJYmYoHwHC/UwZsCMQBCtp
 /7lB/8fhFBc/xn15uNMgEhoHgSjoL0M7/2eTLXllwPn3O05e4Z62+7lMcIMAa7naTR
 12KAp/7xX2bfTu/a09ZFtVyFjp/zUlBqzcTNP0gc=
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
Date: Tue, 05 Sep 2023 13:47:21 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-fdb_limit-v3-4-7597cd500a82@avm.de>
References: <20230905-fdb_limit-v3-0-7597cd500a82@avm.de>
In-Reply-To: <20230905-fdb_limit-v3-0-7597cd500a82@avm.de>
Subject: [Bridge] [PATCH net-next v3 4/6] net: bridge: Add netlink knobs for
 number / max learned FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Oleksij Rempel <linux@rempel-privat.de>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Johannes Nixdorf <jnixdorf-oss@avm.de>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

The previous patch added accounting and a limit for the number of
dynamically learned FDB entries per bridge. However it did not provide
means to actually configure those bounds or read back the count. This
patch does that.

Two new netlink attributes are added for the accounting and limit of
dynamically learned FDB entries:
 - IFLA_BR_FDB_N_LEARNED_ENTRIES (RO) for the number of entries accounted
   for a single bridge.
 - IFLA_BR_FDB_MAX_LEARNED_ENTRIES (RW) for the configured limit of
   entries for the bridge.

The new attributes are used like this:

 # ip link add name br up type bridge fdb_max_learned_entries 256
 # ip link add name v1 up master br type veth peer v2
 # ip link set up dev v2
 # mausezahn -a rand -c 1024 v2
 0.01 seconds (90877 packets per second
 # bridge fdb | grep -v permanent | wc -l
 256
 # ip -d link show dev br
 13: br: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 [...]
     [...] fdb_n_learned_entries 256 fdb_max_learned_entries 256

Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
---
 include/uapi/linux/if_link.h |  2 ++
 net/bridge/br_netlink.c      | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 0f6a0fe09bdb..bcdf728cfe98 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -510,6 +510,8 @@ enum {
 	IFLA_BR_VLAN_STATS_PER_PORT,
 	IFLA_BR_MULTI_BOOLOPT,
 	IFLA_BR_MCAST_QUERIER_STATE,
+	IFLA_BR_FDB_N_LEARNED_ENTRIES,
+	IFLA_BR_FDB_MAX_LEARNED_ENTRIES,
 	__IFLA_BR_MAX,
 };
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 1dc4e1bce740..d8595274879d 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1254,6 +1254,8 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
 	[IFLA_BR_VLAN_STATS_PER_PORT] = { .type = NLA_U8 },
 	[IFLA_BR_MULTI_BOOLOPT] =
 		NLA_POLICY_EXACT_LEN(sizeof(struct br_boolopt_multi)),
+	[IFLA_BR_FDB_N_LEARNED_ENTRIES] = { .type = NLA_U32 },
+	[IFLA_BR_FDB_MAX_LEARNED_ENTRIES] = { .type = NLA_U32 },
 };
 
 static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
@@ -1528,6 +1530,12 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 			return err;
 	}
 
+	if (data[IFLA_BR_FDB_MAX_LEARNED_ENTRIES]) {
+		u32 val = nla_get_u32(data[IFLA_BR_FDB_MAX_LEARNED_ENTRIES]);
+
+		WRITE_ONCE(br->fdb_max_learned_entries, val);
+	}
+
 	return 0;
 }
 
@@ -1582,6 +1590,8 @@ static size_t br_get_size(const struct net_device *brdev)
 	       nla_total_size_64bit(sizeof(u64)) + /* IFLA_BR_TOPOLOGY_CHANGE_TIMER */
 	       nla_total_size_64bit(sizeof(u64)) + /* IFLA_BR_GC_TIMER */
 	       nla_total_size(ETH_ALEN) +       /* IFLA_BR_GROUP_ADDR */
+	       nla_total_size(sizeof(u32)) +    /* IFLA_BR_FDB_N_LEARNED_ENTRIES */
+	       nla_total_size(sizeof(u32)) +    /* IFLA_BR_FDB_MAX_LEARNED_ENTRIES */
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_MCAST_ROUTER */
 	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_MCAST_SNOOPING */
@@ -1657,7 +1667,10 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	    nla_put_u8(skb, IFLA_BR_TOPOLOGY_CHANGE_DETECTED,
 		       br->topology_change_detected) ||
 	    nla_put(skb, IFLA_BR_GROUP_ADDR, ETH_ALEN, br->group_addr) ||
-	    nla_put(skb, IFLA_BR_MULTI_BOOLOPT, sizeof(bm), &bm))
+	    nla_put(skb, IFLA_BR_MULTI_BOOLOPT, sizeof(bm), &bm) ||
+	    nla_put_u32(skb, IFLA_BR_FDB_N_LEARNED_ENTRIES,
+			atomic_read(&br->fdb_n_learned_entries)) ||
+	    nla_put_u32(skb, IFLA_BR_FDB_MAX_LEARNED_ENTRIES, br->fdb_max_learned_entries))
 		return -EMSGSIZE;
 
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING

-- 
2.42.0

