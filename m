Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lVLHJ/rUmIwH9d0tsdHnyim0dUDtw7h/R/oKAOMcOow=;
 b=HGgzHK/h8rwIMMCGNhJLnbHrTLp+DPUIPwB2Se2+Id4KuCpvSM91lRJFhQgqId8dVx
 wuyELm8tj3UoJCkzsmorfzwOSgjQcU7JWvz3Ulk9ThzrO1nK61BLkmnRGiDB02bjIQTx
 pY+nSbI+YXnM/2KGZhKsD5iufQ/Y61EBrLNXqXIl19W1o5h8fzI5PAddkvYNuQKLVr0W
 jBcFAbOf5cTDlxBwvC4cawXxDg3/j/xGwoYzHz5lKzmG3+s9t3n6skdnI8ozAg0MRu4K
 76KeSv+9YqDgcq/GF3B4TxeTVYujaqyzhZmZo6+ttBa0Z1/atIJsFisRd3uNwYtq024T
 w0vQ==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Thu,  5 Aug 2021 11:29:01 +0300
Message-Id: <20210805082903.711396-2-razor@blackwall.org>
In-Reply-To: <20210805082903.711396-1-razor@blackwall.org>
References: <20210805082903.711396-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 1/3] net: bridge: fix ioctl locking
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: syzbot+34fe5894623c4ab1b379@syzkaller.appspotmail.com, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, arnd@arndb.de, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Before commit ad2f99aedf8f ("net: bridge: move bridge ioctls out of
.ndo_do_ioctl") the bridge ioctl calls were divided in two parts:
one was deviceless called by sock_ioctl and didn't expect rtnl to be held,
the other was with a device called by dev_ifsioc() and expected rtnl to be
held. After the commit above they were united in a single ioctl stub, but
it didn't take care of the locking expectations.
For sock_ioctl now we acquire  (1) br_ioctl_mutex, (2) rtnl
and for dev_ifsioc we acquire  (1) rtnl,           (2) br_ioctl_mutex

The fix is to get a refcnt on the netdev for dev_ifsioc calls and drop rtnl
then to reacquire it in the bridge ioctl stub after br_ioctl_mutex has
been acquired. That will avoid playing locking games and make the rules
straight-forward: we always take br_ioctl_mutex first, and then rtnl.

Reported-by: syzbot+34fe5894623c4ab1b379@syzkaller.appspotmail.com
Fixes: ad2f99aedf8f ("net: bridge: move bridge ioctls out of .ndo_do_ioctl")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_if.c    |  4 +---
 net/bridge/br_ioctl.c | 37 ++++++++++++++++++++++++-------------
 net/core/dev_ioctl.c  |  7 ++++++-
 3 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 86f6d7e93ea8..67c60240b713 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -456,7 +456,7 @@ int br_add_bridge(struct net *net, const char *name)
 	dev_net_set(dev, net);
 	dev->rtnl_link_ops = &br_link_ops;
 
-	res = register_netdev(dev);
+	res = register_netdevice(dev);
 	if (res)
 		free_netdev(dev);
 	return res;
@@ -467,7 +467,6 @@ int br_del_bridge(struct net *net, const char *name)
 	struct net_device *dev;
 	int ret = 0;
 
-	rtnl_lock();
 	dev = __dev_get_by_name(net, name);
 	if (dev == NULL)
 		ret =  -ENXIO; 	/* Could not find device */
@@ -485,7 +484,6 @@ int br_del_bridge(struct net *net, const char *name)
 	else
 		br_dev_delete(dev, NULL);
 
-	rtnl_unlock();
 	return ret;
 }
 
diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index 46a24c20e405..2f848de3e755 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -369,33 +369,44 @@ static int old_deviceless(struct net *net, void __user *uarg)
 int br_ioctl_stub(struct net *net, struct net_bridge *br, unsigned int cmd,
 		  struct ifreq *ifr, void __user *uarg)
 {
+	int ret = -EOPNOTSUPP;
+
+	rtnl_lock();
+
 	switch (cmd) {
 	case SIOCGIFBR:
 	case SIOCSIFBR:
-		return old_deviceless(net, uarg);
-
+		ret = old_deviceless(net, uarg);
+		break;
 	case SIOCBRADDBR:
 	case SIOCBRDELBR:
 	{
 		char buf[IFNAMSIZ];
 
-		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
-			return -EPERM;
+		if (!ns_capable(net->user_ns, CAP_NET_ADMIN)) {
+			ret = -EPERM;
+			break;
+		}
 
-		if (copy_from_user(buf, uarg, IFNAMSIZ))
-			return -EFAULT;
+		if (copy_from_user(buf, uarg, IFNAMSIZ)) {
+			ret = -EFAULT;
+			break;
+		}
 
 		buf[IFNAMSIZ-1] = 0;
 		if (cmd == SIOCBRADDBR)
-			return br_add_bridge(net, buf);
-
-		return br_del_bridge(net, buf);
+			ret = br_add_bridge(net, buf);
+		else
+			ret = br_del_bridge(net, buf);
 	}
-
+		break;
 	case SIOCBRADDIF:
 	case SIOCBRDELIF:
-		return add_del_if(br, ifr->ifr_ifindex, cmd == SIOCBRADDIF);
-
+		ret = add_del_if(br, ifr->ifr_ifindex, cmd == SIOCBRADDIF);
+		break;
 	}
-	return -EOPNOTSUPP;
+
+	rtnl_unlock();
+
+	return ret;
 }
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 4035bce06bf8..ff16326f5903 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -379,7 +379,12 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 	case SIOCBRDELIF:
 		if (!netif_device_present(dev))
 			return -ENODEV;
-		return br_ioctl_call(net, netdev_priv(dev), cmd, ifr, NULL);
+		dev_hold(dev);
+		rtnl_unlock();
+		err = br_ioctl_call(net, netdev_priv(dev), cmd, ifr, NULL);
+		dev_put(dev);
+		rtnl_lock();
+		return err;
 
 	case SIOCSHWTSTAMP:
 		err = net_hwtstamp_validate(ifr);
-- 
2.31.1

