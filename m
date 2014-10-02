Return-Path: <vyasevich@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=4HcwG46YrT+jngX+0RGa6DfJaGVxe+yzBEIc9a3oj74=;
	b=MwnJPWbMTZ7yHzpTONLht2Q7jx4pA+FhbzWm/CRWlCmAFPEALr6AzMVLsg3Sh1i6z5
	hAKR1747LMFHJ10wzOm2aSLbjTCd3bqfjNJ4TtIlCfsCtPoEMeVa/rRbvrnjS8IqtJXy
	uSMOeytk1mzIQSpH1W4IDjAQN3aF0rG1MerK7pDuK3qNEEaMs6meqtHQl/yq3tf1FbEv
	zwLsOwWZ0etE1BkorqnGr6REQ+V9MoFIopuKOJrs92m2HOuSMu8z/SkmPEbI8IMU3kXg
	PLezfYu9LMU2MQVAzJxhwSkp0K0d61wAhwzTprY2qhOIcD/PkucsapS4oBaAcOgXg1GW
	kF7w==
From: Vladislav Yasevich <vyasevich@gmail.com>
Date: Thu,  2 Oct 2014 19:54:30 -0400
Message-Id: <1412294070-11930-4-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1412294070-11930-1-git-send-email-vyasevic@redhat.com>
References: <1412294070-11930-1-git-send-email-vyasevic@redhat.com>
Subject: [Bridge] [PATCH v3 net-next 3/3] bridge: Add filtering support for
	default_pvid
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org, bridge@lists.linux-foundation.org, Vladislav Yasevich <vyasevic@redhat.com>

Currently when vlan filtering is turned on on the bridge, the bridge
will drop all traffic untill the user configures the filter.  This
isn't very nice for ports that don't care about vlans and just
want untagged traffic.

A concept of a default_pvid was recently introduced.  This patch
adds filtering support for default_pvid.   Now, ports that don't
care about vlans and don't define there own filter will belong
to the VLAN of the default_pvid and continue to receive untagged
traffic.

This filtering can be disabled by setting default_pvid to 0.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
---
 net/bridge/br_device.c  |   8 +++-
 net/bridge/br_if.c      |   3 ++
 net/bridge/br_private.h |  14 +++++-
 net/bridge/br_vlan.c    | 124 ++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 142 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 659cac1..ffd379d 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -88,12 +88,17 @@ out:
 static int br_dev_init(struct net_device *dev)
 {
 	struct net_bridge *br = netdev_priv(dev);
+	int err;
 
 	br->stats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
 	if (!br->stats)
 		return -ENOMEM;
 
-	return 0;
+	err = br_vlan_init(br);
+	if (err)
+		free_percpu(br->stats);
+
+	return err;
 }
 
 static int br_dev_open(struct net_device *dev)
@@ -389,5 +394,4 @@ void br_dev_setup(struct net_device *dev)
 	br_netfilter_rtable_init(br);
 	br_stp_timer_init(br);
 	br_multicast_init(br);
-	br_vlan_init(br);
 }
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 7b7289c..ed307db 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -500,6 +500,9 @@ int br_add_if(struct net_bridge *br, struct net_device *dev)
 	if (br_fdb_insert(br, p, dev->dev_addr, 0))
 		netdev_err(dev, "failed insert local address bridge forwarding table\n");
 
+	if (nbp_vlan_init(p))
+		netdev_err(dev, "failed to initialize vlan filtering on this port\n");
+
 	spin_lock_bh(&br->lock);
 	changed_addr = br_stp_recalculate_bridge_id(br);
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index f671561..d8cbaa6 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -605,12 +605,13 @@ bool br_vlan_find(struct net_bridge *br, u16 vid);
 void br_recalculate_fwd_mask(struct net_bridge *br);
 int br_vlan_filter_toggle(struct net_bridge *br, unsigned long val);
 int br_vlan_set_proto(struct net_bridge *br, unsigned long val);
-void br_vlan_init(struct net_bridge *br);
+int br_vlan_init(struct net_bridge *br);
 int br_vlan_set_default_pvid(struct net_bridge *br, unsigned long val);
 int nbp_vlan_add(struct net_bridge_port *port, u16 vid, u16 flags);
 int nbp_vlan_delete(struct net_bridge_port *port, u16 vid);
 void nbp_vlan_flush(struct net_bridge_port *port);
 bool nbp_vlan_find(struct net_bridge_port *port, u16 vid);
+int nbp_vlan_init(struct net_bridge_port *port);
 
 static inline struct net_port_vlans *br_get_vlan_info(
 						const struct net_bridge *br)
@@ -643,6 +644,9 @@ static inline int br_vlan_get_tag(const struct sk_buff *skb, u16 *vid)
 
 static inline u16 br_get_pvid(const struct net_port_vlans *v)
 {
+	if (!v)
+		return 0;
+
 	smp_rmb();
 	return v->pvid;
 }
@@ -703,8 +707,9 @@ static inline void br_recalculate_fwd_mask(struct net_bridge *br)
 {
 }
 
-static inline void br_vlan_init(struct net_bridge *br)
+static inline int br_vlan_init(struct net_bridge *br)
 {
+	return 0;
 }
 
 static inline int nbp_vlan_add(struct net_bridge_port *port, u16 vid, u16 flags)
@@ -737,6 +742,11 @@ static inline bool nbp_vlan_find(struct net_bridge_port *port, u16 vid)
 	return false;
 }
 
+static inline int nbp_vlan_init(struct net_bridge_port *port)
+{
+	return 0;
+}
+
 static inline u16 br_vlan_get_tag(const struct sk_buff *skb, u16 *tag)
 {
 	return 0;
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 12feb8f..182c3ed 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -499,12 +499,112 @@ err_filt:
 	goto unlock;
 }
 
+static bool vlan_default_pvid(struct net_port_vlans *pv, u16 vid)
+{
+	return pv && vid == pv->pvid && test_bit(vid, pv->untagged_bitmap);
+}
+
+static void br_vlan_disable_default_pvid(struct net_bridge *br)
+{
+	struct net_bridge_port *p;
+	u16 pvid = br->default_pvid;
+
+	/* Disable default_pvid on all ports where it is still
+	 * configured.
+	 */
+
+	if (vlan_default_pvid(br_get_vlan_info(br), pvid))
+		br_vlan_delete(br, pvid);
+
+	list_for_each_entry(p, &br->port_list, list) {
+		if (vlan_default_pvid(nbp_get_vlan_info(p), pvid))
+			nbp_vlan_delete(p, pvid);
+	}
+
+	br->default_pvid = 0;
+}
+
+static int __br_vlan_set_default_pvid(struct net_bridge *br, u16 pvid)
+{
+	struct net_bridge_port *p;
+	u16 old_pvid;
+	int err;
+	DECLARE_BITMAP(changed, BR_MAX_PORTS);
+
+	bitmap_zero(changed, BR_MAX_PORTS);
+
+	/* This function runs with filtering turned off so we can
+	 * remove the old pvid configuration and add the new one after
+	 * without impacting traffic.
+	 */
+
+	old_pvid = br->default_pvid;
+
+	/* If the user has set a different PVID or if the new default pvid
+	 * conflicts with user configuration, do not modify the configuration.
+	 */
+	if ((old_pvid && !vlan_default_pvid(br_get_vlan_info(br), old_pvid)) ||
+	    br_vlan_find(br, pvid))
+		goto do_ports;
+
+	err = br_vlan_add(br, pvid,
+			  BRIDGE_VLAN_INFO_PVID | BRIDGE_VLAN_INFO_UNTAGGED);
+	if (err)
+		goto err;
+	br_vlan_delete(br, old_pvid);
+	set_bit(0, changed);
+
+do_ports:
+	list_for_each_entry(p, &br->port_list, list) {
+		/* If the user has set a different PVID or if the new default
+		 * pvid conflicts with user configuration, do not modify the
+		 * configuration.
+		 */
+		if ((old_pvid &&
+		     !vlan_default_pvid(nbp_get_vlan_info(p), old_pvid)) ||
+		    nbp_vlan_find(p, pvid))
+			continue;
+
+		err = nbp_vlan_add(p, pvid,
+				   BRIDGE_VLAN_INFO_PVID |
+				   BRIDGE_VLAN_INFO_UNTAGGED);
+		if (err)
+			goto err_port;
+		nbp_vlan_delete(p, old_pvid);
+		set_bit(p->port_no, changed);
+	}
+
+	br->default_pvid = pvid;
+
+	return 0;
+
+err_port:
+	list_for_each_entry_continue_reverse(p, &br->port_list, list) {
+		if (!test_bit(p->port_no, changed))
+			continue;
+
+		nbp_vlan_add(p, old_pvid,
+			     BRIDGE_VLAN_INFO_PVID |
+			     BRIDGE_VLAN_INFO_UNTAGGED);
+		nbp_vlan_delete(p, pvid);
+	}
+
+	if (test_bit(0, changed)) {
+		br_vlan_add(br, old_pvid,
+			    BRIDGE_VLAN_INFO_PVID |
+			    BRIDGE_VLAN_INFO_UNTAGGED);
+		br_vlan_delete(br, pvid);
+	}
+err:
+	return err;
+}
+
 int br_vlan_set_default_pvid(struct net_bridge *br, unsigned long val)
 {
 	u16 pvid = val;
 	int err = 0;
 
-	if (!val || val >= VLAN_VID_MASK)
+	if (val >= VLAN_VID_MASK)
 		return -EINVAL;
 
 	if (!rtnl_trylock())
@@ -520,17 +620,22 @@ int br_vlan_set_default_pvid(struct net_bridge *br, unsigned long val)
 		goto unlock;
 	}
 
-	br->default_pvid = vid;
+	if (!pvid)
+		br_vlan_disable_default_pvid(br);
+	else
+		err = __br_vlan_set_default_pvid(br, pvid);
 
 unlock:
 	rtnl_unlock();
 	return err;
 }
 
-void br_vlan_init(struct net_bridge *br)
+int br_vlan_init(struct net_bridge *br)
 {
 	br->vlan_proto = htons(ETH_P_8021Q);
 	br->default_pvid = 1;
+	return br_vlan_add(br, 1,
+			   BRIDGE_VLAN_INFO_PVID | BRIDGE_VLAN_INFO_UNTAGGED);
 }
 
 /* Must be protected by RTNL.
@@ -622,3 +727,16 @@ out:
 	rcu_read_unlock();
 	return found;
 }
+
+int nbp_vlan_init(struct net_bridge_port *p)
+{
+	int rc = 0;
+
+	if (p->br->default_pvid) {
+		rc = nbp_vlan_add(p, p->br->default_pvid,
+				  BRIDGE_VLAN_INFO_PVID |
+				  BRIDGE_VLAN_INFO_UNTAGGED);
+	}
+
+	return rc;
+}
-- 
1.9.3

