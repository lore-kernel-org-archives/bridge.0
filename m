Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=egLzN7/s9/QZ3qlg41Rj8BKSB1yfeA3ZGBvqcFvmni0=;
 b=XoRKm7gWr72tnpuMrPmdTcwkzSX48VLbwDbDflfb7NstKPnbU6B7PsuSPmIzYL50Uk
 p49Py1tQHUeOPMQE3filRxSm8yXFyQQdgeV0fwXFHuOghxb8NcpWKEZkvGaJgbcfrMtc
 gJZNiktJqYfNN7vMv67fU4LviUN54RuWPGdEAgcu2hr5SRx4Az+nVJVRXpTWMV/BMkkk
 aQ7oUhkBufIfJvH+UfMstsyY5AbzhtLje+zSDBLC6lhzXTFLYkn4/dmDPto6zNDM/hJ0
 ego4SqcnkzljllnqpdOqFuF9hb7QhxqTXILj98Oja19NBcuEZxNPlS4JOrL1zPugbxe+
 E3pA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 12 Apr 2022 16:22:45 +0300
Message-Id: <20220412132245.2148794-9-razor@blackwall.org>
In-Reply-To: <20220412132245.2148794-1-razor@blackwall.org>
References: <20220412132245.2148794-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v3 8/8] net: bridge: fdb: add support for
	flush filtering based on ifindex and vlan
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
rtnl_fdb_flush, we just need to fill it in.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: validate ifindex and fill in vlan id
v3: NDFA -> NDA attributes

 net/bridge/br_fdb.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index bbb00a75ef0a..c44ea83ac3d9 100644
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
 	struct net_bridge *br;
 
 	if (netif_is_bridge_master(dev)) {
@@ -663,6 +695,14 @@ int br_fdb_delete_bulk(struct ndmsg *ndm, struct nlattr *tb[],
 
 		desc.flags_mask |= __ndm_flags_to_fdb_flags(ndm_flags_mask);
 	}
+	if (tb[NDA_IFINDEX]) {
+		int err, ifidx = nla_get_s32(tb[NDA_IFINDEX]);
+
+		err = __fdb_flush_validate_ifindex(br, ifidx, extack);
+		if (err)
+			return err;
+		desc.port_ifindex = ifidx;
+	}
 
 	br_debug(br, "flushing port ifindex: %d vlan id: %u flags: 0x%lx flags mask: 0x%lx\n",
 		 desc.port_ifindex, desc.vlan_id, desc.flags, desc.flags_mask);
-- 
2.35.1

