Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=EW+6AvSLzUYJxeji2mVd2Q1VYO3NHO/LYR1JxyZ6kvU=;
	b=S/xvscTkR2xIOirXThIGvGDBdnu2fBqMGTaoVdqnO3YoDG8zz38QeHOopjQLiDFe8Z
	XNulE2hhqAAAUbwfMrhVxxqTFiPT+TDbU719EeMbIrGbxFLmG1qIyv/i1UoK/xbK9tfn
	vtQ4HAoBwHBIDZIK1q47yv0KHbA731GYjQNQY=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sat, 17 Aug 2019 14:22:11 +0300
Message-Id: <20190817112213.27097-3-nikolay@cumulusnetworks.com>
In-Reply-To: <20190817112213.27097-1-nikolay@cumulusnetworks.com>
References: <20190816.130417.1610388599335442981.davem@davemloft.net>
	<20190817112213.27097-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v3 2/4] net: bridge: mdb: factor out mdb
	filling
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

We have to factor out the mdb fill portion in order to re-use it later for
the bridge mdb entries. No functional changes intended.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_mdb.c | 68 ++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index ee6208c6d946..77730983097e 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -77,6 +77,40 @@ static void __mdb_entry_to_br_ip(struct br_mdb_entry *entry, struct br_ip *ip)
 #endif
 }
 
+static int __mdb_fill_info(struct sk_buff *skb,
+			   struct net_bridge_port_group *p)
+{
+	struct nlattr *nest_ent;
+	struct br_mdb_entry e;
+
+	memset(&e, 0, sizeof(e));
+	__mdb_entry_fill_flags(&e, p->flags);
+	e.ifindex = p->port->dev->ifindex;
+	e.vid = p->addr.vid;
+	if (p->addr.proto == htons(ETH_P_IP))
+		e.addr.u.ip4 = p->addr.u.ip4;
+#if IS_ENABLED(CONFIG_IPV6)
+	if (p->addr.proto == htons(ETH_P_IPV6))
+		e.addr.u.ip6 = p->addr.u.ip6;
+#endif
+	e.addr.proto = p->addr.proto;
+	nest_ent = nla_nest_start_noflag(skb,
+					 MDBA_MDB_ENTRY_INFO);
+	if (!nest_ent)
+		return -EMSGSIZE;
+
+	if (nla_put_nohdr(skb, sizeof(e), &e) ||
+	    nla_put_u32(skb,
+			MDBA_MDB_EATTR_TIMER,
+			br_timer_value(&p->timer))) {
+		nla_nest_cancel(skb, nest_ent);
+		return -EMSGSIZE;
+	}
+	nla_nest_end(skb, nest_ent);
+
+	return 0;
+}
+
 static int br_mdb_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 			    struct net_device *dev)
 {
@@ -95,7 +129,6 @@ static int br_mdb_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 	hlist_for_each_entry_rcu(mp, &br->mdb_list, mdb_node) {
 		struct net_bridge_port_group *p;
 		struct net_bridge_port_group __rcu **pp;
-		struct net_bridge_port *port;
 
 		if (idx < s_idx)
 			goto skip;
@@ -108,41 +141,14 @@ static int br_mdb_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 
 		for (pp = &mp->ports; (p = rcu_dereference(*pp)) != NULL;
 		      pp = &p->next) {
-			struct nlattr *nest_ent;
-			struct br_mdb_entry e;
-
-			port = p->port;
-			if (!port)
+			if (!p->port)
 				continue;
 
-			memset(&e, 0, sizeof(e));
-			e.ifindex = port->dev->ifindex;
-			e.vid = p->addr.vid;
-			__mdb_entry_fill_flags(&e, p->flags);
-			if (p->addr.proto == htons(ETH_P_IP))
-				e.addr.u.ip4 = p->addr.u.ip4;
-#if IS_ENABLED(CONFIG_IPV6)
-			if (p->addr.proto == htons(ETH_P_IPV6))
-				e.addr.u.ip6 = p->addr.u.ip6;
-#endif
-			e.addr.proto = p->addr.proto;
-			nest_ent = nla_nest_start_noflag(skb,
-							 MDBA_MDB_ENTRY_INFO);
-			if (!nest_ent) {
-				nla_nest_cancel(skb, nest2);
-				err = -EMSGSIZE;
-				goto out;
-			}
-			if (nla_put_nohdr(skb, sizeof(e), &e) ||
-			    nla_put_u32(skb,
-					MDBA_MDB_EATTR_TIMER,
-					br_timer_value(&p->timer))) {
-				nla_nest_cancel(skb, nest_ent);
+			err = __mdb_fill_info(skb, p);
+			if (err) {
 				nla_nest_cancel(skb, nest2);
-				err = -EMSGSIZE;
 				goto out;
 			}
-			nla_nest_end(skb, nest_ent);
 		}
 		nla_nest_end(skb, nest2);
 skip:
-- 
2.21.0

