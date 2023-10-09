Return-Path: <amcohen@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 83B2882043
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F344082010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/diKAQ1CB+LJzeMAPD78XPOMuWnMXWCE6TPBTz9uW/Y=;
 b=ZJU4MWNNMNWmugktdkxe2s68RVTJ3ihVMegJ+wYQAOKNhMKOASqok6ZnDWXGa98y8uTb9BmUpirwIhbz3Ygnu9yrCk2X1KxKRxRdbH9HqfIxgRB0cyRVMRJyQG1OC5kvJ5UIiaLv1iWVgRsMCM00FCaa+VYaCWxLDLyXlnFF85o1YEyZFDGjxNRdYpiLtUH6mA7p7XPbze6gRakolW9FAXCo8DRHHzyJfGZ8PhipdUC+21vOtfBPjlvuENuaIkhhZSlCCWT5MKOg+L/Vl0wL+PEgmczcEo0jbZ5jqj1KkTL6yfO+1xOiqRtIQmfdHkzgQrligwiValhWJBnilNQi5A==
From: Amit Cohen <amcohen@nvidia.com>
Date: Mon, 9 Oct 2023 13:06:15 +0300
Message-ID: <20231009100618.2911374-9-amcohen@nvidia.com>
In-Reply-To: <20231009100618.2911374-1-amcohen@nvidia.com>
References: <20231009100618.2911374-1-amcohen@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 08/11] vxlan: vxlan_core: Support FDB
	flushing by destination port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: razor@blackwall.org, Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com, dsahern@kernel.org, bridge@lists.linux-foundation.org, idosch@nvidia.com, linux-kselftest@vger.kernel.org, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, davem@davemloft.net

Add support for flush VXLAN FDB entries by destination port. FDB entry
is stored as {MAC, SRC_VNI} + remote. The destination port is an attribute
of the remote. For multicast entries, the VXLAN driver stores a linked list
of remotes for a given key.

In user space, each remote is represented as a separate entry, so when
flush is sent with filter of 'destination port', flush only the match
remotes. In case that there are no additional remotes, destroy the entry.

For example, the following are stored as one entry with several remotes:
$ bridge fdb show dev vx10
00:00:00:00:00:00 dst 192.1.1.1 port 1111 vni 2000 self permanent
00:00:00:00:00:00 dst 192.1.1.1 port 1111 vni 3000 self permanent
00:00:00:00:00:00 dst 192.1.1.1 port 2222 vni 2000 self permanent
00:00:00:00:00:00 dst 192.1.1.1 vni 3000 self permanent

When user flush by port x, only the relevant remotes will be flushed:
$ bridge fdb flush dev vx10 port 1111

$ bridge fdb show dev vx10
00:00:00:00:00:00 dst 192.1.1.1 port 2222 vni 2000 self permanent
00:00:00:00:00:00 dst 192.1.1.1 vni 3000 self permanent

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index f16328a0f9fe..1d6efca4ec4a 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3031,6 +3031,7 @@ struct vxlan_fdb_flush_desc {
 	__be32				src_vni;
 	u32				nhid;
 	__be32				vni;
+	__be16				port;
 };
 
 static bool vxlan_fdb_is_default_entry(const struct vxlan_fdb *f,
@@ -3071,7 +3072,7 @@ static bool vxlan_fdb_flush_matches(const struct vxlan_fdb *f,
 static bool
 vxlan_fdb_flush_should_match_remotes(const struct vxlan_fdb_flush_desc *desc)
 {
-	return !!desc->vni;
+	return desc->vni || desc->port;
 }
 
 static bool
@@ -3081,6 +3082,9 @@ vxlan_fdb_flush_remote_matches(const struct vxlan_fdb_flush_desc *desc,
 	if (desc->vni && rd->remote_vni != desc->vni)
 		return false;
 
+	if (desc->port && rd->remote_port != desc->port)
+		return false;
+
 	return true;
 }
 
@@ -3141,6 +3145,7 @@ static const struct nla_policy vxlan_del_bulk_policy[NDA_MAX + 1] = {
 	[NDA_SRC_VNI]   = { .type = NLA_U32 },
 	[NDA_NH_ID]	= { .type = NLA_U32 },
 	[NDA_VNI]	= { .type = NLA_U32 },
+	[NDA_PORT]	= { .type = NLA_U16 },
 	[NDA_NDM_STATE_MASK]	= { .type = NLA_U16 },
 	[NDA_NDM_FLAGS_MASK]	= { .type = NLA_U8 },
 };
@@ -3194,6 +3199,9 @@ static int vxlan_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 	if (tb[NDA_VNI])
 		desc.vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
 
+	if (tb[NDA_PORT])
+		desc.port = nla_get_be16(tb[NDA_PORT]);
+
 	vxlan_flush(vxlan, &desc);
 
 	return 0;
-- 
2.40.1

