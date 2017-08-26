Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 26 Aug 2017 22:56:06 +0200
Message-Id: <1503780970-10312-2-git-send-email-andrew@lunn.ch>
In-Reply-To: <1503780970-10312-1-git-send-email-andrew@lunn.ch>
References: <1503780970-10312-1-git-send-email-andrew@lunn.ch>
Subject: [Bridge] [PATCH RFC WIP 1/5] net: rtnetlink: Handle bridge port
	without upper device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev <netdev@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, jiri@mellanox.com

The brX interface will with a following patch becomes a member of the
bridge. It however cannot be a slave interface, since it would have to
be a slave of itself. netdev_master_upper_dev_get() returns NULL as a
result. Handle this NULL, by knowing this bridge slave must also be
the master, i.e. what we are looking for.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 net/core/rtnetlink.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 9201e3621351..2673eb430b6f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3093,8 +3093,12 @@ static int rtnl_fdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if ((!ndm->ndm_flags || ndm->ndm_flags & NTF_MASTER) &&
 	    (dev->priv_flags & IFF_BRIDGE_PORT)) {
 		struct net_device *br_dev = netdev_master_upper_dev_get(dev);
-		const struct net_device_ops *ops = br_dev->netdev_ops;
+		const struct net_device_ops *ops;
 
+		if (!br_dev)
+			br_dev = dev;
+
+		ops = br_dev->netdev_ops;
 		err = ops->ndo_fdb_add(ndm, tb, dev, addr, vid,
 				       nlh->nlmsg_flags);
 		if (err)
@@ -3197,7 +3201,12 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if ((!ndm->ndm_flags || ndm->ndm_flags & NTF_MASTER) &&
 	    (dev->priv_flags & IFF_BRIDGE_PORT)) {
 		struct net_device *br_dev = netdev_master_upper_dev_get(dev);
-		const struct net_device_ops *ops = br_dev->netdev_ops;
+		const struct net_device_ops *ops;
+
+		if (!br_dev)
+			br_dev = dev;
+
+		ops = br_dev->netdev_ops;
 
 		if (ops->ndo_fdb_del)
 			err = ops->ndo_fdb_del(ndm, tb, dev, addr, vid);
@@ -3332,6 +3341,8 @@ static int rtnl_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 			if (!br_idx) { /* user did not specify a specific bridge */
 				if (dev->priv_flags & IFF_BRIDGE_PORT) {
 					br_dev = netdev_master_upper_dev_get(dev);
+					if (!br_dev)
+						br_dev = dev;
 					cops = br_dev->netdev_ops;
 				}
 			} else {
@@ -3410,6 +3421,9 @@ int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	struct net_device *br_dev = netdev_master_upper_dev_get(dev);
 	int err = 0;
 
+	if (!br_dev)
+		br_dev = dev;
+
 	nlh = nlmsg_put(skb, pid, seq, RTM_NEWLINK, sizeof(*ifm), nlflags);
 	if (nlh == NULL)
 		return -EMSGSIZE;
@@ -3647,6 +3661,8 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	if (!flags || (flags & BRIDGE_FLAGS_MASTER)) {
 		struct net_device *br_dev = netdev_master_upper_dev_get(dev);
+		if (!br_dev)
+			br_dev = dev;
 
 		if (!br_dev || !br_dev->netdev_ops->ndo_bridge_setlink) {
 			err = -EOPNOTSUPP;
@@ -3723,6 +3739,9 @@ static int rtnl_bridge_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!flags || (flags & BRIDGE_FLAGS_MASTER)) {
 		struct net_device *br_dev = netdev_master_upper_dev_get(dev);
 
+		if (!br_dev)
+			br_dev = dev;
+
 		if (!br_dev || !br_dev->netdev_ops->ndo_bridge_dellink) {
 			err = -EOPNOTSUPP;
 			goto out;
-- 
2.14.1

