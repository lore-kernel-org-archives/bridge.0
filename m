Date: Mon, 2 Aug 2004 13:08:40 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040802130840.434c409b@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040802153128.GA5423@man.manty.net>
References: <20040802153128.GA5423@man.manty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] 2.4.27-rc4 bridge fix
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Santiago Garcia Mantinan <manty@manty.net>, "David S. Miller" <davem@redhat.com>, "Marcelo W. Tosatti" <marcelo.tosatti@cyclades.com.br>
Cc: netdev@osd.org, bridge@osdl.org

The problem was that the br_add_bridge ended up calling register_netdev
that did a rtnl_lock.  This fixes that, and gets rid of the bridge_list,
there is no need to keep a separate device list of just bridges.  By not
having multiple lists, races are avoided. 

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>


diff -urNp -X dontdiff linux-2.4/net/bridge/br_if.c bridge-2.4/net/bridge/br_if.c
--- linux-2.4/net/bridge/br_if.c	2004-08-02 10:22:45.331010728 -0700
+++ bridge-2.4/net/bridge/br_if.c	2004-08-02 12:57:58.405208248 -0700
@@ -23,8 +23,6 @@
 #include <asm/uaccess.h>
 #include "br_private.h"
 
-static struct net_bridge *bridge_list;
-
 static int br_initial_port_cost(struct net_device *dev)
 {
 	if (!strncmp(dev->name, "lec", 3))
@@ -70,22 +68,6 @@ static int __br_del_if(struct net_bridge
 	return 0;
 }
 
-static struct net_bridge **__find_br(char *name)
-{
-	struct net_bridge **b;
-	struct net_bridge *br;
-
-	b = &bridge_list;
-	while ((br = *b) != NULL) {
-		if (!strncmp(br->dev.name, name, IFNAMSIZ))
-			return b;
-
-		b = &(br->next);
-	}
-
-	return NULL;
-}
-
 static void del_ifs(struct net_bridge *br)
 {
 	br_write_lock_bh(BR_NETPROTO_LOCK);
@@ -178,42 +160,48 @@ static struct net_bridge_port *new_nbp(s
 int br_add_bridge(char *name)
 {
 	struct net_bridge *br;
+	struct net_device *dev;
+	int err;
 
 	if ((br = new_nb(name)) == NULL)
 		return -ENOMEM;
 
-	if (__dev_get_by_name(name) != NULL) {
-		kfree(br);
-		return -EEXIST;
+	dev = &br->dev;
+	if (strchr(dev->name, '%')) {
+		err = dev_alloc_name(dev, dev->name);
+		if (err < 0)
+			goto  out;
 	}
 
-	br->next = bridge_list;
-	bridge_list = br;
+	err = register_netdevice(dev);
+	if (err == 0)
+		br_inc_use_count();
 
-	br_inc_use_count();
-	register_netdev(&br->dev);
-
-	return 0;
+ out:
+	return err;
 }
 
 int br_del_bridge(char *name)
 {
-	struct net_bridge **b;
+	struct net_device *dev;
 	struct net_bridge *br;
 
-	if ((b = __find_br(name)) == NULL)
+	dev = __dev_get_by_name(name);
+	if (!dev)
 		return -ENXIO;
 
-	br = *b;
+	if (dev->hard_start_xmit != br_dev_xmit)
+		return -EPERM;
 
-	if (br->dev.flags & IFF_UP)
+	if (dev->flags & IFF_UP)
 		return -EBUSY;
 
-	del_ifs(br);
+	br = dev->priv;
+	BUG_ON(&br->dev != dev);
 
-	*b = br->next;
+	del_ifs(br);
 
-	unregister_netdev(&br->dev);
+	unregister_netdevice(dev);
 	kfree(br);
 	br_dec_use_count();
 
@@ -271,16 +259,12 @@ int br_del_if(struct net_bridge *br, str
 
 int br_get_bridge_ifindices(int *indices, int num)
 {
-	struct net_bridge *br;
-	int i;
-
-	br = bridge_list;
-	for (i=0;i<num;i++) {
-		if (br == NULL)
-			break;
+	struct net_device *dev;
+	int i = 0;
 
-		indices[i] = br->dev.ifindex;
-		br = br->next;
+	for (dev = dev_base; i < num && dev != NULL; dev = dev->next) {
+		if (dev->hard_start_xmit == br_dev_xmit)
+			indices[i++] = dev->ifindex;
 	}
 
 	return i;
diff -urNp -X dontdiff linux-2.4/net/bridge/br_ioctl.c bridge-2.4/net/bridge/br_ioctl.c
--- linux-2.4/net/bridge/br_ioctl.c	2004-08-02 10:22:45.332010576 -0700
+++ bridge-2.4/net/bridge/br_ioctl.c	2004-08-02 12:57:58.407207944 -0700
@@ -250,14 +250,9 @@ int br_ioctl_deviceless_stub(unsigned lo
 
 int br_ioctl(struct net_bridge *br, unsigned int cmd, unsigned long arg0, unsigned long arg1, unsigned long arg2)
 {
-	int err;
-
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
 
 	ASSERT_RTNL();
-	err = br_ioctl_deviceless(cmd, arg0, arg1);
-	if (err == -EOPNOTSUPP)
-		err = br_ioctl_device(br, cmd, arg0, arg1, arg2);
-	return err;
+	return br_ioctl_device(br, cmd, arg0, arg1, arg2);
 }
diff -urNp -X dontdiff linux-2.4/net/bridge/br_private.h bridge-2.4/net/bridge/br_private.h
--- linux-2.4/net/bridge/br_private.h	2004-08-02 10:22:45.333010424 -0700
+++ bridge-2.4/net/bridge/br_private.h	2004-08-02 10:39:09.582381776 -0700
@@ -79,7 +79,6 @@ struct net_bridge_port
 
 struct net_bridge
 {
-	struct net_bridge		*next;
 	rwlock_t			lock;
 	struct net_bridge_port		*port_list;
 	struct net_device		dev;
