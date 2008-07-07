From: Bill Nottingham <notting@redhat.com>
Date: Mon,  7 Jul 2008 16:05:04 -0400
Message-Id: <4feb53b0a48244b7543c46aed70fb4991218d675.1215460681.git.notting@redhat.com>
In-Reply-To: <eb2e091fa7ea19d7d18183f9cadc2ff69a00668b.1215460681.git.notting@redhat.com>
References: <cover.1215460681.git.notting@redhat.com>
	<eb2e091fa7ea19d7d18183f9cadc2ff69a00668b.1215460681.git.notting@redhat.com>
In-Reply-To: <cover.1215460681.git.notting@redhat.com>
References: <cover.1215460681.git.notting@redhat.com>
Subject: [Bridge] [PATCH 2/2] Add a 'interfaces' file to the bridge device
	configuration in sysfs
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
	echo "+<device name>" > /sys/class/net/<name>/bridge/interfaces
to add a new physical interface to bridge device <name>, and:
	echo "-<device name>" > interfaces
to remove a device. Reading the file lists the current phyiscal interfaces for that bridge.

Signed-off-by: Bill Nottingham <notting@redhat.com>
---
 net/bridge/br_sysfs_br.c |   65 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index a5d5fef..2dae8f3 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -405,6 +405,70 @@ static ssize_t store_flush(struct device *d,
 }
 static DEVICE_ATTR(flush, S_IWUSR, NULL, store_flush);
 
+static ssize_t show_interfaces(struct device *d,
+			       struct device_attribute *attr, char *buf)
+{
+	struct net_bridge *br = to_bridge(d);
+	struct net_bridge_port *p;
+	int res = 0;
+
+	list_for_each_entry(p, &br->port_list, list) {
+		if (res > (PAGE_SIZE - IFNAMSIZ)) {
+			if ((PAGE_SIZE - res) > 10)
+				res = PAGE_SIZE - 10;
+			res += sprintf(buf + res, "++more++ ");
+			break;
+		}
+		res += sprintf(buf + res, "%s ", p->dev->name);
+	}
+	if (res)
+		buf[res-1] = '\n';
+	return res;
+}
+
+static ssize_t store_interfaces(struct device *d,
+				struct device_attribute *attr,
+				const char *buf, size_t len)
+{
+	char command[IFNAMSIZ + 1] = { 0, };
+	char *ifname;
+	struct net_bridge *br = to_bridge(d);
+	struct net_device *dev;
+	int ret = 0;
+
+	sscanf(buf, "%16s", command);	/* IFNAMSIZ */
+	ifname = command + 1;
+	if ((strlen(command) <= 1) || !dev_valid_name(ifname))
+		goto err_no_cmd;
+	if (command[0] == '+') {
+		rtnl_lock();
+		dev = __dev_get_by_name(&init_net, ifname);
+		if (dev == NULL)
+			ret = -ENXIO;
+		else
+			ret = br_add_if(br, dev);
+		rtnl_unlock();
+		goto out;
+	}
+	if (command[0] == '-') {
+		rtnl_lock();
+		dev = __dev_get_by_name(&init_net, ifname);
+		if (dev == NULL)
+			ret = -ENXIO;
+		else
+			ret = br_del_if(br, dev);
+		rtnl_unlock();
+		goto out;
+	}
+err_no_cmd:
+	printk(KERN_ERR "bridge: no command found in interfaces file for bridge %s. Use +ifname or -ifname.\n", br->dev->name);
+	ret = -EPERM;
+out:
+	return ret ? ret: len;
+}
+
+static DEVICE_ATTR(interfaces, S_IRUGO | S_IWUSR, show_interfaces, store_interfaces);
+
 static struct attribute *bridge_attrs[] = {
 	&dev_attr_forward_delay.attr,
 	&dev_attr_hello_time.attr,
@@ -424,6 +488,7 @@ static struct attribute *bridge_attrs[] = {
 	&dev_attr_gc_timer.attr,
 	&dev_attr_group_addr.attr,
 	&dev_attr_flush.attr,
+	&dev_attr_interfaces.attr,
 	NULL
 };
 
-- 
1.5.5.1

