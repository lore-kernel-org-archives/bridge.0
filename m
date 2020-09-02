Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PxlKJ4ahUAq7ZO378zucziaWSAnWLkeVKcRNgDqTEgE=;
 b=hzyzT4z9tsJSGX5KsB78lEvOa14nrrCThaXwCAD6/HtTDRPJO+3rLAqoMht+ulFrPh
 UzhXV5wmjS2kCV7q5voNdfCgSvlglGxSEn1BLhnbjPJpb/LRFNqH+m4trypod2HA4skX
 vP/K7MeuGZmzjwmN70ENE9Pl9NCyMJq9Zy1/E=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed,  2 Sep 2020 14:25:17 +0300
Message-Id: <20200902112529.1570040-4-nikolay@cumulusnetworks.com>
In-Reply-To: <20200902112529.1570040-1-nikolay@cumulusnetworks.com>
References: <20200902112529.1570040-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 03/15] net: bridge: mcast: add support
	for src list and filter mode dumping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

Support per port group src list (address and timer) and filter mode
dumping. Protected by either multicast_lock or rcu and currently
limited only to IPv4.

v2: require RCU or multicast_lock to traverse src groups

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/if_bridge.h | 21 +++++++++++
 net/bridge/br_mdb.c            | 67 +++++++++++++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index c1227aecd38f..75a2ac479247 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -455,10 +455,31 @@ enum {
 enum {
 	MDBA_MDB_EATTR_UNSPEC,
 	MDBA_MDB_EATTR_TIMER,
+	MDBA_MDB_EATTR_SRC_LIST,
+	MDBA_MDB_EATTR_GROUP_MODE,
 	__MDBA_MDB_EATTR_MAX
 };
 #define MDBA_MDB_EATTR_MAX (__MDBA_MDB_EATTR_MAX - 1)
 
+/* per mdb entry source */
+enum {
+	MDBA_MDB_SRCLIST_UNSPEC,
+	MDBA_MDB_SRCLIST_ENTRY,
+	__MDBA_MDB_SRCLIST_MAX
+};
+#define MDBA_MDB_SRCLIST_MAX (__MDBA_MDB_SRCLIST_MAX - 1)
+
+/* per mdb entry per source attributes
+ * these are embedded in MDBA_MDB_SRCLIST_ENTRY
+ */
+enum {
+	MDBA_MDB_SRCATTR_UNSPEC,
+	MDBA_MDB_SRCATTR_ADDRESS,
+	MDBA_MDB_SRCATTR_TIMER,
+	__MDBA_MDB_SRCATTR_MAX
+};
+#define MDBA_MDB_SRCATTR_MAX (__MDBA_MDB_SRCATTR_MAX - 1)
+
 /* multicast router types */
 enum {
 	MDB_RTR_TYPE_DISABLED,
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 025a5aff2b2f..7d4d064a49e3 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -77,6 +77,53 @@ static void __mdb_entry_to_br_ip(struct br_mdb_entry *entry, struct br_ip *ip)
 #endif
 }
 
+static int __mdb_fill_srcs(struct sk_buff *skb,
+			   struct net_bridge_port_group *p)
+{
+	struct net_bridge_group_src *ent;
+	struct nlattr *nest, *nest_ent;
+
+	if (hlist_empty(&p->src_list))
+		return 0;
+
+	nest = nla_nest_start(skb, MDBA_MDB_EATTR_SRC_LIST);
+	if (!nest)
+		return -EMSGSIZE;
+
+	hlist_for_each_entry_rcu(ent, &p->src_list, node,
+				 lockdep_is_held(&p->port->br->multicast_lock)) {
+		nest_ent = nla_nest_start(skb, MDBA_MDB_SRCLIST_ENTRY);
+		if (!nest_ent)
+			goto out_cancel_err;
+		switch (ent->addr.proto) {
+		case htons(ETH_P_IP):
+			if (nla_put_in_addr(skb, MDBA_MDB_SRCATTR_ADDRESS,
+					    ent->addr.u.ip4)) {
+				nla_nest_cancel(skb, nest_ent);
+				goto out_cancel_err;
+			}
+			break;
+		default:
+			nla_nest_cancel(skb, nest_ent);
+			continue;
+		}
+		if (nla_put_u32(skb, MDBA_MDB_SRCATTR_TIMER,
+				br_timer_value(&ent->timer))) {
+			nla_nest_cancel(skb, nest_ent);
+			goto out_cancel_err;
+		}
+		nla_nest_end(skb, nest_ent);
+	}
+
+	nla_nest_end(skb, nest);
+
+	return 0;
+
+out_cancel_err:
+	nla_nest_cancel(skb, nest);
+	return -EMSGSIZE;
+}
+
 static int __mdb_fill_info(struct sk_buff *skb,
 			   struct net_bridge_mdb_entry *mp,
 			   struct net_bridge_port_group *p)
@@ -119,6 +166,15 @@ static int __mdb_fill_info(struct sk_buff *skb,
 		nla_nest_cancel(skb, nest_ent);
 		return -EMSGSIZE;
 	}
+	if (p &&
+	    mp->br->multicast_igmp_version == 3 &&
+	    mp->addr.proto == htons(ETH_P_IP) &&
+	    (__mdb_fill_srcs(skb, p) ||
+	     nla_put_u8(skb, MDBA_MDB_EATTR_GROUP_MODE, p->filter_mode))) {
+		nla_nest_cancel(skb, nest_ent);
+		return -EMSGSIZE;
+	}
+
 	nla_nest_end(skb, nest_ent);
 
 	return 0;
@@ -127,7 +183,7 @@ static int __mdb_fill_info(struct sk_buff *skb,
 static int br_mdb_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 			    struct net_device *dev)
 {
-	int idx = 0, s_idx = cb->args[1], err = 0;
+	int idx = 0, s_idx = cb->args[1], err = 0, pidx = 0, s_pidx = cb->args[2];
 	struct net_bridge *br = netdev_priv(dev);
 	struct net_bridge_mdb_entry *mp;
 	struct nlattr *nest, *nest2;
@@ -152,7 +208,7 @@ static int br_mdb_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 			break;
 		}
 
-		if (mp->host_joined) {
+		if (!s_pidx && mp->host_joined) {
 			err = __mdb_fill_info(skb, mp, NULL);
 			if (err) {
 				nla_nest_cancel(skb, nest2);
@@ -164,13 +220,19 @@ static int br_mdb_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 		      pp = &p->next) {
 			if (!p->port)
 				continue;
+			if (pidx < s_pidx)
+				goto skip_pg;
 
 			err = __mdb_fill_info(skb, mp, p);
 			if (err) {
 				nla_nest_cancel(skb, nest2);
 				goto out;
 			}
+skip_pg:
+			pidx++;
 		}
+		pidx = 0;
+		s_pidx = 0;
 		nla_nest_end(skb, nest2);
 skip:
 		idx++;
@@ -178,6 +240,7 @@ static int br_mdb_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 
 out:
 	cb->args[1] = idx;
+	cb->args[2] = pidx;
 	nla_nest_end(skb, nest);
 	return err;
 }
-- 
2.25.4

