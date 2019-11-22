Return-Path: <vivien.didelot@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ae3uIT0vqnb8YtlHE2QZPNR79CkT2a8BKD5dBlLX6/A=;
 b=NEpldRNm6jCjQ3BxWKsKrhFBugPNw7z3qWl8gqesYCcLwUMnAbUJu/fZAXEsRKYRqA
 DB2495cM2M/u92FQJwRrDwA/dH7GrtmiTOGsR+s10CSlB4KyzxXegepK7nMiCFNpmPTp
 Gh4+i2vol0JCqcG8WlO8IOyxR2sMUoLhyX71gQcOEVGgRhOYKBZ5btSckuoIp5oVmon+
 TuC81rnGpFn6GlAMJ6IjIkNy839nQfDdBkT14bCU/r1F2wSTE0SMllGmhLJN5ApHgYCq
 JgcAQku7UMVRbZ7vTckQQZz2Y5sw2DKrIFAH/8PKhxQGQZ31nmjkVBGFl/qHg+YYpyjF
 mong==
From: Vivien Didelot <vivien.didelot@gmail.com>
Date: Fri, 22 Nov 2019 18:07:42 -0500
Message-Id: <20191122230742.1515752-1-vivien.didelot@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] net: bridge: add STP stat counters
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>
Cc: f.fainelli@gmail.com, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Vivien Didelot <vivien.didelot@gmail.com>

This adds rx_bpdu, tx_bpdu, rx_tcn, tx_tcn, transition_blk,
transition_fwd stat counters to the bridge ports, along with sysfs
statistics nodes under a "statistics" directory of the "brport" entry,
providing useful information for STP, for example:

    # cat /sys/class/net/lan0/brport/statistics/tx_bpdu
    26
    # cat /sys/class/net/lan5/brport/statistics/transition_fwd
    3

At the same time, make BRPORT_ATTR define a non-const attribute as
this is required by the attribute group structure.

Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>
---
 net/bridge/br_private.h  |  8 ++++++++
 net/bridge/br_stp.c      |  8 ++++++++
 net/bridge/br_stp_bpdu.c |  4 ++++
 net/bridge/br_sysfs_if.c | 35 ++++++++++++++++++++++++++++++++++-
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 36b0367ca1e0..360d8030e3b2 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -283,6 +283,14 @@ struct net_bridge_port {
 #endif
 	u16				group_fwd_mask;
 	u16				backup_redirected_cnt;
+
+	/* Statistics */
+	atomic_long_t			rx_bpdu;
+	atomic_long_t			tx_bpdu;
+	atomic_long_t			rx_tcn;
+	atomic_long_t			tx_tcn;
+	atomic_long_t			transition_blk;
+	atomic_long_t			transition_fwd;
 };
 
 #define kobj_to_brport(obj)	container_of(obj, struct net_bridge_port, kobj)
diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index 1f1410f8d312..63568ee2a9cd 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -403,6 +403,8 @@ static void br_make_blocking(struct net_bridge_port *p)
 
 		del_timer(&p->forward_delay_timer);
 	}
+
+	atomic_long_inc(&p->transition_blk);
 }
 
 /* called under bridge lock */
@@ -426,6 +428,8 @@ static void br_make_forwarding(struct net_bridge_port *p)
 
 	if (br->forward_delay != 0)
 		mod_timer(&p->forward_delay_timer, jiffies + br->forward_delay);
+
+	atomic_long_inc(&p->transition_fwd);
 }
 
 /* called under bridge lock */
@@ -512,6 +516,8 @@ void br_received_config_bpdu(struct net_bridge_port *p,
 	} else if (br_is_designated_port(p)) {
 		br_reply(p);
 	}
+
+	atomic_long_inc(&p->rx_bpdu);
 }
 
 /* called under bridge lock */
@@ -524,6 +530,8 @@ void br_received_tcn_bpdu(struct net_bridge_port *p)
 		br_topology_change_detection(p->br);
 		br_topology_change_acknowledge(p);
 	}
+
+	atomic_long_inc(&p->rx_tcn);
 }
 
 /* Change bridge STP parameter */
diff --git a/net/bridge/br_stp_bpdu.c b/net/bridge/br_stp_bpdu.c
index 7796dd9d42d7..e824e040846c 100644
--- a/net/bridge/br_stp_bpdu.c
+++ b/net/bridge/br_stp_bpdu.c
@@ -118,6 +118,8 @@ void br_send_config_bpdu(struct net_bridge_port *p, struct br_config_bpdu *bpdu)
 	br_set_ticks(buf+33, bpdu->forward_delay);
 
 	br_send_bpdu(p, buf, 35);
+
+	atomic_long_inc(&p->tx_bpdu);
 }
 
 /* called under bridge lock */
@@ -133,6 +135,8 @@ void br_send_tcn_bpdu(struct net_bridge_port *p)
 	buf[2] = 0;
 	buf[3] = BPDU_TYPE_TCN;
 	br_send_bpdu(p, buf, 4);
+
+	atomic_long_inc(&p->tx_tcn);
 }
 
 /*
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 7a59cdddd3ce..1fcd42ffa0ff 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -33,7 +33,7 @@ const struct brport_attribute brport_attr_##_name = {			\
 };
 
 #define BRPORT_ATTR(_name, _mode, _show, _store)		\
-const struct brport_attribute brport_attr_##_name = { 	        \
+struct brport_attribute brport_attr_##_name = { 	        \
 	.attr = {.name = __stringify(_name), 			\
 		 .mode = _mode },				\
 	.show	= _show,					\
@@ -52,6 +52,13 @@ static int store_##_name(struct net_bridge_port *p, unsigned long v) \
 static BRPORT_ATTR(_name, 0644,					\
 		   show_##_name, store_##_name)
 
+#define BRPORT_ATTR_STAT(_name)						\
+static ssize_t show_##_name(struct net_bridge_port *p, char *buf) 	\
+{									\
+	return sprintf(buf, "%lu\n", atomic_long_read(&p->_name));	\
+}									\
+static BRPORT_ATTR(_name, 0444, show_##_name, NULL)
+
 static int store_flag(struct net_bridge_port *p, unsigned long v,
 		      unsigned long mask)
 {
@@ -352,6 +359,28 @@ const struct sysfs_ops brport_sysfs_ops = {
 	.store = brport_store,
 };
 
+BRPORT_ATTR_STAT(rx_bpdu);
+BRPORT_ATTR_STAT(tx_bpdu);
+BRPORT_ATTR_STAT(rx_tcn);
+BRPORT_ATTR_STAT(tx_tcn);
+BRPORT_ATTR_STAT(transition_blk);
+BRPORT_ATTR_STAT(transition_fwd);
+
+static struct attribute *br_sysfs_attrs[] __ro_after_init = {
+	&brport_attr_rx_bpdu.attr,
+	&brport_attr_tx_bpdu.attr,
+	&brport_attr_rx_tcn.attr,
+	&brport_attr_tx_tcn.attr,
+	&brport_attr_transition_blk.attr,
+	&brport_attr_transition_fwd.attr,
+	NULL
+};
+
+static const struct attribute_group br_sysfs_group = {
+	.name = "statistics",
+	.attrs = br_sysfs_attrs,
+};
+
 /*
  * Add sysfs entries to ethernet device added to a bridge.
  * Creates a brport subdirectory with bridge attributes.
@@ -374,6 +403,10 @@ int br_sysfs_addif(struct net_bridge_port *p)
 			return err;
 	}
 
+	err = sysfs_create_group(&p->kobj, &br_sysfs_group);
+	if (err)
+		return err;
+
 	strlcpy(p->sysfs_name, p->dev->name, IFNAMSIZ);
 	return sysfs_create_link(br->ifobj, &p->kobj, p->sysfs_name);
 }
-- 
2.24.0

