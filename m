Return-Path: <tyhicks@canonical.com>
From: Tyler Hicks <tyhicks@canonical.com>
Date: Fri, 20 Jul 2018 21:56:52 +0000
Message-Id: <1532123814-1109-7-git-send-email-tyhicks@canonical.com>
In-Reply-To: <1532123814-1109-1-git-send-email-tyhicks@canonical.com>
References: <1532123814-1109-1-git-send-email-tyhicks@canonical.com>
Subject: [Bridge] [PATCH net-next v3 6/8] net-sysfs: make sure objects
	belong to container's owner
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, "David S. Miller" <davem@davemloft.net>, Stephen Hemminger <stephen@networkplumber.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, netdev@vger.kernel.org, Linux Containers <containers@lists.linux-foundation.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

When creating various objects in /sys/class/net/... make sure that they
belong to container's owner instead of global root (if they belong to a
container/namespace).

Co-Developed-by: Tyler Hicks <tyhicks@canonical.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 net/core/net-sysfs.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 405c41ecb20b..ada065fc685e 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -656,6 +656,24 @@ static const struct attribute_group wireless_group = {
 #define net_class_groups	NULL
 #endif /* CONFIG_SYSFS */
 
+static void net_ns_get_ownership(const struct net *net,
+				 kuid_t *uid, kgid_t *gid)
+{
+	if (net) {
+		kuid_t ns_root_uid = make_kuid(net->user_ns, 0);
+		kgid_t ns_root_gid = make_kgid(net->user_ns, 0);
+
+		if (uid_valid(ns_root_uid))
+			*uid = ns_root_uid;
+
+		if (gid_valid(ns_root_gid))
+			*gid = ns_root_gid;
+	} else {
+		*uid = GLOBAL_ROOT_UID;
+		*gid = GLOBAL_ROOT_GID;
+	}
+}
+
 #ifdef CONFIG_SYSFS
 #define to_rx_queue_attr(_attr) \
 	container_of(_attr, struct rx_queue_attribute, attr)
@@ -905,11 +923,20 @@ static const void *rx_queue_namespace(struct kobject *kobj)
 	return ns;
 }
 
+static void rx_queue_get_ownership(struct kobject *kobj,
+				   kuid_t *uid, kgid_t *gid)
+{
+	const struct net *net = rx_queue_namespace(kobj);
+
+	net_ns_get_ownership(net, uid, gid);
+}
+
 static struct kobj_type rx_queue_ktype __ro_after_init = {
 	.sysfs_ops = &rx_queue_sysfs_ops,
 	.release = rx_queue_release,
 	.default_attrs = rx_queue_default_attrs,
-	.namespace = rx_queue_namespace
+	.namespace = rx_queue_namespace,
+	.get_ownership = rx_queue_get_ownership,
 };
 
 static int rx_queue_add_kobject(struct net_device *dev, int index)
@@ -1431,11 +1458,20 @@ static const void *netdev_queue_namespace(struct kobject *kobj)
 	return ns;
 }
 
+static void netdev_queue_get_ownership(struct kobject *kobj,
+				       kuid_t *uid, kgid_t *gid)
+{
+	const struct net *net = netdev_queue_namespace(kobj);
+
+	net_ns_get_ownership(net, uid, gid);
+}
+
 static struct kobj_type netdev_queue_ktype __ro_after_init = {
 	.sysfs_ops = &netdev_queue_sysfs_ops,
 	.release = netdev_queue_release,
 	.default_attrs = netdev_queue_default_attrs,
 	.namespace = netdev_queue_namespace,
+	.get_ownership = netdev_queue_get_ownership,
 };
 
 static int netdev_queue_add_kobject(struct net_device *dev, int index)
@@ -1625,6 +1661,14 @@ static const void *net_namespace(struct device *d)
 	return dev_net(dev);
 }
 
+static void net_get_ownership(struct device *d, kuid_t *uid, kgid_t *gid)
+{
+	struct net_device *dev = to_net_dev(d);
+	const struct net *net = dev_net(dev);
+
+	net_ns_get_ownership(net, uid, gid);
+}
+
 static struct class net_class __ro_after_init = {
 	.name = "net",
 	.dev_release = netdev_release,
@@ -1632,6 +1676,7 @@ static struct class net_class __ro_after_init = {
 	.dev_uevent = netdev_uevent,
 	.ns_type = &net_ns_type_operations,
 	.namespace = net_namespace,
+	.get_ownership = net_get_ownership,
 };
 
 #ifdef CONFIG_OF_NET
-- 
2.7.4

