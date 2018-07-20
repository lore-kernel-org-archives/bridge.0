Return-Path: <tyhicks@canonical.com>
From: Tyler Hicks <tyhicks@canonical.com>
Date: Fri, 20 Jul 2018 21:56:53 +0000
Message-Id: <1532123814-1109-8-git-send-email-tyhicks@canonical.com>
In-Reply-To: <1532123814-1109-1-git-send-email-tyhicks@canonical.com>
References: <1532123814-1109-1-git-send-email-tyhicks@canonical.com>
Subject: [Bridge] [PATCH net-next v3 7/8] net: create reusable function for
	getting ownership info of sysfs inodes
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

Make net_ns_get_ownership() reusable by networking code outside of core.
This is useful, for example, to allow bridge related sysfs files to be
owned by container root.

Add a function comment since this is a potentially dangerous function to
use given the way that kobject_get_ownership() works by initializing uid
and gid before calling .get_ownership().

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 include/net/net_namespace.h | 10 ++++++++++
 net/core/net-sysfs.c        | 18 ------------------
 net/core/net_namespace.c    | 28 ++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index a71264d75d7f..9b5fdc50519a 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -10,6 +10,7 @@
 #include <linux/workqueue.h>
 #include <linux/list.h>
 #include <linux/sysctl.h>
+#include <linux/uidgid.h>
 
 #include <net/flow.h>
 #include <net/netns/core.h>
@@ -170,6 +171,8 @@ extern struct net init_net;
 struct net *copy_net_ns(unsigned long flags, struct user_namespace *user_ns,
 			struct net *old_net);
 
+void net_ns_get_ownership(const struct net *net, kuid_t *uid, kgid_t *gid);
+
 void net_ns_barrier(void);
 #else /* CONFIG_NET_NS */
 #include <linux/sched.h>
@@ -182,6 +185,13 @@ static inline struct net *copy_net_ns(unsigned long flags,
 	return old_net;
 }
 
+static inline void net_ns_get_ownership(const struct net *net,
+					kuid_t *uid, kgid_t *gid)
+{
+	*uid = GLOBAL_ROOT_UID;
+	*gid = GLOBAL_ROOT_GID;
+}
+
 static inline void net_ns_barrier(void) {}
 #endif /* CONFIG_NET_NS */
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index ada065fc685e..0a95bcf64cdc 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -656,24 +656,6 @@ static const struct attribute_group wireless_group = {
 #define net_class_groups	NULL
 #endif /* CONFIG_SYSFS */
 
-static void net_ns_get_ownership(const struct net *net,
-				 kuid_t *uid, kgid_t *gid)
-{
-	if (net) {
-		kuid_t ns_root_uid = make_kuid(net->user_ns, 0);
-		kgid_t ns_root_gid = make_kgid(net->user_ns, 0);
-
-		if (uid_valid(ns_root_uid))
-			*uid = ns_root_uid;
-
-		if (gid_valid(ns_root_gid))
-			*gid = ns_root_gid;
-	} else {
-		*uid = GLOBAL_ROOT_UID;
-		*gid = GLOBAL_ROOT_GID;
-	}
-}
-
 #ifdef CONFIG_SYSFS
 #define to_rx_queue_attr(_attr) \
 	container_of(_attr, struct rx_queue_attribute, attr)
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index a11e03f920d3..738871af5efa 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -17,6 +17,7 @@
 #include <linux/user_namespace.h>
 #include <linux/net_namespace.h>
 #include <linux/sched/task.h>
+#include <linux/uidgid.h>
 
 #include <net/sock.h>
 #include <net/netlink.h>
@@ -448,6 +449,33 @@ struct net *copy_net_ns(unsigned long flags,
 	return net;
 }
 
+/**
+ * net_ns_get_ownership - get sysfs ownership data for @net
+ * @net: network namespace in question (can be NULL)
+ * @uid: kernel user ID for sysfs objects
+ * @gid: kernel group ID for sysfs objects
+ *
+ * Returns the uid/gid pair of root in the user namespace associated with the
+ * given network namespace.
+ */
+void net_ns_get_ownership(const struct net *net, kuid_t *uid, kgid_t *gid)
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
+EXPORT_SYMBOL_GPL(net_ns_get_ownership);
+
 static void unhash_nsid(struct net *net, struct net *last)
 {
 	struct net *tmp;
-- 
2.7.4

