Return-Path: <vyasevic@redhat.com>
From: Vlad Yasevich <vyasevic@redhat.com>
Date: Tue, 12 Mar 2013 21:45:26 -0400
Message-Id: <1363139126-13396-5-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1363139126-13396-1-git-send-email-vyasevic@redhat.com>
References: <1363139126-13396-1-git-send-email-vyasevic@redhat.com>
Subject: [Bridge] [PATCH net-next 4/4] bridge: sync device list when a new
	uplink is designated
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Vlad Yasevich <vyasevic@redhat.com>, bridge@lists.linux-foundation.org

What a new device is designated as "uplink" sync any device
addresses to it.  This allows for dynamic replacement of
uplinks while maintaining the device list.

Signed-off-by: Vlad Yasevich <vyasevic@redhat.com>
---
 net/bridge/br_netlink.c  |   11 +++++++++++
 net/bridge/br_sysfs_if.c |   27 ++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index e08a50e..02f3425 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -326,6 +326,7 @@ static void br_set_port_flag(struct net_bridge_port *p, struct nlattr *tb[],
 static int br_setport(struct net_bridge_port *p, struct nlattr *tb[])
 {
 	int err;
+	int old_flags = p->flags;
 
 	br_set_port_flag(p, tb, IFLA_BRPORT_MODE, BR_HAIRPIN_MODE);
 	br_set_port_flag(p, tb, IFLA_BRPORT_GUARD, BR_BPDU_GUARD);
@@ -349,6 +350,16 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[])
 		if (err)
 			return err;
 	}
+
+	if ((old_flags ^ p->flags) & BR_UPLINK) {
+		/* UPLINK flag changed on the device.  Take care of device
+		 * addresses.
+		 */
+		if (p->flags & BR_UPLINK)
+			dev_uc_sync(p->dev, p->br->dev);
+		else
+			dev_uc_unsync(p->dev, p->br->dev);
+	}
 	return 0;
 }
 
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1f28cd4..d7a89c9 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -158,7 +158,32 @@ static BRPORT_ATTR(flush, S_IWUSR, NULL, store_flush);
 BRPORT_ATTR_FLAG(hairpin_mode, BR_HAIRPIN_MODE);
 BRPORT_ATTR_FLAG(bpdu_guard, BR_BPDU_GUARD);
 BRPORT_ATTR_FLAG(root_block, BR_ROOT_BLOCK);
-BRPORT_ATTR_FLAG(uplink, BR_UPLINK);
+
+static ssize_t show_uplink(struct net_bridge_port *p, char *buf)
+{
+	return sprintf(buf, "%d\n", !!(p->flags & BR_UPLINK));
+}
+
+static int store_uplink(struct net_bridge_port *p, unsigned long v)
+{
+	unsigned long flags = p->flags;
+
+	if (v)
+		flags |= BR_UPLINK;
+	else
+		flags &= ~BR_UPLINK;
+
+	if (flags != p->flags) {
+		p->flags = flags;
+		if (p->flags & BR_UPLINK)
+			dev_uc_sync(p->dev, p->br->dev);
+		else
+			dev_uc_unsync(p->dev, p->br->dev);
+		br_ifinfo_notify(RTM_NEWLINK, p);
+	}
+	return 0;
+}
+static BRPORT_ATTR(uplink, S_IRUGO | S_IWUSR, show_uplink, store_uplink);
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 static ssize_t show_multicast_router(struct net_bridge_port *p, char *buf)
-- 
1.7.7.6

