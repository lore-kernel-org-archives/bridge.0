Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rJB5kY6uPDJBtefnM9IfoNFJA4wwW57RZ1b7IzeHqA8=;
 b=hFdUSE4bdm3dm9ztdRKdeW/8cbk4xAYciXTuexkfId9nwCQCdmTBDzeHXaqgfzjQeN
 TZ/NsAKsRRvweTRt2EAW52YSO+2mnhtdOAADDKVaHA29uMQoS03VdTeW+86igTTMvECm
 ACUEP0LU5+tvPzhM4FJMzoBBmtRsIdRlXdQybuROhvIA4uHgrdlQvGSuaUsKQsOfSfVd
 RAybgRhJX6iwXEaoer6mxl6iJv8mrCSldsW804bEl+UIOMiYiD/oT8/MH7A8qdcFgKGj
 f5lFRyib564wGTYRT586IEXe6XyOsMfYecXCpGxRiZOTZQWKxMFiVOVTROU+brqsTDm6
 xBow==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 13 Apr 2022 13:51:58 +0300
Message-Id: <20220413105202.2616106-9-razor@blackwall.org>
In-Reply-To: <20220413105202.2616106-1-razor@blackwall.org>
References: <20220413105202.2616106-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v4 08/12] net: bridge: fdb: add
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
v4: don't rename br_fdb_flush

 net/bridge/br_device.c  |  1 +
 net/bridge/br_fdb.c     | 23 +++++++++++++++++++++++
 net/bridge/br_private.h |  3 +++
 3 files changed, 27 insertions(+)

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
index 6ccda68bd473..363985f1a540 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -572,6 +572,29 @@ void br_fdb_flush(struct net_bridge *br)
 	spin_unlock_bh(&br->hash_lock);
 }
 
+int br_fdb_delete_bulk(struct ndmsg *ndm, struct nlattr *tb[],
+		       struct net_device *dev, u16 vid,
+		       struct netlink_ext_ack *extack)
+{
+	struct net_bridge_port *p = NULL;
+	struct net_bridge *br;
+
+	if (netif_is_bridge_master(dev)) {
+		br = netdev_priv(dev);
+	} else {
+		p = br_port_get_rtnl(dev);
+		if (!p) {
+			NL_SET_ERR_MSG_MOD(extack, "Device is not a bridge port");
+			return -EINVAL;
+		}
+		br = p->br;
+	}
+
+	br_fdb_flush(br);
+
+	return 0;
+}
+
 /* Flush all entries referring to a specific port.
  * if do_all is set also flush static entries
  * if vid is set delete all entries that match the vlan_id
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 6e62af2e07e9..f37d49bf5637 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -781,6 +781,9 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 
 int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 		  struct net_device *dev, const unsigned char *addr, u16 vid);
+int br_fdb_delete_bulk(struct ndmsg *ndm, struct nlattr *tb[],
+		       struct net_device *dev, u16 vid,
+		       struct netlink_ext_ack *extack);
 int br_fdb_add(struct ndmsg *nlh, struct nlattr *tb[], struct net_device *dev,
 	       const unsigned char *addr, u16 vid, u16 nlh_flags,
 	       struct netlink_ext_ack *extack);
-- 
2.35.1

