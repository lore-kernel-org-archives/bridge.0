Return-Path: <amcohen@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4AEDE6002E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E96261139
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vts9POVX0ewQ3xqs/c2ntRY8jSorF1LamTxeTz8FSz0=;
 b=UAWV55vzzF9eGJq4q28E0ZJxmWPW+lbjMC+ln+FXVM0oNzVZ+kY2OIzKummySw/gjtonFaftoMIVJLpB9lcgYQVj8mtv3j24fHb6wFepy7aeh1wRwJZ/Vu6O97rjZxV6afCZ4W2UxjZVQQWRkbLtSSopAMZM9zKvsDUbHPy23KQ0iHtdMVeXTtLM0tzuUCb1SlxBnaE3rtVUbx5Lc9/weyrTKy79D9k7k09HgbFpTzD6XDTK0pa7slqJVDQxfCGSqY5XYxPxMfd5rI+sYzUnP5mIfAU3+VtNlBR7yeIxSysRbMam7lAaKLbcEPAdWcmwKoPOa/+NhE77aMALCeg8zQ==
From: Amit Cohen <amcohen@nvidia.com>
Date: Mon, 9 Oct 2023 13:06:16 +0300
Message-ID: <20231009100618.2911374-10-amcohen@nvidia.com>
In-Reply-To: <20231009100618.2911374-1-amcohen@nvidia.com>
References: <20231009100618.2911374-1-amcohen@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 09/11] vxlan: vxlan_core: Support FDB
	flushing by destination IP
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

Add support for flush VXLAN FDB entries by destination IP. FDB entry is
stored as {MAC, SRC_VNI} + remote. The destination IP is an attribute of
the remote. For multicast entries, the VXLAN driver stores a linked list
of remotes for a given key.

In user space, each remote is represented as a separate entry, so when
flush is sent with filter of 'destination IP', flush only the match
remotes. In case that there are no additional remotes, destroy the entry.

For example, the following are stored as one entry with several remotes:
$ bridge fdb show dev vx10
00:00:00:00:00:00 dst 192.1.1.3 self permanent
00:00:00:00:00:00 dst 192.1.1.1 self permanent
00:00:00:00:00:00 dst 192.1.1.2 self permanent
00:00:00:00:00:00 dst 192.1.1.1 vni 1000 self permanent

When user flush by destination IP x, only the relevant remotes will be
flushed:
$ bridge fdb flush dev vx10 dst 192.1.1.1

$ bridge fdb show dev vx10
00:00:00:00:00:00 dst 192.1.1.3 self permanent
00:00:00:00:00:00 dst 192.1.1.2 self permanent

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 1d6efca4ec4a..ece377b1b6bd 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3032,6 +3032,7 @@ struct vxlan_fdb_flush_desc {
 	u32				nhid;
 	__be32				vni;
 	__be16				port;
+	union vxlan_addr		dst_ip;
 };
 
 static bool vxlan_fdb_is_default_entry(const struct vxlan_fdb *f,
@@ -3072,7 +3073,7 @@ static bool vxlan_fdb_flush_matches(const struct vxlan_fdb *f,
 static bool
 vxlan_fdb_flush_should_match_remotes(const struct vxlan_fdb_flush_desc *desc)
 {
-	return desc->vni || desc->port;
+	return desc->vni || desc->port || desc->dst_ip.sa.sa_family;
 }
 
 static bool
@@ -3085,6 +3086,10 @@ vxlan_fdb_flush_remote_matches(const struct vxlan_fdb_flush_desc *desc,
 	if (desc->port && rd->remote_port != desc->port)
 		return false;
 
+	if (desc->dst_ip.sa.sa_family &&
+	    !vxlan_addr_equal(&rd->remote_ip, &desc->dst_ip))
+		return false;
+
 	return true;
 }
 
@@ -3146,6 +3151,8 @@ static const struct nla_policy vxlan_del_bulk_policy[NDA_MAX + 1] = {
 	[NDA_NH_ID]	= { .type = NLA_U32 },
 	[NDA_VNI]	= { .type = NLA_U32 },
 	[NDA_PORT]	= { .type = NLA_U16 },
+	[NDA_DST]	= NLA_POLICY_RANGE(NLA_BINARY, sizeof(struct in_addr),
+					   sizeof(struct in6_addr)),
 	[NDA_NDM_STATE_MASK]	= { .type = NLA_U16 },
 	[NDA_NDM_FLAGS_MASK]	= { .type = NLA_U8 },
 };
@@ -3202,6 +3209,18 @@ static int vxlan_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 	if (tb[NDA_PORT])
 		desc.port = nla_get_be16(tb[NDA_PORT]);
 
+	if (tb[NDA_DST]) {
+		union vxlan_addr ip;
+
+		err = vxlan_nla_get_addr(&ip, tb[NDA_DST]);
+		if (err) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[NDA_DST],
+					    "Unsupported address family");
+			return err;
+		}
+		desc.dst_ip = ip;
+	}
+
 	vxlan_flush(vxlan, &desc);
 
 	return 0;
-- 
2.40.1

