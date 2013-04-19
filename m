Return-Path: <vyasevic@redhat.com>
From: Vlad Yasevich <vyasevic@redhat.com>
Date: Fri, 19 Apr 2013 16:52:46 -0400
Message-Id: <1366404770-28523-3-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1366404770-28523-1-git-send-email-vyasevic@redhat.com>
References: <1366404770-28523-1-git-send-email-vyasevic@redhat.com>
Subject: [Bridge] [PATCH v2 net-next 2/6] bridge: make flags sysfs interface
	a little bit more extensible
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Vlad Yasevich <vyasevic@redhat.com>, bridge@lists.linux-foundation.org, mst@redhat.com

Some changes of the flags may need to trigger additional actions.
Make the flag change function generic and have the per-attribute
function call that.

Signed-off-by: Vlad Yasevich <vyasevic@redhat.com>
---
 net/bridge/br_sysfs_if.c |   39 ++++++++++++++++++++++++++++-----------
 1 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1f28cd4..606362c 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -25,6 +25,10 @@ struct brport_attribute {
 	ssize_t (*show)(struct net_bridge_port *, char *);
 	int (*store)(struct net_bridge_port *, unsigned long);
 };
+static ssize_t show_flag(struct net_bridge_port *p, char *buf,
+			  unsigned long mask);
+static int store_flag(struct net_bridge_port *p, unsigned long v,
+		     unsigned long mask);
 
 #define BRPORT_ATTR(_name,_mode,_show,_store)		        \
 const struct brport_attribute brport_attr_##_name = { 	        \
@@ -37,24 +41,37 @@ const struct brport_attribute brport_attr_##_name = { 	        \
 #define BRPORT_ATTR_FLAG(_name, _mask)				\
 static ssize_t show_##_name(struct net_bridge_port *p, char *buf) \
 {								\
-	return sprintf(buf, "%d\n", !!(p->flags & _mask));	\
+	return show_flag(p, buf, _mask);			\
 }								\
 static int store_##_name(struct net_bridge_port *p, unsigned long v) \
 {								\
-	unsigned long flags = p->flags;				\
-	if (v)							\
-		flags |= _mask;					\
-	else							\
-		flags &= ~_mask;				\
-	if (flags != p->flags) {				\
-		p->flags = flags;				\
-		br_ifinfo_notify(RTM_NEWLINK, p);		\
-	}							\
-	return 0;						\
+	return store_flag(p, v, _mask);				\
 }								\
 static BRPORT_ATTR(_name, S_IRUGO | S_IWUSR,			\
 		   show_##_name, store_##_name)
 
+static ssize_t show_flag(struct net_bridge_port *p, char *buf,
+			  unsigned long mask)
+{
+	return sprintf(buf, "%d\n", !!(p->flags & mask));
+}
+
+static int store_flag(struct net_bridge_port *p, unsigned long v,
+		     unsigned long mask)
+{
+	unsigned long flags = p->flags;
+
+	if (v)
+		flags |= mask;
+	else
+		flags &= ~mask;
+
+	if (flags != p->flags) {
+		p->flags = flags;
+		br_ifinfo_notify(RTM_NEWLINK, p);
+	}
+	return 0;
+}
 
 static ssize_t show_path_cost(struct net_bridge_port *p, char *buf)
 {
-- 
1.7.7.6

