Return-Path: <jiri@resnulli.us>
From: Jiri Pirko <jiri@resnulli.us>
Message-Id: <1344871635-1052-5-git-send-email-jiri@resnulli.us>
In-Reply-To: <1344871635-1052-1-git-send-email-jiri@resnulli.us>
References: <1344871635-1052-1-git-send-email-jiri@resnulli.us>
Subject: [Bridge] [patch net-next 04/16] rtnetlink: remove usage of
	dev->master
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Mon, 13 Aug 2012 15:27:33 -0000
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, ursula.braun@de.ibm.com, john.r.fastabend@intel.com, edumazet@google.com, shemminger@vyatta.com, sean.hefty@intel.com, therbert@google.com, roland@kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, fubar@us.ibm.com, fbl@redhat.com, hal.rosenstock@gmail.com, faisal.latif@intel.com, sony.chacko@qlogic.com, blaschka@linux.vnet.ibm.com, gregory.v.rose@intel.com, bhutchings@solarflare.com, xiyou.wangcong@gmail.com, jitendra.kalsaria@qlogic.com, divy@chelsio.com, linux-driver@qlogic.com, linux-kernel@vger.kernel.org, kaber@trash.net, joe@perches.com, linux390@de.ibm.com, davem@davemloft.net

Signed-off-by: Jiri Pirko <jiri@resnulli.us>
---
 net/core/rtnetlink.c |   44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 34d975b..c341eb7 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -879,6 +879,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb, struct net_device *dev,
 	const struct rtnl_link_stats64 *stats;
 	struct nlattr *attr, *af_spec;
 	struct rtnl_af_ops *af_ops;
+	struct net_device *upper_dev = netdev_unique_upper_dev_get(dev);
 
 	ASSERT_RTNL();
 	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*ifm), flags);
@@ -907,8 +908,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb, struct net_device *dev,
 #endif
 	    (dev->ifindex != dev->iflink &&
 	     nla_put_u32(skb, IFLA_LINK, dev->iflink)) ||
-	    (dev->master &&
-	     nla_put_u32(skb, IFLA_MASTER, dev->master->ifindex)) ||
+	    (upper_dev &&
+	     nla_put_u32(skb, IFLA_MASTER, upper_dev->ifindex)) ||
 	    (dev->qdisc &&
 	     nla_put_string(skb, IFLA_QDISC, dev->qdisc->ops->id)) ||
 	    (dev->ifalias &&
@@ -1270,16 +1271,16 @@ static int do_setvfinfo(struct net_device *dev, struct nlattr *attr)
 
 static int do_set_master(struct net_device *dev, int ifindex)
 {
-	struct net_device *master_dev;
+	struct net_device *upper_dev = netdev_unique_upper_dev_get(dev);
 	const struct net_device_ops *ops;
 	int err;
 
-	if (dev->master) {
-		if (dev->master->ifindex == ifindex)
+	if (upper_dev) {
+		if (upper_dev->ifindex == ifindex)
 			return 0;
-		ops = dev->master->netdev_ops;
+		ops = upper_dev->netdev_ops;
 		if (ops->ndo_del_slave) {
-			err = ops->ndo_del_slave(dev->master, dev);
+			err = ops->ndo_del_slave(upper_dev, dev);
 			if (err)
 				return err;
 		} else {
@@ -1288,12 +1289,12 @@ static int do_set_master(struct net_device *dev, int ifindex)
 	}
 
 	if (ifindex) {
-		master_dev = __dev_get_by_index(dev_net(dev), ifindex);
-		if (!master_dev)
+		upper_dev = __dev_get_by_index(dev_net(dev), ifindex);
+		if (!upper_dev)
 			return -EINVAL;
-		ops = master_dev->netdev_ops;
+		ops = upper_dev->netdev_ops;
 		if (ops->ndo_add_slave) {
-			err = ops->ndo_add_slave(master_dev, dev);
+			err = ops->ndo_add_slave(upper_dev, dev);
 			if (err)
 				return err;
 		} else {
@@ -2050,7 +2051,6 @@ errout:
 static int rtnl_fdb_add(struct sk_buff *skb, struct nlmsghdr *nlh, void *arg)
 {
 	struct net *net = sock_net(skb->sk);
-	struct net_device *master = NULL;
 	struct ndmsg *ndm;
 	struct nlattr *tb[NDA_MAX+1];
 	struct net_device *dev;
@@ -2089,9 +2089,10 @@ static int rtnl_fdb_add(struct sk_buff *skb, struct nlmsghdr *nlh, void *arg)
 	/* Support fdb on master device the net/bridge default case */
 	if ((!ndm->ndm_flags || ndm->ndm_flags & NTF_MASTER) &&
 	    (dev->priv_flags & IFF_BRIDGE_PORT)) {
-		master = dev->master;
-		err = master->netdev_ops->ndo_fdb_add(ndm, dev, addr,
-						      nlh->nlmsg_flags);
+		struct net_device *br_dev = netdev_unique_upper_dev_get(dev);
+		const struct net_device_ops *ops = br_dev->netdev_ops;
+
+		err = ops->ndo_fdb_add(ndm, dev, addr, nlh->nlmsg_flags);
 		if (err)
 			goto out;
 		else
@@ -2148,10 +2149,11 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh, void *arg)
 	/* Support fdb on master device the net/bridge default case */
 	if ((!ndm->ndm_flags || ndm->ndm_flags & NTF_MASTER) &&
 	    (dev->priv_flags & IFF_BRIDGE_PORT)) {
-		struct net_device *master = dev->master;
+		struct net_device *br_dev = netdev_unique_upper_dev_get(dev);
+		const struct net_device_ops *ops = br_dev->netdev_ops;
 
-		if (master->netdev_ops->ndo_fdb_del)
-			err = master->netdev_ops->ndo_fdb_del(ndm, dev, addr);
+		if (ops->ndo_fdb_del)
+			err = ops->ndo_fdb_del(ndm, dev, addr);
 
 		if (err)
 			goto out;
@@ -2234,9 +2236,11 @@ static int rtnl_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	rcu_read_lock();
 	for_each_netdev_rcu(net, dev) {
 		if (dev->priv_flags & IFF_BRIDGE_PORT) {
-			struct net_device *master = dev->master;
-			const struct net_device_ops *ops = master->netdev_ops;
+			struct net_device *br_dev;
+			const struct net_device_ops *ops;
 
+			br_dev = netdev_unique_upper_dev_get(dev);
+			ops = br_dev->netdev_ops;
 			if (ops->ndo_fdb_dump)
 				idx = ops->ndo_fdb_dump(skb, cb, dev, idx);
 		}
-- 
1.7.10.4

