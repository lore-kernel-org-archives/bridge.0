Return-Path: <amcohen@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5A2D40A44
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 92DA8405F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt/wU6WZ7GRXHaUbxO4XGUjytCIUM1CTzE/+Q9sHSjs=;
 b=rqQ537MTTePZo23+PRGN1cX/bhrswaiLYMG8gJXEZx8MyUZdVVqMYRS7YcH0nPApvh9wFrYYShiQfy1g24LrhXcFfi6+v+mQNzumFwDOJ0+lon/SX/+m6bT98xTmnwyMa/hg2QIdzpZpGIToFx5U41yi3NQR483gwmtDWkWaEKjX0F7UVnFppCIITWOXjS16gsmSeqmkUaYAofGhx0SIhOoR+FxgJDrSDNplsNjCUTWo6ksEVuD/CZHdCmv2hvPGD4W3fK/bqHwCEWvsgXtg+cRVHXLO3WtN6CjBB966ixpRdTkTXf2GNDgLHXX0+ok+CXR/7lJzIvtGmFcDNO2Hhw==
From: Amit Cohen <amcohen@nvidia.com>
Date: Mon, 9 Oct 2023 13:06:12 +0300
Message-ID: <20231009100618.2911374-6-amcohen@nvidia.com>
In-Reply-To: <20231009100618.2911374-1-amcohen@nvidia.com>
References: <20231009100618.2911374-1-amcohen@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 05/11] vxlan: vxlan_core: Support FDB
	flushing by source VNI
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

Add support for flush VXLAN FDB entries by source VNI.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 0aeb973e3da7..8214db56989d 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3028,6 +3028,7 @@ struct vxlan_fdb_flush_desc {
 	unsigned long			state_mask;
 	unsigned long                   flags;
 	unsigned long			flags_mask;
+	__be32				src_vni;
 };
 
 static bool vxlan_fdb_is_default_entry(const struct vxlan_fdb *f,
@@ -3049,6 +3050,9 @@ static bool vxlan_fdb_flush_matches(const struct vxlan_fdb *f,
 	if (desc->ignore_default_entry && vxlan_fdb_is_default_entry(f, vxlan))
 		return false;
 
+	if (desc->src_vni && f->vni != desc->src_vni)
+		return false;
+
 	return true;
 }
 
@@ -3076,6 +3080,7 @@ static void vxlan_flush(struct vxlan_dev *vxlan,
 }
 
 static const struct nla_policy vxlan_del_bulk_policy[NDA_MAX + 1] = {
+	[NDA_SRC_VNI]   = { .type = NLA_U32 },
 	[NDA_NDM_STATE_MASK]	= { .type = NLA_U16 },
 	[NDA_NDM_FLAGS_MASK]	= { .type = NLA_U8 },
 };
@@ -3120,6 +3125,9 @@ static int vxlan_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 	if (tb[NDA_NDM_FLAGS_MASK])
 		desc.flags_mask = nla_get_u8(tb[NDA_NDM_FLAGS_MASK]);
 
+	if (tb[NDA_SRC_VNI])
+		desc.src_vni = cpu_to_be32(nla_get_u32(tb[NDA_SRC_VNI]));
+
 	vxlan_flush(vxlan, &desc);
 
 	return 0;
-- 
2.40.1

