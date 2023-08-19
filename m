Return-Path: <astrajoan@yahoo.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE63060D72
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 02C9560D67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1692432663; bh=yZlxb67YxQ05+BNzviKsC0qXM3c0kTm174EVaqNUEZg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=VKAAhKpulkouLhZw744eXwSXec+lnLkU238lhZGIIzwuuiZJo/mkRCBp3q42tIyQdshVLHqeff9GvrppsRqCWKIApM70vFGIHrcW+619QxFQDQmXs8EEEmTR7OMfgdFzb0E4kY7NxZ1eiNUSHJVyubZelp6FRoRM3xUdXQQ1ZRxMeo9LG25/rGw/Ft7MGh60taVdsykD+BsBnDM5jPShoQA+zy8FmI5xbg5LPm+K7k3TJCNLLVuEr6wj//Omv3YrnbnTtC5PEGQmVsjOW1AXr57+dNioom3x40eoaznhLfQcy3jZ+D8SfaESO4YI/a9Z/05btkb/QHnZvH/KAGd4gQ==
From: Ziqi Zhao <astrajoan@yahoo.com>
Date: Sat, 19 Aug 2023 01:10:57 -0700
Message-Id: <20230819081057.330728-1-astrajoan@yahoo.com>
In-Reply-To: <00000000000051197705fdbc7e54@google.com>
References: <00000000000051197705fdbc7e54@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH] net: bridge: Fix refcnt issues in dev_ioctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: arnd@arndb.de, bridge@lists.linux-foundation.org, davem@davemloft.net, edumazet@google.com, f.fainelli@gmail.com, ivan.orlov0322@gmail.com, keescook@chromium.org, kuba@kernel.org, hkallweit1@gmail.com, mudongliangabcd@gmail.com, nikolay@nvidia.com, pabeni@redhat.com, razor@blackwall.org, roopa@nvidia.com, skhan@linuxfoundation.org, syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com, vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, Ziqi Zhao <astrajoan@yahoo.com>

In the bug reported by Syzbot, certain bridge devices would have a
leaked reference created by race conditions in dev_ioctl, specifically,
under SIOCBRADDIF or SIOCBRDELIF operations. The reference leak would
be shown in the periodic unregister_netdevice call, which throws a
warning and cause Syzbot to report a crash. Upon inspection of the
logic in dev_ioctl, it seems the reference was introduced to ensure
proper access to the bridge device after rtnl_unlock. and the latter
function is necessary to maintain the following lock order in any
bridge related ioctl calls:

1) br_ioctl_mutex => 2) rtnl_lock

Conceptually, though, br_ioctl_mutex could be considered more specific
than rtnl_lock given their usages, hence swapping their order would be
a reasonable proposal. This patch changes all related call sites to
maintain the reversed order of the two locks:

1) rtnl_lock => 2) br_ioctl_mutex

By doing so, the extra reference introduced in dev_ioctl is no longer
needed, and hence the reference leak bug is now resolved.

Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Fixes: ad2f99aedf8f ("net: bridge: move bridge ioctls out of .ndo_do_ioctl")
Signed-off-by: Ziqi Zhao <astrajoan@yahoo.com>
---
 net/bridge/br_ioctl.c | 4 ----
 net/core/dev_ioctl.c  | 8 +-------
 net/socket.c          | 2 ++
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index f213ed108361..291dbc5d2a99 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -399,8 +399,6 @@ int br_ioctl_stub(struct net *net, struct net_bridge *br, unsigned int cmd,
 {
 	int ret = -EOPNOTSUPP;
 
-	rtnl_lock();
-
 	switch (cmd) {
 	case SIOCGIFBR:
 	case SIOCSIFBR:
@@ -434,7 +432,5 @@ int br_ioctl_stub(struct net *net, struct net_bridge *br, unsigned int cmd,
 		break;
 	}
 
-	rtnl_unlock();
-
 	return ret;
 }
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 3730945ee294..17df956df8cb 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -336,7 +336,6 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 	int err;
 	struct net_device *dev = __dev_get_by_name(net, ifr->ifr_name);
 	const struct net_device_ops *ops;
-	netdevice_tracker dev_tracker;
 
 	if (!dev)
 		return -ENODEV;
@@ -405,12 +404,7 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 			return -ENODEV;
 		if (!netif_is_bridge_master(dev))
 			return -EOPNOTSUPP;
-		netdev_hold(dev, &dev_tracker, GFP_KERNEL);
-		rtnl_unlock();
-		err = br_ioctl_call(net, netdev_priv(dev), cmd, ifr, NULL);
-		netdev_put(dev, &dev_tracker);
-		rtnl_lock();
-		return err;
+		return br_ioctl_call(net, netdev_priv(dev), cmd, ifr, NULL);
 
 	case SIOCDEVPRIVATE ... SIOCDEVPRIVATE + 15:
 		return dev_siocdevprivate(dev, ifr, data, cmd);
diff --git a/net/socket.c b/net/socket.c
index 2b0e54b2405c..6b7a9df9a326 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1258,7 +1258,9 @@ static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		case SIOCSIFBR:
 		case SIOCBRADDBR:
 		case SIOCBRDELBR:
+			rtnl_lock();
 			err = br_ioctl_call(net, NULL, cmd, NULL, argp);
+			rtnl_unlock();
 			break;
 		case SIOCGIFVLAN:
 		case SIOCSIFVLAN:
-- 
2.34.1

