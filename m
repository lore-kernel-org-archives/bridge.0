Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E169041B87
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE55841BAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sxMKfQrl1R9hAAzNNuoFio8mVq87qKkUi/x5UAzYHM=;
 b=p+eCo8sOukCA+p9AlgxKamZzW4IsZDYMqhX5vX9al7f1HmMAOAC0KB12TLdqBJaL/U0nXWn2/O8oKi2YxLfBfATjgcNEEdYXVOEaz3l9IWwnd1cUhP2Sz8ZxRTcONGnZRB+ObHo4H8HMyHem3aQ8YdExVxYydXR3Lfv0efm4cXzcdW4uSAw+Dw3+EeWDChc9paS4/TvMrL2i63TOJ5oYkNheYf8gG2PEjzIJUOYQJhkTtITepWhKM0vZEd4moorBKbLWHN5NLY/a0JsxNkd4++Q0/hX5GkBrTVuwX+R/E0j7vceB+p5mMEDLZ0YwvNk3dscJ5I/bDFCW2VIeihPryg==
From: Ido Schimmel <idosch@nvidia.com>
Date: Sat,  4 Feb 2023 19:07:52 +0200
Message-Id: <20230204170801.3897900-5-idosch@nvidia.com>
In-Reply-To: <20230204170801.3897900-1-idosch@nvidia.com>
References: <20230204170801.3897900-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 04/13] net: Add MDB net device
	operations
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Add MDB net device operations that will be invoked by rtnetlink code in
response to received RTM_{NEW,DEL,GET}MDB messages. Subsequent patches
will implement these operations in the bridge and VXLAN drivers.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/linux/netdevice.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d5ef4c1fedd2..47e33c6d314e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1305,6 +1305,17 @@ struct netdev_net_notifier {
  *	Used to add FDB entries to dump requests. Implementers should add
  *	entries to skb and update idx with the number of entries.
  *
+ * int (*ndo_mdb_add)(struct net_device *dev, struct nlattr *tb[],
+ *		      u16 nlmsg_flags, struct netlink_ext_ack *extack);
+ *	Adds an MDB entry to dev.
+ * int (*ndo_mdb_del)(struct net_device *dev, struct nlattr *tb[],
+ *		      struct netlink_ext_ack *extack);
+ *	Deletes the MDB entry from dev.
+ * int (*ndo_mdb_dump)(struct net_device *dev, struct sk_buff *skb,
+ *		       struct netlink_callback *cb);
+ *	Dumps MDB entries from dev. The first argument (marker) in the netlink
+ *	callback is used by core rtnetlink code.
+ *
  * int (*ndo_bridge_setlink)(struct net_device *dev, struct nlmsghdr *nlh,
  *			     u16 flags, struct netlink_ext_ack *extack)
  * int (*ndo_bridge_getlink)(struct sk_buff *skb, u32 pid, u32 seq,
@@ -1567,6 +1578,16 @@ struct net_device_ops {
 					       const unsigned char *addr,
 					       u16 vid, u32 portid, u32 seq,
 					       struct netlink_ext_ack *extack);
+	int			(*ndo_mdb_add)(struct net_device *dev,
+					       struct nlattr *tb[],
+					       u16 nlmsg_flags,
+					       struct netlink_ext_ack *extack);
+	int			(*ndo_mdb_del)(struct net_device *dev,
+					       struct nlattr *tb[],
+					       struct netlink_ext_ack *extack);
+	int			(*ndo_mdb_dump)(struct net_device *dev,
+						struct sk_buff *skb,
+						struct netlink_callback *cb);
 	int			(*ndo_bridge_setlink)(struct net_device *dev,
 						      struct nlmsghdr *nlh,
 						      u16 flags,
-- 
2.37.3

