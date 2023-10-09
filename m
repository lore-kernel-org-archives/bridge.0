Return-Path: <amcohen@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 75BF2417FA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 66EA2417D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRcHIngCdxLXbNg1mM1AOfmR9WB5qyAajfBSpzdhuVg=;
 b=P8FAiu7IiBbfZQIlS7+1Obw30MsxKjvEGSOdpL4uhrn6mvk6k0d9+lM+EYo/TMVZiY/Yg7hM2YuYyVraHP8CMvfZw1dIMQcrGduz2hCJwok5m6PqwEPTF+i7gdUnYLXj0Dj25DAr5Nvv54IAFzjIbNKS053Hmd5CMxQbSmlJBPwYOC8bDVx4T7vqzMgMsF3O/DuKxXbTTO8XoBoPYCc0dWsbnaGFPxmm/cFt4ApWUNo/Rmarqcmx/cJf3O24/ZBbypKvB2FKXACEHYnoG2kVVooD6xKj1ej3OyX+d+IteTAFT04lZG6Z17vQZrv9kbuAe6If9Th+I9oTHJfefbHLeA==
From: Amit Cohen <amcohen@nvidia.com>
Date: Mon, 9 Oct 2023 13:06:14 +0300
Message-ID: <20231009100618.2911374-8-amcohen@nvidia.com>
In-Reply-To: <20231009100618.2911374-1-amcohen@nvidia.com>
References: <20231009100618.2911374-1-amcohen@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 07/11] vxlan: vxlan_core: Support FDB
	flushing by destination VNI
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

Add support for flush VXLAN FDB entries by destination VNI. FDB entry is
stored as {MAC, SRC_VNI} + remote. The destination VNI is an attribute
of the remote. For multicast entries, the VXLAN driver stores a linked list
of remotes for a given key.

In user space, each remote is represented as a separate entry, so when
flush is sent with filter of 'destination VNI', flush only the match
remotes. In case that there are no additional remotes, destroy the entry.

For example, the following are stored as one entry with several remotes:
$ bridge fdb show dev vx10
00:00:00:00:00:00 dst 192.1.1.1 vni 3000 self permanent
00:00:00:00:00:00 dst 192.1.1.1 vni 4000 self permanent
00:00:00:00:00:00 dst 192.1.1.1 vni 2000 self permanent
00:00:00:00:00:00 dst 192.1.1.2 vni 2000 self permanent

When user flush by VNI x, only the relevant remotes will be flushed:
$ bridge fdb flush dev vx10 vni 2000

$ bridge fdb show dev vx10
00:00:00:00:00:00 dst 192.1.1.1 vni 3000 self permanent
00:00:00:00:00:00 dst 192.1.1.1 vni 4000 self permanent

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 51 ++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index ec7147409d99..f16328a0f9fe 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3030,6 +3030,7 @@ struct vxlan_fdb_flush_desc {
 	unsigned long			flags_mask;
 	__be32				src_vni;
 	u32				nhid;
+	__be32				vni;
 };
 
 static bool vxlan_fdb_is_default_entry(const struct vxlan_fdb *f,
@@ -3067,10 +3068,46 @@ static bool vxlan_fdb_flush_matches(const struct vxlan_fdb *f,
 	return true;
 }
 
+static bool
+vxlan_fdb_flush_should_match_remotes(const struct vxlan_fdb_flush_desc *desc)
+{
+	return !!desc->vni;
+}
+
+static bool
+vxlan_fdb_flush_remote_matches(const struct vxlan_fdb_flush_desc *desc,
+			       const struct vxlan_rdst *rd)
+{
+	if (desc->vni && rd->remote_vni != desc->vni)
+		return false;
+
+	return true;
+}
+
+static void
+vxlan_fdb_flush_match_remotes(struct vxlan_fdb *f, struct vxlan_dev *vxlan,
+			      const struct vxlan_fdb_flush_desc *desc,
+			      bool *p_destroy_fdb)
+{
+	bool remotes_flushed = false;
+	struct vxlan_rdst *rd, *tmp;
+
+	list_for_each_entry_safe(rd, tmp, &f->remotes, list) {
+		if (!vxlan_fdb_flush_remote_matches(desc, rd))
+			continue;
+
+		vxlan_fdb_dst_destroy(vxlan, f, rd, true);
+		remotes_flushed = true;
+	}
+
+	*p_destroy_fdb = remotes_flushed && list_empty(&f->remotes);
+}
+
 /* Purge the forwarding table */
 static void vxlan_flush(struct vxlan_dev *vxlan,
 			const struct vxlan_fdb_flush_desc *desc)
 {
+	bool match_remotes = vxlan_fdb_flush_should_match_remotes(desc);
 	unsigned int h;
 
 	for (h = 0; h < FDB_HASH_SIZE; ++h) {
@@ -3084,6 +3121,16 @@ static void vxlan_flush(struct vxlan_dev *vxlan,
 			if (!vxlan_fdb_flush_matches(f, vxlan, desc))
 				continue;
 
+			if (match_remotes) {
+				bool destroy_fdb = false;
+
+				vxlan_fdb_flush_match_remotes(f, vxlan, desc,
+							      &destroy_fdb);
+
+				if (!destroy_fdb)
+					continue;
+			}
+
 			vxlan_fdb_destroy(vxlan, f, true, true);
 		}
 		spin_unlock_bh(&vxlan->hash_lock[h]);
@@ -3093,6 +3140,7 @@ static void vxlan_flush(struct vxlan_dev *vxlan,
 static const struct nla_policy vxlan_del_bulk_policy[NDA_MAX + 1] = {
 	[NDA_SRC_VNI]   = { .type = NLA_U32 },
 	[NDA_NH_ID]	= { .type = NLA_U32 },
+	[NDA_VNI]	= { .type = NLA_U32 },
 	[NDA_NDM_STATE_MASK]	= { .type = NLA_U16 },
 	[NDA_NDM_FLAGS_MASK]	= { .type = NLA_U8 },
 };
@@ -3143,6 +3191,9 @@ static int vxlan_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 	if (tb[NDA_NH_ID])
 		desc.nhid = nla_get_u32(tb[NDA_NH_ID]);
 
+	if (tb[NDA_VNI])
+		desc.vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
+
 	vxlan_flush(vxlan, &desc);
 
 	return 0;
-- 
2.40.1

