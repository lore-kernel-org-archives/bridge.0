Return-Path: <acadx0@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Xf2ZZ4dUjskn2wzoA/na9mrwqcf1U/CnBUU6ZdkyGNw=;
 b=f0x0Mp1+aw8gyzjTYOE2fGveQDjihAKtSAu5Rl/PbG2mSba8TWJbdNQybJpHwg0TS6
 6XJqRb65/IRp/ibW7qXiIgZWjxkofIzOQWvOXl1C1QXeB11zHRj76YDAUHvXdO+CMXle
 jeqTtZ6V9KhkJZnLXZ23/ewqjl1wTla2RrEWewTCB5Rkj7azHWlUQvjfgqFtDgfxSoXZ
 lXKiUtEhap+ac5MeL0A/Tv9VpEUJYZ9vNrSPaTBpgG0oWorTuwe151VKmmUBp9WaAt+x
 c/uMB2pnah2UIFTf9JHyUhHdh58vQydFY6VNAHEiU+L6ZFiRvnikjhdjVz9DAwpsl0zT
 xrpQ==
From: Kyungrok Chung <acadx0@gmail.com>
Date: Tue, 12 Oct 2021 23:18:09 +0900
Message-Id: <20211012141810.30661-1-acadx0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] net: bridge: make use of helper
	netif_is_bridge_master()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Make use of netdev helper functions to improve code readability.
Replace 'dev->priv_flags & IFF_EBRIDGE' with netif_is_bridge_master(dev).

Signed-off-by: Kyungrok Chung <acadx0@gmail.com>
---
 net/bridge/br.c                 | 4 ++--
 net/bridge/br_fdb.c             | 6 +++---
 net/bridge/br_if.c              | 2 +-
 net/bridge/br_ioctl.c           | 2 +-
 net/bridge/br_mdb.c             | 4 ++--
 net/bridge/br_netfilter_hooks.c | 2 +-
 net/bridge/br_netlink.c         | 4 ++--
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index d3a32c6813e0..1fac72cc617f 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -36,7 +36,7 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
 	bool changed_addr;
 	int err;
 
-	if (dev->priv_flags & IFF_EBRIDGE) {
+	if (netif_is_bridge_master(dev)) {
 		err = br_vlan_bridge_event(dev, event, ptr);
 		if (err)
 			return notifier_from_errno(err);
@@ -349,7 +349,7 @@ static void __net_exit br_net_exit(struct net *net)
 
 	rtnl_lock();
 	for_each_netdev(net, dev)
-		if (dev->priv_flags & IFF_EBRIDGE)
+		if (netif_is_bridge_master(dev))
 			br_dev_delete(dev, &list);
 
 	unregister_netdevice_many(&list);
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 46812b659710..a6a68e18c70a 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -825,7 +825,7 @@ int br_fdb_dump(struct sk_buff *skb,
 	struct net_bridge_fdb_entry *f;
 	int err = 0;
 
-	if (!(dev->priv_flags & IFF_EBRIDGE))
+	if (!netif_is_bridge_master(dev))
 		return err;
 
 	if (!filter_dev) {
@@ -1076,7 +1076,7 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 		return -EINVAL;
 	}
 
-	if (dev->priv_flags & IFF_EBRIDGE) {
+	if (netif_is_bridge_master(dev)) {
 		br = netdev_priv(dev);
 		vg = br_vlan_group(br);
 	} else {
@@ -1173,7 +1173,7 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 	struct net_bridge *br;
 	int err;
 
-	if (dev->priv_flags & IFF_EBRIDGE) {
+	if (netif_is_bridge_master(dev)) {
 		br = netdev_priv(dev);
 		vg = br_vlan_group(br);
 	} else {
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 4a02f8bb278a..c11bba3e7ec0 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -471,7 +471,7 @@ int br_del_bridge(struct net *net, const char *name)
 	if (dev == NULL)
 		ret =  -ENXIO; 	/* Could not find device */
 
-	else if (!(dev->priv_flags & IFF_EBRIDGE)) {
+	else if (!netif_is_bridge_master(dev)) {
 		/* Attempt to delete non bridge device! */
 		ret = -EPERM;
 	}
diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index 49c268871fc1..db4ab2c2ce18 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -26,7 +26,7 @@ static int get_bridge_ifindices(struct net *net, int *indices, int num)
 	for_each_netdev_rcu(net, dev) {
 		if (i >= num)
 			break;
-		if (dev->priv_flags & IFF_EBRIDGE)
+		if (netif_is_bridge_master(dev))
 			indices[i++] = dev->ifindex;
 	}
 	rcu_read_unlock();
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 0281453f7766..61ccf46fcc21 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -422,7 +422,7 @@ static int br_mdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	cb->seq = net->dev_base_seq;
 
 	for_each_netdev_rcu(net, dev) {
-		if (dev->priv_flags & IFF_EBRIDGE) {
+		if (netif_is_bridge_master(dev)) {
 			struct net_bridge *br = netdev_priv(dev);
 			struct br_port_msg *bpm;
 
@@ -1016,7 +1016,7 @@ static int br_mdb_parse(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -ENODEV;
 	}
 
-	if (!(dev->priv_flags & IFF_EBRIDGE)) {
+	if (!netif_is_bridge_master(dev)) {
 		NL_SET_ERR_MSG_MOD(extack, "Device is not a bridge");
 		return -EOPNOTSUPP;
 	}
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 8edfb98ae1d5..b5af68c105a8 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -968,7 +968,7 @@ static int brnf_device_event(struct notifier_block *unused, unsigned long event,
 	struct net *net;
 	int ret;
 
-	if (event != NETDEV_REGISTER || !(dev->priv_flags & IFF_EBRIDGE))
+	if (event != NETDEV_REGISTER || !netif_is_bridge_master(dev))
 		return NOTIFY_DONE;
 
 	ASSERT_RTNL();
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 5c6c4305ed23..0c8b5f1a15bc 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -106,7 +106,7 @@ static size_t br_get_link_af_size_filtered(const struct net_device *dev,
 		p = br_port_get_check_rcu(dev);
 		if (p)
 			vg = nbp_vlan_group_rcu(p);
-	} else if (dev->priv_flags & IFF_EBRIDGE) {
+	} else if (netif_is_bridge_master(dev)) {
 		br = netdev_priv(dev);
 		vg = br_vlan_group_rcu(br);
 	}
@@ -1050,7 +1050,7 @@ int br_dellink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags)
 
 	p = br_port_get_rtnl(dev);
 	/* We want to accept dev as bridge itself as well */
-	if (!p && !(dev->priv_flags & IFF_EBRIDGE))
+	if (!p && !netif_is_bridge_master(dev))
 		return -EINVAL;
 
 	err = br_afspec(br, p, afspec, RTM_DELLINK, &changed, NULL);
-- 
2.33.0

