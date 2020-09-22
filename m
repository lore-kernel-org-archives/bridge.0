Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pqwHkNx0jImltrLZO0K43fN+lXj/WQjYzW88BeELohU=;
 b=atRRHV9IlbTQawV3JVthS769j53S90jNCkYuH9B+dQM2RTPH5FlrA5YVZDU7ESZFJD
 pANEzYV9YHskDwxh9dZ8esmtW0WMbthCczLIgxwqy6ql5KGM1ZT7YfYKF/xR5UuPfiw3
 8qooEFNTKmD2BhzKSnRiomdsYrQJXDItfh0szas17vzBM2CsoVLNdpgingW1lOkoG5FQ
 CXZV4qFSpxllbiIAB8DW290Po6LtqBNwyVnbYQr95cfVhmGzMwGG764H00BEBpP44Ldz
 DXkBQ1slvuRrDgf0eYMrLE52firaHKNxLC80cBY+/x2hUSgZuaZowKG/m7bKS/nkxMb6
 za5A==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 22 Sep 2020 10:30:18 +0300
Message-Id: <20200922073027.1196992-8-razor@blackwall.org>
In-Reply-To: <20200922073027.1196992-1-razor@blackwall.org>
References: <20200922073027.1196992-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 07/16] net: bridge: mdb: add support to
	extend add/del commands
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Since the MDB add/del code expects an exact struct br_mdb_entry we can't
really add any extensions, thus add a new nested attribute at the level of
MDBA_SET_ENTRY called MDBA_SET_ENTRY_ATTRS which will be used to pass
all new options via netlink attributes. This patch doesn't change
anything functionally since the new attribute is not used yet, only
parsed.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 include/uapi/linux/if_bridge.h | 12 ++++++++++++
 net/bridge/br_mdb.c            | 22 +++++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 75a2ac479247..dc52f8cffa0d 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -530,10 +530,22 @@ struct br_mdb_entry {
 enum {
 	MDBA_SET_ENTRY_UNSPEC,
 	MDBA_SET_ENTRY,
+	MDBA_SET_ENTRY_ATTRS,
 	__MDBA_SET_ENTRY_MAX,
 };
 #define MDBA_SET_ENTRY_MAX (__MDBA_SET_ENTRY_MAX - 1)
 
+/* [MDBA_SET_ENTRY_ATTRS] = {
+ *    [MDBE_ATTR_xxx]
+ *    ...
+ * }
+ */
+enum {
+	MDBE_ATTR_UNSPEC,
+	__MDBE_ATTR_MAX,
+};
+#define MDBE_ATTR_MAX (__MDBE_ATTR_MAX - 1)
+
 /* Embedded inside LINK_XSTATS_TYPE_BRIDGE */
 enum {
 	BRIDGE_XSTATS_UNSPEC,
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index a1ff0a372185..907df6d695ec 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -670,9 +670,12 @@ static bool is_valid_mdb_entry(struct br_mdb_entry *entry,
 	return true;
 }
 
+static const struct nla_policy br_mdbe_attrs_pol[MDBE_ATTR_MAX + 1] = {
+};
+
 static int br_mdb_parse(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct net_device **pdev, struct br_mdb_entry **pentry,
-			struct netlink_ext_ack *extack)
+			struct nlattr **mdb_attrs, struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
 	struct br_mdb_entry *entry;
@@ -719,6 +722,17 @@ static int br_mdb_parse(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EINVAL;
 	*pentry = entry;
 
+	if (tb[MDBA_SET_ENTRY_ATTRS]) {
+		err = nla_parse_nested(mdb_attrs, MDBE_ATTR_MAX,
+				       tb[MDBA_SET_ENTRY_ATTRS],
+				       br_mdbe_attrs_pol, extack);
+		if (err)
+			return err;
+	} else {
+		memset(mdb_attrs, 0,
+		       sizeof(struct nlattr *) * (MDBE_ATTR_MAX + 1));
+	}
+
 	return 0;
 }
 
@@ -803,6 +817,7 @@ static int __br_mdb_add(struct net *net, struct net_bridge *br,
 static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		      struct netlink_ext_ack *extack)
 {
+	struct nlattr *mdb_attrs[MDBE_ATTR_MAX + 1];
 	struct net *net = sock_net(skb->sk);
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_port *p = NULL;
@@ -812,7 +827,7 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net_bridge *br;
 	int err;
 
-	err = br_mdb_parse(skb, nlh, &dev, &entry, extack);
+	err = br_mdb_parse(skb, nlh, &dev, &entry, mdb_attrs, extack);
 	if (err < 0)
 		return err;
 
@@ -921,6 +936,7 @@ static int __br_mdb_del(struct net_bridge *br, struct br_mdb_entry *entry)
 static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 		      struct netlink_ext_ack *extack)
 {
+	struct nlattr *mdb_attrs[MDBE_ATTR_MAX + 1];
 	struct net *net = sock_net(skb->sk);
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_port *p = NULL;
@@ -930,7 +946,7 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net_bridge *br;
 	int err;
 
-	err = br_mdb_parse(skb, nlh, &dev, &entry, extack);
+	err = br_mdb_parse(skb, nlh, &dev, &entry, mdb_attrs, extack);
 	if (err < 0)
 		return err;
 
-- 
2.25.4

