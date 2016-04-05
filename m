Return-Path: <lucien.xin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=KndCAHC/403/eDQ9lAZo0DLX5IkB0ZYRUqI09SmOOuo=;
	b=nxSj7uH+zup5w348PFGR2R4rSUfxFaeHE3u1UIhPX9yHH7FohnSsUCHbus6aHfjSjy
	cz/4n8U8AxCbzF31xO4XV0lEgFMknCV/NlGr6OtLwI0ouJ0LwLvyDBur8MrvT822CsMd
	msYpH4CMTRMfpEukDbj4BtIaQdCLuMrhIyfOildfQV6lC/0EbgF+DOjCR+qq17bDg409
	yd9BNiGWjGIhYSPOEygwDLdn88Ova4wj58OxAqlXMLEI1FAIxQW7WEcSE+GfUh4W/NGy
	coZGwzitzivYf+cJN5B65g4fu3/St2I79A0rSjZNI4jRKWhrkoumLtLR/heG/rP7hm7t
	faQg==
From: Xin Long <lucien.xin@gmail.com>
Date: Tue,  5 Apr 2016 11:32:41 +0800
Message-Id: <39a9cc4a663ed22b442a1424b4de21d21c4438cb.1459827115.git.lucien.xin@gmail.com>
In-Reply-To: <d6f49fd173d183b78c4dd4e18e67d394438f5d7d.1459827115.git.lucien.xin@gmail.com>
References: <cover.1459827115.git.lucien.xin@gmail.com>
	<6e2cf6821542a253904dfc7d8ec431d6bbda2b4e.1459827115.git.lucien.xin@gmail.com>
	<6197a35a2eb6df2caf90edcbf1b49da12077f659.1459827115.git.lucien.xin@gmail.com>
	<baf4788b6ac529a2132ace735fc1caf4989307da.1459827115.git.lucien.xin@gmail.com>
	<9bf0874c74438a287968ef5190599214333b52be.1459827115.git.lucien.xin@gmail.com>
	<d6f49fd173d183b78c4dd4e18e67d394438f5d7d.1459827115.git.lucien.xin@gmail.com>
In-Reply-To: <cover.1459827115.git.lucien.xin@gmail.com>
References: <cover.1459827115.git.lucien.xin@gmail.com>
Subject: [Bridge] [PATCHv2 net-next 6/6] bridge: a netlink notification
	should be sent when those attributes are changed by ioctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: network dev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org
Cc: nikolay@cumulusnetworks.com, davem@davemloft.net

Now when we change the attributes of bridge or br_port by netlink,
a relevant netlink notification will be sent, but if we change them
by ioctl or sysfs, no notification will be sent.

We should ensure that whenever those attributes change internally or from
sysfs/ioctl, that a netlink notification is sent out to listeners.

Also, NetworkManager will use this in the future to listen for out-of-band
bridge master attribute updates and incorporate them into the runtime
configuration.

This patch is used for ioctl.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/bridge/br_ioctl.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index 263b4de..f8fc624 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -112,7 +112,9 @@ static int add_del_if(struct net_bridge *br, int ifindex, int isadd)
 static int old_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct net_bridge *br = netdev_priv(dev);
+	struct net_bridge_port *p = NULL;
 	unsigned long args[4];
+	int ret = -EOPNOTSUPP;
 
 	if (copy_from_user(args, rq->ifr_data, sizeof(args)))
 		return -EFAULT;
@@ -182,25 +184,29 @@ static int old_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 		if (!ns_capable(dev_net(dev)->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 
-		return br_set_forward_delay(br, args[1]);
+		ret = br_set_forward_delay(br, args[1]);
+		break;
 
 	case BRCTL_SET_BRIDGE_HELLO_TIME:
 		if (!ns_capable(dev_net(dev)->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 
-		return br_set_hello_time(br, args[1]);
+		ret = br_set_hello_time(br, args[1]);
+		break;
 
 	case BRCTL_SET_BRIDGE_MAX_AGE:
 		if (!ns_capable(dev_net(dev)->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 
-		return br_set_max_age(br, args[1]);
+		ret = br_set_max_age(br, args[1]);
+		break;
 
 	case BRCTL_SET_AGEING_TIME:
 		if (!ns_capable(dev_net(dev)->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 
-		return br_set_ageing_time(br, args[1]);
+		ret = br_set_ageing_time(br, args[1]);
+		break;
 
 	case BRCTL_GET_PORT_INFO:
 	{
@@ -240,20 +246,19 @@ static int old_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 			return -EPERM;
 
 		br_stp_set_enabled(br, args[1]);
-		return 0;
+		ret = 0;
+		break;
 
 	case BRCTL_SET_BRIDGE_PRIORITY:
 		if (!ns_capable(dev_net(dev)->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 
 		br_stp_set_bridge_priority(br, args[1]);
-		return 0;
+		ret = 0;
+		break;
 
 	case BRCTL_SET_PORT_PRIORITY:
 	{
-		struct net_bridge_port *p;
-		int ret;
-
 		if (!ns_capable(dev_net(dev)->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 
@@ -263,14 +268,11 @@ static int old_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 		else
 			ret = br_stp_set_port_priority(p, args[2]);
 		spin_unlock_bh(&br->lock);
-		return ret;
+		break;
 	}
 
 	case BRCTL_SET_PATH_COST:
 	{
-		struct net_bridge_port *p;
-		int ret;
-
 		if (!ns_capable(dev_net(dev)->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 
@@ -280,8 +282,7 @@ static int old_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 		else
 			ret = br_stp_set_path_cost(p, args[2]);
 		spin_unlock_bh(&br->lock);
-
-		return ret;
+		break;
 	}
 
 	case BRCTL_GET_FDB_ENTRIES:
@@ -289,7 +290,14 @@ static int old_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 				       args[2], args[3]);
 	}
 
-	return -EOPNOTSUPP;
+	if (!ret) {
+		if (p)
+			br_ifinfo_notify(RTM_NEWLINK, p);
+		else
+			netdev_state_change(br->dev);
+	}
+
+	return ret;
 }
 
 static int old_deviceless(struct net *net, void __user *uarg)
-- 
2.1.0

