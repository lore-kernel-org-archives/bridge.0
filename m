Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=WcjxfoHTef+rzVi2MznJlfR9cVOKNUDGmg2Wkh7C8H8=;
	b=Utwkaw62Lg4PmWbws7n7Rj3e/UAUCuuEoj9JB5cS0tTC9lf4cvZboDuS7sG0Zfe5B9
	sb9tcSrRgQruzawSZs+IS4dfksrdfWbF64gCTUxcZzVtRNCXgXD4E1m59edporzJD5+j
	Vityu2nIT2VMuHAFqjPPLHFu8DwNWu7f+NrC4=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sat, 17 Aug 2019 14:22:12 +0300
Message-Id: <20190817112213.27097-4-nikolay@cumulusnetworks.com>
In-Reply-To: <20190817112213.27097-1-nikolay@cumulusnetworks.com>
References: <20190816.130417.1610388599335442981.davem@davemloft.net>
	<20190817112213.27097-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v3 3/4] net: bridge: mdb: dump host-joined
	entries as well
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

Currently we dump only the port mdb entries but we can have host-joined
entries on the bridge itself and they should be treated as normal temp
mdbs, they're already notified:
$ bridge monitor all
[MDB]dev br0 port br0 grp ff02::8 temp

The group will not be shown in the bridge mdb output, but it takes 1 slot
and it's timing out. If it's only host-joined then the mdb show output
can even be empty.

After this patch we show the host-joined groups:
$ bridge mdb show
dev br0 port br0 grp ff02::8 temp

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_mdb.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 77730983097e..985273425117 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -78,22 +78,35 @@ static void __mdb_entry_to_br_ip(struct br_mdb_entry *entry, struct br_ip *ip)
 }
 
 static int __mdb_fill_info(struct sk_buff *skb,
+			   struct net_bridge_mdb_entry *mp,
 			   struct net_bridge_port_group *p)
 {
+	struct timer_list *mtimer;
 	struct nlattr *nest_ent;
 	struct br_mdb_entry e;
+	u8 flags = 0;
+	int ifindex;
 
 	memset(&e, 0, sizeof(e));
-	__mdb_entry_fill_flags(&e, p->flags);
-	e.ifindex = p->port->dev->ifindex;
-	e.vid = p->addr.vid;
-	if (p->addr.proto == htons(ETH_P_IP))
-		e.addr.u.ip4 = p->addr.u.ip4;
+	if (p) {
+		ifindex = p->port->dev->ifindex;
+		mtimer = &p->timer;
+		flags = p->flags;
+	} else {
+		ifindex = mp->br->dev->ifindex;
+		mtimer = &mp->timer;
+	}
+
+	__mdb_entry_fill_flags(&e, flags);
+	e.ifindex = ifindex;
+	e.vid = mp->addr.vid;
+	if (mp->addr.proto == htons(ETH_P_IP))
+		e.addr.u.ip4 = mp->addr.u.ip4;
 #if IS_ENABLED(CONFIG_IPV6)
-	if (p->addr.proto == htons(ETH_P_IPV6))
-		e.addr.u.ip6 = p->addr.u.ip6;
+	if (mp->addr.proto == htons(ETH_P_IPV6))
+		e.addr.u.ip6 = mp->addr.u.ip6;
 #endif
-	e.addr.proto = p->addr.proto;
+	e.addr.proto = mp->addr.proto;
 	nest_ent = nla_nest_start_noflag(skb,
 					 MDBA_MDB_ENTRY_INFO);
 	if (!nest_ent)
@@ -102,7 +115,7 @@ static int __mdb_fill_info(struct sk_buff *skb,
 	if (nla_put_nohdr(skb, sizeof(e), &e) ||
 	    nla_put_u32(skb,
 			MDBA_MDB_EATTR_TIMER,
-			br_timer_value(&p->timer))) {
+			br_timer_value(mtimer))) {
 		nla_nest_cancel(skb, nest_ent);
 		return -EMSGSIZE;
 	}
@@ -139,12 +152,20 @@ static int br_mdb_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 			break;
 		}
 
+		if (mp->host_joined) {
+			err = __mdb_fill_info(skb, mp, NULL);
+			if (err) {
+				nla_nest_cancel(skb, nest2);
+				break;
+			}
+		}
+
 		for (pp = &mp->ports; (p = rcu_dereference(*pp)) != NULL;
 		      pp = &p->next) {
 			if (!p->port)
 				continue;
 
-			err = __mdb_fill_info(skb, p);
+			err = __mdb_fill_info(skb, mp, p);
 			if (err) {
 				nla_nest_cancel(skb, nest2);
 				goto out;
-- 
2.21.0

