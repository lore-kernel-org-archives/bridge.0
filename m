Return-Path: <tyhicks@canonical.com>
From: Tyler Hicks <tyhicks@canonical.com>
Date: Fri, 20 Jul 2018 21:56:54 +0000
Message-Id: <1532123814-1109-9-git-send-email-tyhicks@canonical.com>
In-Reply-To: <1532123814-1109-1-git-send-email-tyhicks@canonical.com>
References: <1532123814-1109-1-git-send-email-tyhicks@canonical.com>
Subject: [Bridge] [PATCH net-next v3 8/8] bridge: make sure objects belong
	to container's owner
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

When creating various bridge objects in /sys/class/net/... make sure
that they belong to the container's owner instead of global root (if
they belong to a container/namespace).

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 net/bridge/br_if.c       | 9 +++++++++
 net/bridge/br_private.h  | 2 ++
 net/bridge/br_sysfs_if.c | 5 ++---
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 05e42d86882d..e7c8d55212aa 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -26,6 +26,7 @@
 #include <net/sock.h>
 #include <linux/if_vlan.h>
 #include <net/switchdev.h>
+#include <net/net_namespace.h>
 
 #include "br_private.h"
 
@@ -204,11 +205,19 @@ static void release_nbp(struct kobject *kobj)
 	kfree(p);
 }
 
+static void brport_get_ownership(struct kobject *kobj, kuid_t *uid, kgid_t *gid)
+{
+	struct net_bridge_port *p = kobj_to_brport(kobj);
+
+	net_ns_get_ownership(dev_net(p->dev), uid, gid);
+}
+
 static struct kobj_type brport_ktype = {
 #ifdef CONFIG_SYSFS
 	.sysfs_ops = &brport_sysfs_ops,
 #endif
 	.release = release_nbp,
+	.get_ownership = brport_get_ownership,
 };
 
 static void destroy_nbp(struct net_bridge_port *p)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 5216a524b537..cf0005d2a4d0 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -283,6 +283,8 @@ struct net_bridge_port {
 	u16				group_fwd_mask;
 };
 
+#define kobj_to_brport(obj)	container_of(obj, struct net_bridge_port, kobj)
+
 #define br_auto_port(p) ((p)->flags & BR_AUTO_MASK)
 #define br_promisc_port(p) ((p)->flags & BR_PROMISC)
 
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index f99c5bf5c906..ab4c7f8adf68 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -249,13 +249,12 @@ static const struct brport_attribute *brport_attrs[] = {
 };
 
 #define to_brport_attr(_at) container_of(_at, struct brport_attribute, attr)
-#define to_brport(obj)	container_of(obj, struct net_bridge_port, kobj)
 
 static ssize_t brport_show(struct kobject *kobj,
 			   struct attribute *attr, char *buf)
 {
 	struct brport_attribute *brport_attr = to_brport_attr(attr);
-	struct net_bridge_port *p = to_brport(kobj);
+	struct net_bridge_port *p = kobj_to_brport(kobj);
 
 	if (!brport_attr->show)
 		return -EINVAL;
@@ -268,7 +267,7 @@ static ssize_t brport_store(struct kobject *kobj,
 			    const char *buf, size_t count)
 {
 	struct brport_attribute *brport_attr = to_brport_attr(attr);
-	struct net_bridge_port *p = to_brport(kobj);
+	struct net_bridge_port *p = kobj_to_brport(kobj);
 	ssize_t ret = -EINVAL;
 	char *endp;
 	unsigned long val;
-- 
2.7.4

