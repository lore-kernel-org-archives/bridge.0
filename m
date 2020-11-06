Return-Path: <arnd@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604701091;
 bh=BR+zYR3Dm83q9tUsfJZzsFi0e5w5L0IGNArcvO9ow8I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bi+lDzBo1ePiWdn/VM2k639J0e48uV9m25v+HdVm1B5ZrTJOGAAsnmK2eb1wd6bUC
 UaecT3Awtytx7aWt3xk23Z4rBeuTBeU7JtA2uQvht8OKRuLCMZ5q+WXJZ/bDwUKQmY
 ShaAoDaSb5UQRzAaWbQ2gN7MuG6UGmQPkHGImBo0=
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri,  6 Nov 2020 23:17:21 +0100
Message-Id: <20201106221743.3271965-7-arnd@kernel.org>
In-Reply-To: <20201106221743.3271965-1-arnd@kernel.org>
References: <20201106221743.3271965-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC net-next 06/28] bridge: use ndo_siocdevprivate
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Jakub Kicinski <kuba@kernel.org>, linux-hams@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, Christoph Hellwig <hch@lst.de>, Heiner Kallweit <hkallweit1@gmail.com>

From: Arnd Bergmann <arnd@arndb.de>

The bridge driver has an old set of ioctls using the SIOCDEVPRIVATE
namespace that have never worked in compat mode and are explicitly
forbidden already.

Move them over to ndo_siocdevprivate and fix compat mode for these,
because we can.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/bridge/br_device.c  |  1 +
 net/bridge/br_ioctl.c   | 36 ++++++++++++++++++++++++------------
 net/bridge/br_private.h |  2 ++
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 6f742fee874a..c272fa57110d 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -409,6 +409,7 @@ static const struct net_device_ops br_netdev_ops = {
 	.ndo_change_rx_flags	 = br_dev_change_rx_flags,
 	.ndo_change_mtu		 = br_change_mtu,
 	.ndo_do_ioctl		 = br_dev_ioctl,
+	.ndo_siocdevprivate	 = br_dev_siocdevprivate,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_netpoll_setup	 = br_netpoll_setup,
 	.ndo_netpoll_cleanup	 = br_netpoll_cleanup,
diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index 2db800fc27ca..7fbfeb735bad 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -106,15 +106,31 @@ static int add_del_if(struct net_bridge *br, int ifindex, int isadd)
  * This interface is deprecated because it was too difficult
  * to do the translation for 32/64bit ioctl compatibility.
  */
-static int old_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+int br_dev_siocdevprivate(struct net_device *dev, struct ifreq *rq, void __user *data, int cmd)
 {
 	struct net_bridge *br = netdev_priv(dev);
 	struct net_bridge_port *p = NULL;
 	unsigned long args[4];
+	void __user *argp;
 	int ret = -EOPNOTSUPP;
 
-	if (copy_from_user(args, rq->ifr_data, sizeof(args)))
-		return -EFAULT;
+	if (in_compat_syscall()) {
+		unsigned int cargs[4];
+		if (copy_from_user(cargs, data, sizeof(cargs)))
+			return -EFAULT;
+
+		args[0] = cargs[0];
+		args[1] = cargs[1];
+		args[2] = cargs[2];
+		args[3] = cargs[3];
+
+		argp = compat_ptr(args[1]);
+	} else {
+		if (copy_from_user(args, data, sizeof(args)))
+			return -EFAULT;
+
+		argp = (void __user *)args[1];
+	}
 
 	switch (args[0]) {
 	case BRCTL_ADD_IF:
@@ -171,7 +187,7 @@ static int old_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 			return -ENOMEM;
 
 		get_port_ifindices(br, indices, num);
-		if (copy_to_user((void __user *)args[1], indices, num*sizeof(int)))
+		if (copy_to_user(argp, indices, num*sizeof(int)))
 			num =  -EFAULT;
 		kfree(indices);
 		return num;
@@ -232,7 +248,7 @@ static int old_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 
 		rcu_read_unlock();
 
-		if (copy_to_user((void __user *)args[1], &p, sizeof(p)))
+		if (copy_to_user(argp, &p, sizeof(p)))
 			return -EFAULT;
 
 		return 0;
@@ -282,8 +298,7 @@ static int old_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 	}
 
 	case BRCTL_GET_FDB_ENTRIES:
-		return get_fdb_entries(br, (void __user *)args[1],
-				       args[2], args[3]);
+		return get_fdb_entries(br, argp, args[2], args[3]);
 	}
 
 	if (!ret) {
@@ -320,7 +335,7 @@ static int old_deviceless(struct net *net, void __user *uarg)
 
 		args[2] = get_bridge_ifindices(net, indices, args[2]);
 
-		ret = copy_to_user((void __user *)args[1], indices, args[2]*sizeof(int))
+		ret = copy_to_user(uarg, indices, args[2]*sizeof(int))
 			? -EFAULT : args[2];
 
 		kfree(indices);
@@ -335,7 +350,7 @@ static int old_deviceless(struct net *net, void __user *uarg)
 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 
-		if (copy_from_user(buf, (void __user *)args[1], IFNAMSIZ))
+		if (copy_from_user(buf, uarg, IFNAMSIZ))
 			return -EFAULT;
 
 		buf[IFNAMSIZ-1] = 0;
@@ -383,9 +398,6 @@ int br_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 	struct net_bridge *br = netdev_priv(dev);
 
 	switch (cmd) {
-	case SIOCDEVPRIVATE:
-		return old_dev_ioctl(dev, rq, cmd);
-
 	case SIOCBRADDIF:
 	case SIOCBRDELIF:
 		return add_del_if(br, rq->ifr_ifindex, cmd == SIOCBRADDIF);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 345118e35c42..a788fcdd2adf 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -778,6 +778,8 @@ br_port_get_check_rtnl(const struct net_device *dev)
 
 /* br_ioctl.c */
 int br_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
+int br_dev_siocdevprivate(struct net_device *dev, struct ifreq *rq,
+			  void __user *data, int cmd);
 int br_ioctl_deviceless_stub(struct net *net, unsigned int cmd,
 			     void __user *arg);
 
-- 
2.27.0

