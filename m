Date: Fri, 21 May 2004 16:13:47 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040521161347.090a35f4@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] (5/11) bridge - fix deadlock on device removal.
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, bridge@osdl.org

Fix a deadlock where deleting a device call br_del_if with lock held.
br_del_if doesn't want to be called under lock anymore.

diff -Nru a/net/bridge/br_notify.c b/net/bridge/br_notify.c
--- a/net/bridge/br_notify.c	2004-05-21 16:12:47 -07:00
+++ b/net/bridge/br_notify.c	2004-05-21 16:12:47 -07:00
@@ -38,30 +38,35 @@
 
 	br = p->br;
 
-	spin_lock_bh(&br->lock);
-	switch (event) 
-	{
+	switch (event) {
 	case NETDEV_CHANGEADDR:
+		spin_lock_bh(&br->lock);
 		br_fdb_changeaddr(p, dev->dev_addr);
 		if (br->dev->flags & IFF_UP)
 			br_stp_recalculate_bridge_id(br);
+		spin_unlock_bh(&br->lock);
 		break;
 
 	case NETDEV_DOWN:
-		if (br->dev->flags & IFF_UP)
+		if (br->dev->flags & IFF_UP) {
+			spin_lock_bh(&br->lock);
 			br_stp_disable_port(p);
+			spin_unlock_bh(&br->lock);
+		}
 		break;
 
 	case NETDEV_UP:
-		if (br->dev->flags & IFF_UP)
+		if (br->dev->flags & IFF_UP) {
+			spin_lock_bh(&br->lock);
 			br_stp_enable_port(p);
+			spin_unlock_bh(&br->lock);
+		}
 		break;
 
 	case NETDEV_UNREGISTER:
 		br_del_if(br, dev);
 		break;
 	}
-	spin_unlock_bh(&br->lock);
 
 	return NOTIFY_DONE;
 }
