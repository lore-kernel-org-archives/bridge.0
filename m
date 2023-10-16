Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE6EA820EE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F1AE8213F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAcIptTXNIvJ6cPUQPR8TX9wiLP5p80U0vPHJxi/qtk=;
 b=tzDZrqBB6z2LikaGMC3IEDg7vMBYFN2anhoZF/7twK6H+JfLc/IVMFoCd58tLDgRTqMWLQlSnK1khUM6BDoGbc9ibLqJGzb6NRRqSl+i/dp+/vdSWJoVrMUfnd91hwl8E00I4HR99NCUoqTANiD5nFEiwVsSf6UasReGxXxEUy5Yce8UD5+jfPowqBNrsCddRSvt0Ei4eT8wmU+S8T8kO3S6UvwQwgTsXeNtITihg1rlcLDkCNDlAiMq+DcGsp+nM46QsbcOyeUGEhD6F1nhbwj2UaLCJ+fZwQVjbji9DUdV343ijEl10hRcqMIipwhMdIhk+HhK40TM7Ij42XkH2A==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon, 16 Oct 2023 16:12:57 +0300
Message-ID: <20231016131259.3302298-12-idosch@nvidia.com>
In-Reply-To: <20231016131259.3302298-1-idosch@nvidia.com>
References: <20231016131259.3302298-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 11/13] rtnetlink: Add MDB get support
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
---
 net/core/rtnetlink.c | 89 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index eef7f7788996..e4fb242655b4 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6221,6 +6221,93 @@ static int rtnl_mdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
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
@@ -6597,7 +6684,7 @@ void __init rtnetlink_init(void)
 		      0);
 	rtnl_register(PF_UNSPEC, RTM_SETSTATS, rtnl_stats_set, NULL, 0);
 
-	rtnl_register(PF_BRIDGE, RTM_GETMDB, NULL, rtnl_mdb_dump, 0);
+	rtnl_register(PF_BRIDGE, RTM_GETMDB, rtnl_mdb_get, rtnl_mdb_dump, 0);
 	rtnl_register(PF_BRIDGE, RTM_NEWMDB, rtnl_mdb_add, NULL, 0);
 	rtnl_register(PF_BRIDGE, RTM_DELMDB, rtnl_mdb_del, NULL, 0);
 }
-- 
2.40.1

