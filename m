Return-Path: <amcohen@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DCCF082025
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7C6A82017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rtfrZsIGrxrPNKj1deBXKst1E6NF8TioHabpf5xoyM=;
 b=i4X5UckGC4YQVoCeBoApEXxli5XLgjlXfirrN+TmPkxE0Nf34pIYrPHHNZ6K9WzgAsGPshL1KpShG5k8h2P7LXP5/9h/ESHpVUM0uoW6OU+kR7+A38Hdec0vD5j4Yy4j4BwKM/gDyTn3X3gzwDqsmAiYSjtGNV49sNlqONQaEETL0daQjnMZediUBeWdWU3t9VogFGjV+Qqioy46if9klrzP4UkZwHbUUEI9x48ZWnwSaHS9+ZylmkmiY8qowSDOQNaP6AOVI1mNqA2F4ABZtnO3WF9RhSIDKADqKFJuClLY94j6h6sbb2LAVGQGUtFPnBiPnWg86WovksOeiAZTlQ==
From: Amit Cohen <amcohen@nvidia.com>
Date: Mon, 9 Oct 2023 13:06:08 +0300
Message-ID: <20231009100618.2911374-2-amcohen@nvidia.com>
In-Reply-To: <20231009100618.2911374-1-amcohen@nvidia.com>
References: <20231009100618.2911374-1-amcohen@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 01/11] net: Handle bulk delete policy in
	bridge driver
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

The merge commit 92716869375b ("Merge branch 'br-flush-filtering'")
added support for FDB flushing in bridge driver. The following patches
will extend VXLAN driver to support FDB flushing as well. The netlink
message for bulk delete is shared between the drivers. With the existing
implementation, there is no way to prevent user from flushing with
attributes that are not supported per driver. For example, when VNI will
be added, user will not get an error for flush FDB entries in bridge
with VNI, although this attribute is not relevant for bridge.

As preparation for support of FDB flush in VXLAN driver, move the policy
to be handled in bridge driver, later a new policy for VXLAN will be
added in VXLAN driver. Do not pass 'vid' as part of ndo_fdb_del_bulk(),
as this field is relevant only for bridge.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 include/linux/netdevice.h |  8 ++------
 net/bridge/br_fdb.c       | 29 ++++++++++++++++++++++++-----
 net/bridge/br_private.h   |  3 +--
 net/core/rtnetlink.c      | 27 ++++++++++-----------------
 4 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e070a4540fba..17b3c0e86bb4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1290,9 +1290,7 @@ struct netdev_net_notifier {
  *		      struct net_device *dev,
  *		      const unsigned char *addr, u16 vid)
  *	Deletes the FDB entry from dev coresponding to addr.
- * int (*ndo_fdb_del_bulk)(struct ndmsg *ndm, struct nlattr *tb[],
- *			   struct net_device *dev,
- *			   u16 vid,
+ * int (*ndo_fdb_del_bulk)(struct nlmsghdr *nlh, struct net_device *dev,
  *			   struct netlink_ext_ack *extack);
  * int (*ndo_fdb_dump)(struct sk_buff *skb, struct netlink_callback *cb,
  *		       struct net_device *dev, struct net_device *filter_dev,
@@ -1567,10 +1565,8 @@ struct net_device_ops {
 					       struct net_device *dev,
 					       const unsigned char *addr,
 					       u16 vid, struct netlink_ext_ack *extack);
-	int			(*ndo_fdb_del_bulk)(struct ndmsg *ndm,
-						    struct nlattr *tb[],
+	int			(*ndo_fdb_del_bulk)(struct nlmsghdr *nlh,
 						    struct net_device *dev,
-						    u16 vid,
 						    struct netlink_ext_ack *extack);
 	int			(*ndo_fdb_dump)(struct sk_buff *skb,
 						struct netlink_callback *cb,
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e69a872bfc1d..a98ad763b368 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -661,14 +661,30 @@ static int __fdb_flush_validate_ifindex(const struct net_bridge *br,
 	return 0;
 }
 
-int br_fdb_delete_bulk(struct ndmsg *ndm, struct nlattr *tb[],
-		       struct net_device *dev, u16 vid,
+static const struct nla_policy br_fdb_del_bulk_policy[NDA_MAX + 1] = {
+	[NDA_VLAN]	= NLA_POLICY_RANGE(NLA_U16, 1, VLAN_N_VID - 2),
+	[NDA_IFINDEX]	= NLA_POLICY_MIN(NLA_S32, 1),
+	[NDA_NDM_STATE_MASK]	= { .type = NLA_U16 },
+	[NDA_NDM_FLAGS_MASK]	= { .type = NLA_U8 },
+};
+
+int br_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 		       struct netlink_ext_ack *extack)
 {
-	u8 ndm_flags = ndm->ndm_flags & ~FDB_FLUSH_IGNORED_NDM_FLAGS;
-	struct net_bridge_fdb_flush_desc desc = { .vlan_id = vid };
+	struct net_bridge_fdb_flush_desc desc = {};
+	struct ndmsg *ndm = nlmsg_data(nlh);
 	struct net_bridge_port *p = NULL;
+	struct nlattr *tb[NDA_MAX + 1];
 	struct net_bridge *br;
+	u8 ndm_flags;
+	int err;
+
+	ndm_flags = ndm->ndm_flags & ~FDB_FLUSH_IGNORED_NDM_FLAGS;
+
+	err = nlmsg_parse(nlh, sizeof(*ndm), tb, NDA_MAX,
+			  br_fdb_del_bulk_policy, extack);
+	if (err)
+		return err;
 
 	if (netif_is_bridge_master(dev)) {
 		br = netdev_priv(dev);
@@ -681,6 +697,9 @@ int br_fdb_delete_bulk(struct ndmsg *ndm, struct nlattr *tb[],
 		br = p->br;
 	}
 
+	if (tb[NDA_VLAN])
+		desc.vlan_id = nla_get_u16(tb[NDA_VLAN]);
+
 	if (ndm_flags & ~FDB_FLUSH_ALLOWED_NDM_FLAGS) {
 		NL_SET_ERR_MSG(extack, "Unsupported fdb flush ndm flag bits set");
 		return -EINVAL;
@@ -703,7 +722,7 @@ int br_fdb_delete_bulk(struct ndmsg *ndm, struct nlattr *tb[],
 		desc.flags_mask |= __ndm_flags_to_fdb_flags(ndm_flags_mask);
 	}
 	if (tb[NDA_IFINDEX]) {
-		int err, ifidx = nla_get_s32(tb[NDA_IFINDEX]);
+		int ifidx = nla_get_s32(tb[NDA_IFINDEX]);
 
 		err = __fdb_flush_validate_ifindex(br, ifidx, extack);
 		if (err)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index a1f4acfa6994..cbbe35278459 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -847,8 +847,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 		  struct net_device *dev, const unsigned char *addr, u16 vid,
 		  struct netlink_ext_ack *extack);
-int br_fdb_delete_bulk(struct ndmsg *ndm, struct nlattr *tb[],
-		       struct net_device *dev, u16 vid,
+int br_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 		       struct netlink_ext_ack *extack);
 int br_fdb_add(struct ndmsg *nlh, struct nlattr *tb[], struct net_device *dev,
 	       const unsigned char *addr, u16 vid, u16 nlh_flags,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 7452a6d190c5..eef7f7788996 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4367,13 +4367,6 @@ int ndo_dflt_fdb_del(struct ndmsg *ndm,
 }
 EXPORT_SYMBOL(ndo_dflt_fdb_del);
 
-static const struct nla_policy fdb_del_bulk_policy[NDA_MAX + 1] = {
-	[NDA_VLAN]	= { .type = NLA_U16 },
-	[NDA_IFINDEX]	= NLA_POLICY_MIN(NLA_S32, 1),
-	[NDA_NDM_STATE_MASK]	= { .type = NLA_U16  },
-	[NDA_NDM_FLAGS_MASK]	= { .type = NLA_U8 },
-};
-
 static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
@@ -4394,8 +4387,10 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 		err = nlmsg_parse_deprecated(nlh, sizeof(*ndm), tb, NDA_MAX,
 					     NULL, extack);
 	} else {
-		err = nlmsg_parse(nlh, sizeof(*ndm), tb, NDA_MAX,
-				  fdb_del_bulk_policy, extack);
+		/* For bulk delete, the drivers will parse the message with
+		 * policy.
+		 */
+		err = nlmsg_parse(nlh, sizeof(*ndm), tb, NDA_MAX, NULL, extack);
 	}
 	if (err < 0)
 		return err;
@@ -4418,6 +4413,10 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 			return -EINVAL;
 		}
 		addr = nla_data(tb[NDA_LLADDR]);
+
+		err = fdb_vid_parse(tb[NDA_VLAN], &vid, extack);
+		if (err)
+			return err;
 	}
 
 	if (dev->type != ARPHRD_ETHER) {
@@ -4425,10 +4424,6 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EINVAL;
 	}
 
-	err = fdb_vid_parse(tb[NDA_VLAN], &vid, extack);
-	if (err)
-		return err;
-
 	err = -EOPNOTSUPP;
 
 	/* Support fdb on master device the net/bridge default case */
@@ -4442,8 +4437,7 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 				err = ops->ndo_fdb_del(ndm, tb, dev, addr, vid, extack);
 		} else {
 			if (ops->ndo_fdb_del_bulk)
-				err = ops->ndo_fdb_del_bulk(ndm, tb, dev, vid,
-							    extack);
+				err = ops->ndo_fdb_del_bulk(nlh, dev, extack);
 		}
 
 		if (err)
@@ -4464,8 +4458,7 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 			/* in case err was cleared by NTF_MASTER call */
 			err = -EOPNOTSUPP;
 			if (ops->ndo_fdb_del_bulk)
-				err = ops->ndo_fdb_del_bulk(ndm, tb, dev, vid,
-							    extack);
+				err = ops->ndo_fdb_del_bulk(nlh, dev, extack);
 		}
 
 		if (!err) {
-- 
2.40.1

