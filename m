From: Bill Nottingham <notting@redhat.com>
Date: Mon,  7 Jul 2008 16:05:03 -0400
Message-Id: <eb2e091fa7ea19d7d18183f9cadc2ff69a00668b.1215460681.git.notting@redhat.com>
In-Reply-To: <cover.1215460681.git.notting@redhat.com>
References: <cover.1215460681.git.notting@redhat.com>
In-Reply-To: <cover.1215460681.git.notting@redhat.com>
References: <cover.1215460681.git.notting@redhat.com>
Subject: [Bridge] [PATCH 1/2] Add a 'bridging_masters' file in sysfs under
	class/net
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org

To use this file:
	echo "+<bridge device name>" > bridging_masters
to add a new bridge, and:
	 echo "-<bridge device name>" > bridging masters
to remove a device. Reading the file lists the current bridge devices.

Signed-off-by: Bill Nottingham <notting@redhat.com>
---
 net/bridge/br.c          |    2 +
 net/bridge/br_private.h  |    4 ++
 net/bridge/br_sysfs_br.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index 573acdf..89c6c7c 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -59,6 +59,7 @@ static int __init br_init(void)
 
 	br_fdb_get_hook = br_fdb_get;
 	br_fdb_put_hook = br_fdb_put;
+	br_create_sysfs();
 
 	return 0;
 err_out3:
@@ -83,6 +84,7 @@ static void __exit br_deinit(void)
 	br_cleanup_bridges();
 
 	synchronize_net();
+	br_destroy_sysfs();
 
 	br_netfilter_fini();
 	br_fdb_get_hook = NULL;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 815ed38..d5ff1c6 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -249,6 +249,8 @@ extern void br_ifinfo_notify(int event, struct net_bridge_port *port);
 #ifdef CONFIG_SYSFS
 /* br_sysfs_if.c */
 extern struct sysfs_ops brport_sysfs_ops;
+extern int br_create_sysfs(void);
+extern void br_destroy_sysfs(void);
 extern int br_sysfs_addif(struct net_bridge_port *p);
 
 /* br_sysfs_br.c */
@@ -257,6 +259,8 @@ extern void br_sysfs_delbr(struct net_device *dev);
 
 #else
 
+#define br_create_sysfs()	(0)
+#define br_destroy_sysfs()	(0)
 #define br_sysfs_addif(p)	(0)
 #define br_sysfs_addbr(dev)	(0)
 #define br_sysfs_delbr(dev)	do { } while(0)
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 27d6a51..a5d5fef 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -24,6 +24,77 @@
 #define to_dev(obj)	container_of(obj, struct device, kobj)
 #define to_bridge(cd)	((struct net_bridge *)(to_net_dev(cd)->priv))
 
+static ssize_t show_bridges(struct class *cls, char *buf)
+{
+	int res = 0;
+	struct net_device *dev, *next;
+
+	rtnl_lock();
+	for_each_netdev_safe(&init_net, dev, next) {
+		if (dev->priv_flags & IFF_EBRIDGE) {
+			if (res > (PAGE_SIZE - IFNAMSIZ)) {
+				if ((PAGE_SIZE - res) > 10)
+					res = PAGE_SIZE - 10;
+				res += sprintf(buf + res, "++more++ ");
+				break;
+			}
+			res += sprintf(buf + res, "%s ", dev->name);
+		}
+	}
+	if (res)
+		buf[res-1] = '\n';
+	rtnl_unlock();
+	return res;
+}
+
+static ssize_t store_bridges(struct class *cls, const char *buffer, size_t len)
+{
+	char command[IFNAMSIZ + 1] = {0, };
+	char *ifname;
+	int res = 0;
+
+	sscanf(buffer, "%16s", command); /* IFNAMSIZ */
+	ifname = command + 1;
+	if ((strlen(command) <= 1) || !dev_valid_name(ifname))
+		goto err_no_cmd;
+
+	if (command[0] == '+') {
+		res = br_add_bridge(ifname);
+		goto out;
+	}
+	if (command[0] == '-') {
+		res = br_del_bridge(ifname);
+		goto out;
+	}
+err_no_cmd:
+	printk(KERN_ERR "bridge: no command found in bridging_masters. Use +ifname or -ifname.\n");
+	res = -EPERM;
+out:
+	return res ? res : len;
+}
+
+static CLASS_ATTR(bridging_masters, S_IWUSR | S_IRUGO, show_bridges, store_bridges);
+
+static struct class *netdev_class;
+
+int br_create_sysfs(void)
+{
+	int ret;
+
+	netdev_class = (&init_net)->loopback_dev->dev.class;
+	if (!netdev_class)
+		return -ENODEV;
+
+	ret = class_create_file(netdev_class, &class_attr_bridging_masters);
+	return ret;
+}
+
+void br_destroy_sysfs(void)
+{
+	if (netdev_class)
+		class_remove_file(netdev_class, &class_attr_bridging_masters);
+}
+
 /*
  * Common code for storing bridge parameters.
  */
-- 
1.5.5.1

