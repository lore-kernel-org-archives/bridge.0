From: David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain
Message-Id: <1084545291.4739.4.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Fri, 14 May 2004 15:34:51 +0100
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Deadlock on device removal in 2.6.6
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

br_device_event() locks br->lock before calling br_del_if() which
attempts to do likewise. This is one way of fixing it.

===== net/bridge/br_if.c 1.28 vs edited =====
--- 1.28/net/bridge/br_if.c	Fri Apr 16 22:23:15 2004
+++ edited/net/bridge/br_if.c	Fri May 14 15:17:37 2004
@@ -295,12 +295,11 @@
 	return err;
 }
 
-int br_del_if(struct net_bridge *br, struct net_device *dev)
+int br_del_if_locked(struct net_bridge *br, struct net_device *dev)
 {
 	struct net_bridge_port *p;
 	int err = 0;
 
-	spin_lock_bh(&br->lock);
 	p = dev->br_port;
 	if (!p || p->br != br) 
 		err = -EINVAL;
@@ -308,9 +307,19 @@
 		del_nbp(p);
 		br_stp_recalculate_bridge_id(br);
 	}
-	spin_unlock_bh(&br->lock);
 
 	return err;
+}
+
+int br_del_if(struct net_bridge *br, struct net_device *dev)
+{
+	int ret;
+
+	spin_lock_bh(&br->lock);
+	ret = br_del_if_locked(br, dev);
+	spin_unlock_bh(&br->lock);
+
+	return ret;
 }
 
 int br_get_bridge_ifindices(int *indices, int num)
===== net/bridge/br_notify.c 1.7 vs edited =====
--- 1.7/net/bridge/br_notify.c	Fri Apr 16 22:11:46 2004
+++ edited/net/bridge/br_notify.c	Fri May 14 15:16:43 2004
@@ -58,7 +58,7 @@
 		break;
 
 	case NETDEV_UNREGISTER:
-		br_del_if(br, dev);
+		br_del_if_locked(br, dev);
 		break;
 	}
 	spin_unlock_bh(&br->lock);
===== net/bridge/br_private.h 1.23 vs edited =====
--- 1.23/net/bridge/br_private.h	Fri Apr 16 22:22:36 2004
+++ edited/net/bridge/br_private.h	Fri May 14 15:18:49 2004
@@ -166,6 +166,8 @@
 extern void br_cleanup_bridges(void);
 extern int br_add_if(struct net_bridge *br,
 	      struct net_device *dev);
+extern int br_del_if_locked(struct net_bridge *br,
+	      struct net_device *dev);
 extern int br_del_if(struct net_bridge *br,
 	      struct net_device *dev);
 extern int br_get_bridge_ifindices(int *indices,

-- 
dwmw2


