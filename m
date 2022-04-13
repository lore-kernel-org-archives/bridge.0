Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mqsQMGWoSGIiSBxMnK2lmj4CXMMwYXskZS4euBUat3E=;
 b=CqDiUuwWy9Ar00ARP8AYHLDoMiZ0B5XU5oPXE/n2LzKIKzDb49qspNm4EVvgWriuLB
 KZinTcU15VppmpjZEA9orOK8DU7Fo2EdjIq516B5dDIi3jLwGJ4d1e3sGe2O+aDhJKY+
 H9VjOjlcifF4ptjMaqMKm55ysi4GaMzGDDfudxGhosRVz+6ueUxA+jloInbsRhcDb53O
 BwZTcmhYey2vPRJNCxvZxI2Xuz5WeRJyvv6jWAxY+JB7qlxOUvKlNqP06BAXFyx5wTRW
 u2a2YqRGR7QoqxFD7gp5t4D9kXT208DcQkRoSH6JOZTt+0/FHhUaA1KOsD5huESnC9iO
 hKvw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 13 Apr 2022 13:52:02 +0300
Message-Id: <20220413105202.2616106-13-razor@blackwall.org>
In-Reply-To: <20220413105202.2616106-1-razor@blackwall.org>
References: <20220413105202.2616106-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v4 12/12] net: bridge: fdb: add support
	for flush filtering based on ifindex and vlan
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

Add support for fdb flush filtering based on destination ifindex and
vlan id. The ifindex must either match a port's device ifindex or the
bridge's. The vlan support is trivial since it's already validated by
rtnl_fdb_del, we just need to fill it in.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: validate ifindex and fill in vlan id
v3: NDFA -> NDA attributes
v4: use port's ifindex if NTF_MASTER is used and NDA_IFINDEX is not
    specified

 net/bridge/br_fdb.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 74d759d09f94..1a3d583fbc8e 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -622,12 +622,44 @@ static unsigned long __ndm_flags_to_fdb_flags(u8 ndm_flags)
 	return flags;
 }
 
+static int __fdb_flush_validate_ifindex(const struct net_bridge *br,
+					int ifindex,
+					struct netlink_ext_ack *extack)
+{
+	const struct net_device *dev;
+
+	dev = __dev_get_by_index(dev_net(br->dev), ifindex);
+	if (!dev) {
+		NL_SET_ERR_MSG_MOD(extack, "Unknown flush device ifindex");
+		return -ENODEV;
+	}
+	if (!netif_is_bridge_master(dev) && !netif_is_bridge_port(dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Flush device is not a bridge or bridge port");
+		return -EINVAL;
+	}
+	if (netif_is_bridge_master(dev) && dev != br->dev) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Flush bridge device does not match target bridge device");
+		return -EINVAL;
+	}
+	if (netif_is_bridge_port(dev)) {
+		struct net_bridge_port *p = br_port_get_rtnl(dev);
+
+		if (p->br != br) {
+			NL_SET_ERR_MSG_MOD(extack, "Port belongs to a different bridge device");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 int br_fdb_delete_bulk(struct ndmsg *ndm, struct nlattr *tb[],
 		       struct net_device *dev, u16 vid,
 		       struct netlink_ext_ack *extack)
 {
 	u8 ndm_flags = ndm->ndm_flags & ~FDB_FLUSH_IGNORED_NDM_FLAGS;
-	struct net_bridge_fdb_flush_desc desc = {};
+	struct net_bridge_fdb_flush_desc desc = { .vlan_id = vid };
 	struct net_bridge_port *p = NULL;
 	struct net_bridge *br;
 
@@ -663,6 +695,17 @@ int br_fdb_delete_bulk(struct ndmsg *ndm, struct nlattr *tb[],
 
 		desc.flags_mask |= __ndm_flags_to_fdb_flags(ndm_flags_mask);
 	}
+	if (tb[NDA_IFINDEX]) {
+		int err, ifidx = nla_get_s32(tb[NDA_IFINDEX]);
+
+		err = __fdb_flush_validate_ifindex(br, ifidx, extack);
+		if (err)
+			return err;
+		desc.port_ifindex = ifidx;
+	} else if (p) {
+		/* flush was invoked with port device and NTF_MASTER */
+		desc.port_ifindex = p->dev->ifindex;
+	}
 
 	br_debug(br, "flushing port ifindex: %d vlan id: %u flags: 0x%lx flags mask: 0x%lx\n",
 		 desc.port_ifindex, desc.vlan_id, desc.flags, desc.flags_mask);
-- 
2.35.1

