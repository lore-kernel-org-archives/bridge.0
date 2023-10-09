Return-Path: <amcohen@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1629582010
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A8E9481EF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6W/GVUeEAPw+17+kc4Dg0u8hpieRTRnlYPZ0koB/I0I=;
 b=sBZgEZ0cOCh1BQF+xHR/vDIWPnzDJHalYkc1RjiYK6+fcOp0MB1G9dXRRX60jNuRqdOvZXqdtRYxxXcUEK5nf6vHIkWXSyu2i6HCC+Gf6gQjcNq+3Y1jyWPqgfHiFrpWvAV1UXARxJz4n1GaaBrzAC14K8ZCaFM97I0Iczb3jcA7Mg767lCzW6/Fc2Ai20UrLgZjhC+YJwEzIYE4USdvdi1YvuFwhggzWP1Fl62ww/Xr2xP8fXoWGBwiwZ5s1mYF1eUHMeDnZpsfVC1zGxlgYYHds6rOHCMxX4AjoIO0IrZlr3BbxiE1CT8E+zU7OYwghMpGfzzXGiGYxRexBo7bSg==
From: Amit Cohen <amcohen@nvidia.com>
Date: Mon, 9 Oct 2023 13:06:11 +0300
Message-ID: <20231009100618.2911374-5-amcohen@nvidia.com>
In-Reply-To: <20231009100618.2911374-1-amcohen@nvidia.com>
References: <20231009100618.2911374-1-amcohen@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 04/11] vxlan: vxlan_core: Add support for
	FDB flush
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>, razor@blackwall.org, Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com, dsahern@kernel.org, bridge@lists.linux-foundation.org, idosch@nvidia.com, linux-kselftest@vger.kernel.org, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, davem@davemloft.net

The merge commit 92716869375b ("Merge branch 'br-flush-filtering'")
added support for FDB flushing in bridge driver only, the VXLAN driver does
not support such flushing. Extend VXLAN driver to support FDB flushing.
In this commit, add support for flushing with state and flags, which are
the fields that supported in the bridge driver.

Note that bridge driver supports 'NTF_USE' flag, but there is no point to
support this flag for flushing as it is ignored when flags are stored.
'NTF_STICKY' is not relevant for VXLAN driver.

'NTF_ROUTER' is not supported in bridge driver for flush as it is not
relevant for bridge, add it for VXLAN.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 56 ++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 958960fdc011..0aeb973e3da7 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3026,6 +3026,8 @@ struct vxlan_fdb_flush_desc {
 	bool				ignore_default_entry;
 	unsigned long                   state;
 	unsigned long			state_mask;
+	unsigned long                   flags;
+	unsigned long			flags_mask;
 };
 
 static bool vxlan_fdb_is_default_entry(const struct vxlan_fdb *f,
@@ -3041,6 +3043,9 @@ static bool vxlan_fdb_flush_matches(const struct vxlan_fdb *f,
 	if (desc->state_mask && (f->state & desc->state_mask) != desc->state)
 		return false;
 
+	if (desc->flags_mask && (f->flags & desc->flags_mask) != desc->flags)
+		return false;
+
 	if (desc->ignore_default_entry && vxlan_fdb_is_default_entry(f, vxlan))
 		return false;
 
@@ -3070,6 +3075,56 @@ static void vxlan_flush(struct vxlan_dev *vxlan,
 	}
 }
 
+static const struct nla_policy vxlan_del_bulk_policy[NDA_MAX + 1] = {
+	[NDA_NDM_STATE_MASK]	= { .type = NLA_U16 },
+	[NDA_NDM_FLAGS_MASK]	= { .type = NLA_U8 },
+};
+
+#define VXLAN_FDB_FLUSH_IGNORED_NDM_FLAGS (NTF_MASTER | NTF_SELF)
+#define VXLAN_FDB_FLUSH_ALLOWED_NDM_STATES (NUD_PERMANENT | NUD_NOARP)
+#define VXLAN_FDB_FLUSH_ALLOWED_NDM_FLAGS (NTF_EXT_LEARNED | NTF_OFFLOADED | \
+					   NTF_ROUTER)
+
+static int vxlan_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
+				 struct netlink_ext_ack *extack)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_fdb_flush_desc desc = {};
+	struct ndmsg *ndm = nlmsg_data(nlh);
+	struct nlattr *tb[NDA_MAX + 1];
+	u8 ndm_flags;
+	int err;
+
+	ndm_flags = ndm->ndm_flags & ~VXLAN_FDB_FLUSH_IGNORED_NDM_FLAGS;
+
+	err = nlmsg_parse(nlh, sizeof(*ndm), tb, NDA_MAX, vxlan_del_bulk_policy,
+			  extack);
+	if (err)
+		return err;
+
+	if (ndm_flags & ~VXLAN_FDB_FLUSH_ALLOWED_NDM_FLAGS) {
+		NL_SET_ERR_MSG(extack, "Unsupported fdb flush ndm flag bits set");
+		return -EINVAL;
+	}
+	if (ndm->ndm_state & ~VXLAN_FDB_FLUSH_ALLOWED_NDM_STATES) {
+		NL_SET_ERR_MSG(extack, "Unsupported fdb flush ndm state bits set");
+		return -EINVAL;
+	}
+
+	desc.state = ndm->ndm_state;
+	desc.flags = ndm_flags;
+
+	if (tb[NDA_NDM_STATE_MASK])
+		desc.state_mask = nla_get_u16(tb[NDA_NDM_STATE_MASK]);
+
+	if (tb[NDA_NDM_FLAGS_MASK])
+		desc.flags_mask = nla_get_u8(tb[NDA_NDM_FLAGS_MASK]);
+
+	vxlan_flush(vxlan, &desc);
+
+	return 0;
+}
+
 /* Cleanup timer and forwarding table on shutdown */
 static int vxlan_stop(struct net_device *dev)
 {
@@ -3172,6 +3227,7 @@ static const struct net_device_ops vxlan_netdev_ether_ops = {
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_fdb_add		= vxlan_fdb_add,
 	.ndo_fdb_del		= vxlan_fdb_delete,
+	.ndo_fdb_del_bulk	= vxlan_fdb_delete_bulk,
 	.ndo_fdb_dump		= vxlan_fdb_dump,
 	.ndo_fdb_get		= vxlan_fdb_get,
 	.ndo_mdb_add		= vxlan_mdb_add,
-- 
2.40.1

