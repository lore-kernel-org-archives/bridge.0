Date: Wed, 30 Jun 2004 10:32:08 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] MTU Question
Message-Id: <20040630103208.07fd4ea4@dell_ss3.pdx.osdl.net>
In-Reply-To: <002001c45ebb$86e7ccd0$8805640a@internal.watertech.com>
References: <1bde01c45e35$79cb70f0$8805640a@internal.watertech.com>
	<33053.63.170.215.71.1088569335.squirrel@www.osdl.org>
	<002001c45ebb$86e7ccd0$8805640a@internal.watertech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Chris Shaw <chriss@watertech.com>
Cc: bridge@osdl.org


Try the following (2.4) patch to allow bridge to be MTU aware.

diff -Nru a/net/bridge/br_device.c b/net/bridge/br_device.c
--- a/net/bridge/br_device.c	2004-06-30 10:30:31 -07:00
+++ b/net/bridge/br_device.c	2004-06-30 10:30:31 -07:00
@@ -121,6 +121,22 @@
 	return -1;
 }
 
+static int br_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct net_bridge *br = dev->priv;
+	int max_mtu;
+
+	read_lock_bh(&br->lock);
+	max_mtu = br_min_mtu(br);
+	read_unlock_bh(&br->lock);
+
+	if (new_mtu < 68 || new_mtu > max_mtu)
+		return -EINVAL;
+
+	dev->mtu = new_mtu;
+	return 0;
+}
+
 void br_dev_setup(struct net_device *dev)
 {
 	memset(dev->dev_addr, 0, ETH_ALEN);
@@ -134,4 +150,5 @@
 	dev->accept_fastpath = br_dev_accept_fastpath;
 	dev->tx_queue_len = 0;
 	dev->set_mac_address = NULL;
+	dev->change_mtu = br_change_mtu;
 }
diff -Nru a/net/bridge/br_if.c b/net/bridge/br_if.c
--- a/net/bridge/br_if.c	2004-06-30 10:30:31 -07:00
+++ b/net/bridge/br_if.c	2004-06-30 10:30:31 -07:00
@@ -220,6 +220,24 @@
 	return 0;
 }
 
+int br_min_mtu(struct net_bridge *br)
+{
+	struct net_bridge_port *p;
+	int mtu;
+
+	p = br->port_list;
+	if (!p)
+		mtu = 1500;
+	else {
+		mtu = p->dev->mtu;
+		while ((p = p->next) != NULL) {
+			if (p->dev->mtu < mtu)
+				mtu = p->dev->mtu;
+		}
+	}
+	return mtu;
+}
+
 int br_add_if(struct net_bridge *br, struct net_device *dev)
 {
 	struct net_bridge_port *p;
@@ -250,6 +268,7 @@
 	br_fdb_insert(br, p, dev->dev_addr, 1);
 	if ((br->dev.flags & IFF_UP) && (dev->flags & IFF_UP))
 		br_stp_enable_port(p);
+	br->dev.mtu = br_min_mtu(dev->priv);
 	write_unlock_bh(&br->lock);
 
 	return 0;
diff -Nru a/net/bridge/br_private.h b/net/bridge/br_private.h
--- a/net/bridge/br_private.h	2004-06-30 10:30:31 -07:00
+++ b/net/bridge/br_private.h	2004-06-30 10:30:31 -07:00
@@ -164,6 +164,7 @@
 			    int num);
 extern void br_get_port_ifindices(struct net_bridge *br,
 			   int *ifindices);
+extern int br_min_mtu(struct net_bridge *br);
 
 /* br_input.c */
 extern void br_handle_frame(struct sk_buff *skb);
