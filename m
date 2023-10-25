Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C6B243649
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 14F8043642
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5kdUNascDBnvl6hfgFAKpKsZ/PM0KlqTbaFTekvizo=;
 b=QCvut/m5MvI5aYCbJqY0vms6gTk7qB5leQwyZ7W97nsgAtpLiawt6KrvrHRJO+L2/k78AqQZkCvKzmG9q5haThUkZCFvBM39UZqKLcj52rLYoDJKoEYc89HLC3AyYek7JCSJcMzjclzb1Bse4T0bOA1L+XYvn30W7nT5ym5PF0E8o5JOIcKgUd5hHe+zpZXNqQLlH1d1KMpq6YrWpSXN7y5j+4rfTXv8f2/l3X1bYyPy9Cwogx3Yv3c6L8DAOQdL5y1uG+jU78HKoD8SQix4AUOfVInQ3bEGEujmnOJ7zlIJ1BWpvJ4uxsXGck5lsDamzL256Aws46kQS7SF6iRosA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Wed, 25 Oct 2023 15:30:18 +0300
Message-ID: <20231025123020.788710-12-idosch@nvidia.com>
In-Reply-To: <20231025123020.788710-1-idosch@nvidia.com>
References: <20231025123020.788710-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 11/13] rtnetlink: Add MDB get support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Now that both the bridge and VXLAN drivers implement the MDB get net
device operation, expose the functionality to user space by registering
a handler for RTM_GETMDB messages. Derive the net device from the
ifindex specified in the ancillary header and invoke its MDB get NDO.

Note that unlike other get handlers, the allocation of the skb
containing the response is not performed in the common rtnetlink code as
the size is variable and needs to be determined by the respective
driver.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/core/rtnetlink.c | 89 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f2753fd58881..e8431c6c8490 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6219,6 +6219,93 @@ static int rtnl_mdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+static int rtnl_validate_mdb_entry_get(const struct nlattr *attr,
+				       struct netlink_ext_ack *extack)
+{
+	struct br_mdb_entry *entry = nla_data(attr);
+
+	if (nla_len(attr) != sizeof(struct br_mdb_entry)) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "Invalid attribute length");
+		return -EINVAL;
+	}
+
+	if (entry->ifindex) {
+		NL_SET_ERR_MSG(extack, "Entry ifindex cannot be specified");
+		return -EINVAL;
+	}
+
+	if (entry->state) {
+		NL_SET_ERR_MSG(extack, "Entry state cannot be specified");
+		return -EINVAL;
+	}
+
+	if (entry->flags) {
+		NL_SET_ERR_MSG(extack, "Entry flags cannot be specified");
+		return -EINVAL;
+	}
+
+	if (entry->vid >= VLAN_VID_MASK) {
+		NL_SET_ERR_MSG(extack, "Invalid entry VLAN id");
+		return -EINVAL;
+	}
+
+	if (entry->addr.proto != htons(ETH_P_IP) &&
+	    entry->addr.proto != htons(ETH_P_IPV6) &&
+	    entry->addr.proto != 0) {
+		NL_SET_ERR_MSG(extack, "Unknown entry protocol");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct nla_policy mdba_get_policy[MDBA_GET_ENTRY_MAX + 1] = {
+	[MDBA_GET_ENTRY] = NLA_POLICY_VALIDATE_FN(NLA_BINARY,
+						  rtnl_validate_mdb_entry_get,
+						  sizeof(struct br_mdb_entry)),
+	[MDBA_GET_ENTRY_ATTRS] = { .type = NLA_NESTED },
+};
+
+static int rtnl_mdb_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
+			struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[MDBA_GET_ENTRY_MAX + 1];
+	struct net *net = sock_net(in_skb->sk);
+	struct br_port_msg *bpm;
+	struct net_device *dev;
+	int err;
+
+	err = nlmsg_parse(nlh, sizeof(struct br_port_msg), tb,
+			  MDBA_GET_ENTRY_MAX, mdba_get_policy, extack);
+	if (err)
+		return err;
+
+	bpm = nlmsg_data(nlh);
+	if (!bpm->ifindex) {
+		NL_SET_ERR_MSG(extack, "Invalid ifindex");
+		return -EINVAL;
+	}
+
+	dev = __dev_get_by_index(net, bpm->ifindex);
+	if (!dev) {
+		NL_SET_ERR_MSG(extack, "Device doesn't exist");
+		return -ENODEV;
+	}
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, MDBA_GET_ENTRY)) {
+		NL_SET_ERR_MSG(extack, "Missing MDBA_GET_ENTRY attribute");
+		return -EINVAL;
+	}
+
+	if (!dev->netdev_ops->ndo_mdb_get) {
+		NL_SET_ERR_MSG(extack, "Device does not support MDB operations");
+		return -EOPNOTSUPP;
+	}
+
+	return dev->netdev_ops->ndo_mdb_get(dev, tb, NETLINK_CB(in_skb).portid,
+					    nlh->nlmsg_seq, extack);
+}
+
 static int rtnl_validate_mdb_entry(const struct nlattr *attr,
 				   struct netlink_ext_ack *extack)
 {
@@ -6595,7 +6682,7 @@ void __init rtnetlink_init(void)
 		      0);
 	rtnl_register(PF_UNSPEC, RTM_SETSTATS, rtnl_stats_set, NULL, 0);
 
-	rtnl_register(PF_BRIDGE, RTM_GETMDB, NULL, rtnl_mdb_dump, 0);
+	rtnl_register(PF_BRIDGE, RTM_GETMDB, rtnl_mdb_get, rtnl_mdb_dump, 0);
 	rtnl_register(PF_BRIDGE, RTM_NEWMDB, rtnl_mdb_add, NULL, 0);
 	rtnl_register(PF_BRIDGE, RTM_DELMDB, rtnl_mdb_del, NULL, 0);
 }
-- 
2.40.1

