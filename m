Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ByfL8z/R6BuRgwZqTxWQ31zr/BQkKOOXCLKFqhleuTY=;
 b=ilhuW9/NCRq4MTKKfWSDcWFxlWcnsF2ZZozvoMJG02Aiw6o1FZiMM93nJSKtnNfLWI
 OPN7XWVHpxnl+tP18PkJud6MfyjAWUorgmDYQdfVl3dbUTvMK0fIqxcInmuOFSQFmq6l
 ypvTJJ1pGUzjZJaaBaB3X+FDpSB3ALFjZzuALMG9ZKj4OFleKGGrtWhL5CIvdJZQyp8j
 +pg1P7f5FQAxjdPVVbyPotaNcXjxy1ieOy/Bq5U1b0xpt32co5tOSnijoKHmL1gODEjq
 hJmrlLC8K21YWB5fRAiYJbPb/wEWDPafq8z0g1N9MBDvt4jzGzwPQvg/A9QN8L3wNSx7
 FZMQ==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Sat,  9 Apr 2022 13:58:54 +0300
Message-Id: <20220409105857.803667-4-razor@blackwall.org>
In-Reply-To: <20220409105857.803667-1-razor@blackwall.org>
References: <20220409105857.803667-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 3/6] net: bridge: fdb: add new nl
	attribute-based flush call
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

Add a new fdb flush call which parses the embedded attributes in
BRIDGE_FLUSH_FDB and fills in the fdb flush descriptor to delete only
matching entries. Currently it's a complete flush, support for more
fine-grained filtering will be added in the following patches.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/uapi/linux/if_bridge.h |  8 ++++++++
 net/bridge/br_fdb.c            | 24 ++++++++++++++++++++++++
 net/bridge/br_netlink.c        |  8 ++++++++
 net/bridge/br_private.h        |  2 ++
 4 files changed, 42 insertions(+)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 221a4256808f..2f3799cf14b2 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -807,7 +807,15 @@ enum {
 /* embedded in IFLA_BRIDGE_FLUSH */
 enum {
 	BRIDGE_FLUSH_UNSPEC,
+	BRIDGE_FLUSH_FDB,
 	__BRIDGE_FLUSH_MAX
 };
 #define BRIDGE_FLUSH_MAX (__BRIDGE_FLUSH_MAX - 1)
+
+/* embedded in BRIDGE_FLUSH_FDB */
+enum {
+	FDB_FLUSH_UNSPEC,
+	__FDB_FLUSH_MAX
+};
+#define FDB_FLUSH_MAX (__FDB_FLUSH_MAX - 1)
 #endif /* _UAPI_LINUX_IF_BRIDGE_H */
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 4b0bf88c4121..62f694a739e1 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -594,6 +594,30 @@ void br_fdb_flush(struct net_bridge *br,
 	rcu_read_unlock();
 }
 
+static const struct nla_policy br_fdb_flush_policy[FDB_FLUSH_MAX + 1] = {
+	[FDB_FLUSH_UNSPEC]	= { .type = NLA_REJECT },
+};
+
+int br_fdb_flush_nlattr(struct net_bridge *br, struct nlattr *fdb_flush_attr,
+			struct netlink_ext_ack *extack)
+{
+	struct nlattr *fdb_flush_tb[FDB_FLUSH_MAX + 1];
+	struct net_bridge_fdb_flush_desc desc = {};
+	int err;
+
+	err = nla_parse_nested(fdb_flush_tb, FDB_FLUSH_MAX, fdb_flush_attr,
+			       br_fdb_flush_policy, extack);
+	if (err)
+		return err;
+
+	br_debug(br, "flushing port ifindex: %d vlan id: %u flags: 0x%lx flags mask: 0x%lx\n",
+		 desc.port_ifindex, desc.vlan_id, desc.flags, desc.flags_mask);
+
+	br_fdb_flush(br, &desc);
+
+	return 0;
+}
+
 /* Flush all entries referring to a specific port.
  * if do_all is set also flush static entries
  * if vid is set delete all entries that match the vlan_id
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 6e6dce6880c9..bd2c91e5723d 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -781,6 +781,7 @@ int br_process_vlan_info(struct net_bridge *br,
 
 static const struct nla_policy br_flush_policy[BRIDGE_FLUSH_MAX + 1] = {
 	[BRIDGE_FLUSH_UNSPEC]	= { .type = NLA_REJECT },
+	[BRIDGE_FLUSH_FDB]	= { .type = NLA_NESTED },
 };
 
 static int br_flush(struct net_bridge *br, int cmd,
@@ -804,6 +805,13 @@ static int br_flush(struct net_bridge *br, int cmd,
 	if (err)
 		return err;
 
+	if (flush_tb[BRIDGE_FLUSH_FDB]) {
+		err = br_fdb_flush_nlattr(br, flush_tb[BRIDGE_FLUSH_FDB],
+					  extack);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index e6930e9ee69d..c7ea531d30ef 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -768,6 +768,8 @@ int br_fdb_hash_init(struct net_bridge *br);
 void br_fdb_hash_fini(struct net_bridge *br);
 void br_fdb_flush(struct net_bridge *br,
 		  const struct net_bridge_fdb_flush_desc *desc);
+int br_fdb_flush_nlattr(struct net_bridge *br, struct nlattr *fdb_flush_attr,
+			struct netlink_ext_ack *extack);
 void br_fdb_find_delete_local(struct net_bridge *br,
 			      const struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid);
-- 
2.35.1

