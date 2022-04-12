Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JYUem4jVllKE4fErwzsUEmzSIjtFH958yAp/oX4NO6c=;
 b=rhgdR0Yr5H06JUf05oWHKLjjoT1+tiA41ga1HncvSzBN67TKCJsdCCEqd6jqMmJXD3
 dZCOja0r6B4mxTixieRUYUcCpO75IrzSvrWrJArRnTIpe4U8tTcGb0g13MH64I4rTf1+
 xCwLEQfYai8lpSPGqaOD7hYfImpGgtaC4Acf/mV5PbGMbl83Hp07d5gTup62BQwWyfvW
 uQGG3ka1JWgwF+ByBRSuDWTOq4HrwCVhSd/D8dCZx5VylmN3AVcFqZ94K896EB73whOk
 qdWS/v/o3GNUfzRAl3Uk92LlcpN3szWQEFpjOuxf15cIhm8T1WDNXrWXCkZyxeF2o19F
 5O3A==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 12 Apr 2022 16:22:41 +0300
Message-Id: <20220412132245.2148794-5-razor@blackwall.org>
In-Reply-To: <20220412132245.2148794-1-razor@blackwall.org>
References: <20220412132245.2148794-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v3 4/8] net: bridge: fdb: add
	ndo_fdb_del_bulk
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>, dsahern@kernel.org, bridge@lists.linux-foundation.org, idosch@idosch.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Add a minimal ndo_fdb_del_bulk implementation which flushes all entries.
Support for more fine-grained filtering will be added in the following
patches.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_device.c   |  1 +
 net/bridge/br_fdb.c      | 25 ++++++++++++++++++++++++-
 net/bridge/br_netlink.c  |  2 +-
 net/bridge/br_private.h  |  6 +++++-
 net/bridge/br_sysfs_br.c |  2 +-
 5 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 8d6bab244c4a..58a4f70e01e3 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -465,6 +465,7 @@ static const struct net_device_ops br_netdev_ops = {
 	.ndo_fix_features        = br_fix_features,
 	.ndo_fdb_add		 = br_fdb_add,
 	.ndo_fdb_del		 = br_fdb_delete,
+	.ndo_fdb_del_bulk	 = br_fdb_delete_bulk,
 	.ndo_fdb_dump		 = br_fdb_dump,
 	.ndo_fdb_get		 = br_fdb_get,
 	.ndo_bridge_getlink	 = br_getlink,
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 6ccda68bd473..fd7012c32cd5 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -559,7 +559,7 @@ void br_fdb_cleanup(struct work_struct *work)
 }
 
 /* Completely flush all dynamic entries in forwarding database.*/
-void br_fdb_flush(struct net_bridge *br)
+void __br_fdb_flush(struct net_bridge *br)
 {
 	struct net_bridge_fdb_entry *f;
 	struct hlist_node *tmp;
@@ -572,6 +572,29 @@ void br_fdb_flush(struct net_bridge *br)
 	spin_unlock_bh(&br->hash_lock);
 }
 
+int br_fdb_delete_bulk(struct ndmsg *ndm, struct nlattr *tb[],
+		       struct net_device *dev, u16 vid,
+		       struct netlink_ext_ack *extack)
+{
+	struct net_bridge *br;
+
+	if (netif_is_bridge_master(dev)) {
+		br = netdev_priv(dev);
+	} else {
+		struct net_bridge_port *p = br_port_get_rtnl(dev);
+
+		if (!p) {
+			NL_SET_ERR_MSG_MOD(extack, "Device is not a bridge port");
+			return -EINVAL;
+		}
+		br = p->br;
+	}
+
+	__br_fdb_flush(br);
+
+	return 0;
+}
+
 /* Flush all entries referring to a specific port.
  * if do_all is set also flush static entries
  * if vid is set delete all entries that match the vlan_id
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 200ad05b296f..c59c775730bb 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1327,7 +1327,7 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 	}
 
 	if (data[IFLA_BR_FDB_FLUSH])
-		br_fdb_flush(br);
+		__br_fdb_flush(br);
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 	if (data[IFLA_BR_MCAST_ROUTER]) {
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 6e62af2e07e9..3ba50e41aa4f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -759,7 +759,8 @@ int br_fdb_init(void);
 void br_fdb_fini(void);
 int br_fdb_hash_init(struct net_bridge *br);
 void br_fdb_hash_fini(struct net_bridge *br);
-void br_fdb_flush(struct net_bridge *br);
+void __br_fdb_flush(struct net_bridge *br);
+
 void br_fdb_find_delete_local(struct net_bridge *br,
 			      const struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid);
@@ -781,6 +782,9 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 
 int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 		  struct net_device *dev, const unsigned char *addr, u16 vid);
+int br_fdb_delete_bulk(struct ndmsg *ndm, struct nlattr *tb[],
+		       struct net_device *dev, u16 vid,
+		       struct netlink_ext_ack *extack);
 int br_fdb_add(struct ndmsg *nlh, struct nlattr *tb[], struct net_device *dev,
 	       const unsigned char *addr, u16 vid, u16 nlh_flags,
 	       struct netlink_ext_ack *extack);
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 3f7ca88c2aa3..7a2cf3aebc84 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -344,7 +344,7 @@ static DEVICE_ATTR_RW(group_addr);
 static int set_flush(struct net_bridge *br, unsigned long val,
 		     struct netlink_ext_ack *extack)
 {
-	br_fdb_flush(br);
+	__br_fdb_flush(br);
 	return 0;
 }
 
-- 
2.35.1

