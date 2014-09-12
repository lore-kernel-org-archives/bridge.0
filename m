Return-Path: <vyasevich@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=rAvBxLCTznRk8Hxk3ZPX3H+8ot8M59DoyhqhHuWSTvQ=;
	b=IMNtx/GxkH+qUx7+iShhp2asgqqYcintTrtfUgWWlpih1TudfwKL62eiutHqrX0Ead
	5If0gdp4j8w4heH27WidjiyP0mWLa0pGerdwWD6kg6kVVYFlAptuX+Sg5cL/S/t6EM42
	YlBGtIgnXnRW6yUVJNSbPiREg2l9kfhMvNcddlvzb3r7yNnLF2KXj9tYmB+MVdkdmLsa
	ag7Hdy1stsbpXGDKgvc50toNySEOuVxdRqOcSrtSihVRhv0p4Y+H2clUwiGr9xVPcy8Z
	58dKFa/LdVBjqCIMNb+ojmUWaaXVbMQQ04eXG7v5N6ivVkeIPYefgvFVOpkNoAsM+J0V
	llZw==
From: Vladislav Yasevich <vyasevich@gmail.com>
Date: Fri, 12 Sep 2014 16:44:49 -0400
Message-Id: <1410554691-18467-2-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1410554691-18467-1-git-send-email-vyasevic@redhat.com>
References: <1410554691-18467-1-git-send-email-vyasevic@redhat.com>
Subject: [Bridge] [PATCH 1/3] bridge: Add a default_pvid sysfs attribute
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Vladislav Yasevich <vyasevic@redhat.com>, shemminger@vyatta.com, bridge@lists.linux-foundation.org

This patch allows the user to set and retrieve default_pvid
value.  A new value can only be stored when vlan filtering
is disabled.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
---
 net/bridge/br_private.h  |  2 ++
 net/bridge/br_sysfs_br.c | 17 +++++++++++++++++
 net/bridge/br_vlan.c     | 28 ++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 62a7fa2..84c9a5d 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -299,6 +299,7 @@ struct net_bridge
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
 	u8				vlan_enabled;
 	__be16				vlan_proto;
+	u16				default_pvid;
 	struct net_port_vlans __rcu	*vlan_info;
 #endif
 };
@@ -602,6 +603,7 @@ void br_recalculate_fwd_mask(struct net_bridge *br);
 int br_vlan_filter_toggle(struct net_bridge *br, unsigned long val);
 int br_vlan_set_proto(struct net_bridge *br, unsigned long val);
 void br_vlan_init(struct net_bridge *br);
+int br_vlan_set_default_pvid(struct net_bridge *br, unsigned long val);
 int nbp_vlan_add(struct net_bridge_port *port, u16 vid, u16 flags);
 int nbp_vlan_delete(struct net_bridge_port *port, u16 vid);
 void nbp_vlan_flush(struct net_bridge_port *port);
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index c9e2572..b969d9e 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -725,6 +725,22 @@ static ssize_t vlan_protocol_store(struct device *d,
 	return store_bridge_parm(d, buf, len, br_vlan_set_proto);
 }
 static DEVICE_ATTR_RW(vlan_protocol);
+
+static ssize_t default_pvid_show(struct device *d,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct net_bridge *br = to_bridge(d);
+	return sprintf(buf, "%d\n", br->default_pvid);
+}
+
+static ssize_t default_pvid_store(struct device *d,
+				  struct device_attribute *attr,
+				  const char *buf, size_t len)
+{
+	return store_bridge_parm(d, buf, len, br_vlan_set_default_pvid);
+}
+static DEVICE_ATTR_RW(default_pvid);
 #endif
 
 static struct attribute *bridge_attrs[] = {
@@ -771,6 +787,7 @@ static struct attribute *bridge_attrs[] = {
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
 	&dev_attr_vlan_filtering.attr,
 	&dev_attr_vlan_protocol.attr,
+	&dev_attr_default_pvid.attr,
 #endif
 	NULL
 };
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index e1bcd65..43a297b 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -489,9 +489,37 @@ err_filt:
 	goto unlock;
 }
 
+int br_vlan_set_default_pvid(struct net_bridge *br, unsigned long val)
+{
+	u16 pvid = val;
+	int err = 0;
+
+	if (!pvid || pvid >= VLAN_VID_MASK)
+		return -EINVAL;
+
+	if (!rtnl_trylock())
+		return restart_syscall();
+
+	if (pvid == br->default_pvid)
+		goto unlock;
+
+	/* Only allow default pvid change when filtering is disabled */
+	if (br->vlan_enabled) {
+		err = -EPERM;
+		goto unlock;
+	}
+
+	br->default_pvid = vid;
+
+unlock:
+	rtnl_unlock();
+	return err;
+}
+
 void br_vlan_init(struct net_bridge *br)
 {
 	br->vlan_proto = htons(ETH_P_8021Q);
+	br->default_pvid = 1;
 }
 
 /* Must be protected by RTNL.
-- 
1.9.3

