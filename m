Return-Path: <amcohen@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 085CC417FA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 07BF9417D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HiHzqApvoOf/BYHCJv0CGWSnumfWBB0kh8K60Vg7Ng=;
 b=kCvro4akQgE9IeYQ0x4TnGb0A6EYxZe8ZdFUQdEonNwZt+uEmsF3AX0xodySd02IVyGWvSvp7vu9D/sDxs3auWG59JdsAFgOzl07RSOS+JgI8smVj8rZsY+iUcMBFA+Caf3ZPXVVq/cCPXlvWSy9cLzn4i6Ae+uRyd9hKTWCSIw4I7vH4eYOmu95jpwJLW27ry0dRTn+N6Bobq3ttSopIH+76mBgj89oj2lv1Pm+FpCQBMEg8Eb1dhrcyrZ6ghAIlDbPh32N9kj3gQKcHtB5Atpb/XsxNle41fxrDU+m3RGzsHZHeOTN2IeSGopf9fUeKusJz1MkJMxOtNv2dOxYYA==
From: Amit Cohen <amcohen@nvidia.com>
Date: Mon, 9 Oct 2023 13:06:13 +0300
Message-ID: <20231009100618.2911374-7-amcohen@nvidia.com>
In-Reply-To: <20231009100618.2911374-1-amcohen@nvidia.com>
References: <20231009100618.2911374-1-amcohen@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 06/11] vxlan: vxlan_core: Support FDB
	flushing by nexthop ID
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

Add support for flush VXLAN FDB entries by nexthop ID.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 8214db56989d..ec7147409d99 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3029,6 +3029,7 @@ struct vxlan_fdb_flush_desc {
 	unsigned long                   flags;
 	unsigned long			flags_mask;
 	__be32				src_vni;
+	u32				nhid;
 };
 
 static bool vxlan_fdb_is_default_entry(const struct vxlan_fdb *f,
@@ -3037,6 +3038,13 @@ static bool vxlan_fdb_is_default_entry(const struct vxlan_fdb *f,
 	return is_zero_ether_addr(f->eth_addr) && f->vni == vxlan->cfg.vni;
 }
 
+static bool vxlan_fdb_nhid_matches(const struct vxlan_fdb *f, u32 nhid)
+{
+	struct nexthop *nh = rtnl_dereference(f->nh);
+
+	return nh && nh->id == nhid;
+}
+
 static bool vxlan_fdb_flush_matches(const struct vxlan_fdb *f,
 				    const struct vxlan_dev *vxlan,
 				    const struct vxlan_fdb_flush_desc *desc)
@@ -3053,6 +3061,9 @@ static bool vxlan_fdb_flush_matches(const struct vxlan_fdb *f,
 	if (desc->src_vni && f->vni != desc->src_vni)
 		return false;
 
+	if (desc->nhid && !vxlan_fdb_nhid_matches(f, desc->nhid))
+		return false;
+
 	return true;
 }
 
@@ -3081,6 +3092,7 @@ static void vxlan_flush(struct vxlan_dev *vxlan,
 
 static const struct nla_policy vxlan_del_bulk_policy[NDA_MAX + 1] = {
 	[NDA_SRC_VNI]   = { .type = NLA_U32 },
+	[NDA_NH_ID]	= { .type = NLA_U32 },
 	[NDA_NDM_STATE_MASK]	= { .type = NLA_U16 },
 	[NDA_NDM_FLAGS_MASK]	= { .type = NLA_U8 },
 };
@@ -3128,6 +3140,9 @@ static int vxlan_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 	if (tb[NDA_SRC_VNI])
 		desc.src_vni = cpu_to_be32(nla_get_u32(tb[NDA_SRC_VNI]));
 
+	if (tb[NDA_NH_ID])
+		desc.nhid = nla_get_u32(tb[NDA_NH_ID]);
+
 	vxlan_flush(vxlan, &desc);
 
 	return 0;
-- 
2.40.1

