Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=wVQ0HARhc+FxCf/O5hQemDc31KPNUzAFgjRud4EVmj0=;
 b=IiYlIzzw6xSpVMIsEs9TF4kFV5ijoit+JbuIYRGVRHxl40fbt6p6r5Trxu6a5OYBWy
 a+6Phbq3A0pk0VkfqfpE4xJ943Z3EGR7sjRuAxznHf1wdsRFaVJ+gCAb/SCDtsxK0ERt
 aUgZ1sIjquH45Y0I5NONMMRHNSIuikRZN6GcOezI/K1BsYGwVffvhxQCDJdq5PZ0KRMz
 9B2TANhwKr5y1Fh5kD7s8VhKVoXD1fOQYIdXbcVycBAZd9Az29dhTeDdyx7jk5jIHuFj
 Vf1Mq00iKP2sWsmh4W2mPJut+jKflmjfhkthOMEoaBAi+wzu7kJGpNi53sQXT1qbSQ4k
 IBCw==
From: Joachim Wiberg <troglobit@gmail.com>
Date: Mon, 11 Apr 2022 10:40:53 +0200
Message-Id: <20220411084054.298807-2-troglobit@gmail.com>
In-Reply-To: <20220411084054.298807-1-troglobit@gmail.com>
References: <20220223172407.175865-1-troglobit@gmail.com>
 <20220411084054.298807-1-troglobit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v2 net-next 1/2] net: bridge: add support for host
	l2 mdb entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, Joachim Wiberg <troglobit@gmail.com>, "David S . Miller" <davem@davemloft.net>

This patch expands on the earlier work on layer-2 mdb entries by adding
support for host entries.  Due to the fact that host joined entries do
not have any flag field, we infer the permanent flag when reporting the
entries to userspace, which otherwise would be listed as 'temp'.

Before patch:

    ~# bridge mdb add dev br0 port br0 grp 01:00:00:c0:ff:ee permanent
    Error: bridge: Flags are not allowed for host groups.
    ~# bridge mdb add dev br0 port br0 grp 01:00:00:c0:ff:ee
    Error: bridge: Only permanent L2 entries allowed.

After patch:

    ~# bridge mdb add dev br0 port br0 grp 01:00:00:c0:ff:ee permanent
    ~# bridge mdb show
    dev br0 port br0 grp 01:00:00:c0:ff:ee permanent vid 1

Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mdb.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 4556d913955b..fdcc641fc89a 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -251,14 +251,16 @@ static int __mdb_fill_info(struct sk_buff *skb,
 	__mdb_entry_fill_flags(&e, flags);
 	e.ifindex = ifindex;
 	e.vid = mp->addr.vid;
-	if (mp->addr.proto == htons(ETH_P_IP))
+	if (mp->addr.proto == htons(ETH_P_IP)) {
 		e.addr.u.ip4 = mp->addr.dst.ip4;
 #if IS_ENABLED(CONFIG_IPV6)
-	else if (mp->addr.proto == htons(ETH_P_IPV6))
+	} else if (mp->addr.proto == htons(ETH_P_IPV6)) {
 		e.addr.u.ip6 = mp->addr.dst.ip6;
 #endif
-	else
+	} else {
 		ether_addr_copy(e.addr.u.mac_addr, mp->addr.dst.mac_addr);
+		e.state = MDB_PG_FLAGS_PERMANENT;
+	}
 	e.addr.proto = mp->addr.proto;
 	nest_ent = nla_nest_start_noflag(skb,
 					 MDBA_MDB_ENTRY_INFO);
@@ -873,8 +875,8 @@ static int br_mdb_add_group(struct net_bridge *br, struct net_bridge_port *port,
 		return -EINVAL;
 
 	/* host join errors which can happen before creating the group */
-	if (!port) {
-		/* don't allow any flags for host-joined groups */
+	if (!port && !br_group_is_l2(&group)) {
+		/* don't allow any flags for host-joined IP groups */
 		if (entry->state) {
 			NL_SET_ERR_MSG_MOD(extack, "Flags are not allowed for host groups");
 			return -EINVAL;
-- 
2.25.1

