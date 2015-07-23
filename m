Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=0iYNNPrpjv2VTmQxa+UP4iVljicBSm7r9L7X5ib5rx0=;
	b=MkJJsghbnhV46YG89dVt5Vwa1+47jrqH0UHXuy/UnDW32qy7RXoUVs/8czwmJcJ0hZ
	ZKoGCwMzNh3ayyBqsSBT7DhmMXkzYaZt+NG2hpTQJIExl/9iedr9iurszT/XdZzuyaWJ
	+/5rLO80/SIcb5vdg04lCplVPF/bCyNBhI70M=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 23 Jul 2015 05:00:53 -0700
Message-Id: <1437652853-941-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next] bridge: mdb: notify on router port add
	and del
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, davem@davemloft.net

From: Satish Ashok <sashok@cumulusnetworks.com>

Send notifications on router port add and del/expire, re-use the already
existing MDBA_ROUTER and send NEWMDB/DELMDB netlink notifications
respectively.

Signed-off-by: Satish Ashok <sashok@cumulusnetworks.com>
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
note: if this patch is accepted a related iproute2 patch will be sent

 net/bridge/br_mdb.c       | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 net/bridge/br_multicast.c | 10 +++++--
 net/bridge/br_private.h   |  2 ++
 3 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 6a591e6e2d04..5e9d1c5e1194 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -247,6 +247,73 @@ void br_mdb_notify(struct net_device *dev, struct net_bridge_port *port,
 	__br_mdb_notify(dev, &entry, type);
 }
 
+static int nlmsg_populate_rtr_fill(struct sk_buff *skb,
+				   struct net_device *dev,
+				   int ifindex, u32 pid,
+				   u32 seq, int type, unsigned int flags)
+{
+	struct br_port_msg *bpm;
+	struct nlmsghdr *nlh;
+	struct nlattr *nest;
+
+	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*bpm), NLM_F_MULTI);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	bpm = nlmsg_data(nlh);
+	memset(bpm, 0, sizeof(*bpm));
+	bpm->family = AF_BRIDGE;
+	bpm->ifindex = dev->ifindex;
+	nest = nla_nest_start(skb, MDBA_ROUTER);
+	if (!nest)
+		goto cancel;
+
+	if (nla_put_u32(skb, MDBA_ROUTER_PORT, ifindex))
+		goto end;
+
+	nla_nest_end(skb, nest);
+	nlmsg_end(skb, nlh);
+	return 0;
+
+end:
+	nla_nest_end(skb, nest);
+cancel:
+	nlmsg_cancel(skb, nlh);
+	return -EMSGSIZE;
+}
+
+static inline size_t rtnl_rtr_nlmsg_size(void)
+{
+	return NLMSG_ALIGN(sizeof(struct br_port_msg))
+		+ nla_total_size(sizeof(__u32));
+}
+
+void br_rtr_notify(struct net_device *dev, struct net_bridge_port *port,
+		   int type)
+{
+	struct net *net = dev_net(dev);
+	struct sk_buff *skb;
+	int err = -ENOBUFS;
+	int ifindex;
+
+	ifindex = port ? port->dev->ifindex : 0;
+	skb = nlmsg_new(rtnl_rtr_nlmsg_size(), GFP_ATOMIC);
+	if (!skb)
+		goto errout;
+
+	err = nlmsg_populate_rtr_fill(skb, dev, ifindex, 0, 0, type, NTF_SELF);
+	if (err < 0) {
+		kfree_skb(skb);
+		goto errout;
+	}
+
+	rtnl_notify(skb, net, 0, RTNLGRP_MDB, NULL, GFP_ATOMIC);
+	return;
+
+errout:
+	rtnl_set_sk_err(net, RTNLGRP_MDB, err);
+}
+
 static bool is_valid_mdb_entry(struct br_mdb_entry *entry)
 {
 	if (entry->ifindex == 0)
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index ed5dc684a4ce..fd238587e032 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -766,6 +766,7 @@ static void br_multicast_router_expired(unsigned long data)
 		goto out;
 
 	hlist_del_init_rcu(&port->rlist);
+	br_rtr_notify(br->dev, port, RTM_DELMDB);
 
 out:
 	spin_unlock(&br->multicast_lock);
@@ -977,8 +978,10 @@ void br_multicast_disable_port(struct net_bridge_port *port)
 		if (pg->state == MDB_TEMPORARY)
 			br_multicast_del_pg(br, pg);
 
-	if (!hlist_unhashed(&port->rlist))
+	if (!hlist_unhashed(&port->rlist)) {
 		hlist_del_init_rcu(&port->rlist);
+		br_rtr_notify(br->dev, port, RTM_DELMDB);
+	}
 	del_timer(&port->multicast_router_timer);
 	del_timer(&port->ip4_own_query.timer);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1216,6 +1219,7 @@ static void br_multicast_add_router(struct net_bridge *br,
 		hlist_add_behind_rcu(&port->rlist, slot);
 	else
 		hlist_add_head_rcu(&port->rlist, &br->router_list);
+	br_rtr_notify(br->dev, port, RTM_NEWMDB);
 }
 
 static void br_multicast_mark_router(struct net_bridge *br,
@@ -1848,8 +1852,10 @@ int br_multicast_set_port_router(struct net_bridge_port *p, unsigned long val)
 		p->multicast_router = val;
 		err = 0;
 
-		if (val < 2 && !hlist_unhashed(&p->rlist))
+		if (val < 2 && !hlist_unhashed(&p->rlist)) {
 			hlist_del_init_rcu(&p->rlist);
+			br_rtr_notify(br->dev, p, RTM_DELMDB);
+		}
 
 		if (val == 1)
 			break;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 3ad1290528af..e2cb359f9dd3 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -490,6 +490,8 @@ void br_mdb_init(void);
 void br_mdb_uninit(void);
 void br_mdb_notify(struct net_device *dev, struct net_bridge_port *port,
 		   struct br_ip *group, int type, u8 state);
+void br_rtr_notify(struct net_device *dev, struct net_bridge_port *port,
+		   int type);
 
 #define mlock_dereference(X, br) \
 	rcu_dereference_protected(X, lockdep_is_held(&br->multicast_lock))
-- 
2.4.3

