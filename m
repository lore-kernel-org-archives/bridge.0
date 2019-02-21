Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=9UDI7X41YNHKHghB/bq/RanLp9N2yQLoh7jMnll+lSo=;
	b=MHjpDU8vnx8rt7P5+weZq3EGNcz1vZRbdJIk4Wa1yVGy9RR7GxN+6bHHBsWx2j74ix
	jDHM+4RAghP2+XJ0tNsOTWTqaxm3EvbvSiPOzbcw+G8pbEEVwaYzHB6mGxIc5YRiHaZA
	3F1nYnaRM2f8ZEYUd0O8yonZbv9s05Vh4/x8PAfCacgpL3iVPl335peoSUHbS3Oe13WT
	f6vpsnBlz7YX+h+k5TiQH08SfQClFxYLYBsCzFHDwJvQIN/nsOE4r+ELLgeAUKsHlBaK
	NxSUmQzVir1DGOxCf6Wc6nuQ00EoldQmF8e9QNWXwO9DtmVIMmRw4JACA+2NwyjOCeRP
	IanA==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 20 Feb 2019 16:58:22 -0800
Message-Id: <20190221005826.26317-5-f.fainelli@gmail.com>
In-Reply-To: <20190221005826.26317-1-f.fainelli@gmail.com>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v3 4/8] net: dsa: Add setter for
	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, vivien.didelot@gmail.com, Ido Schimmel <idosch@mellanox.com>, jiri@mellanox.com, "David S. Miller" <davem@davemloft.net>

In preparation for removing SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
add support for a function that processes the
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS and
SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attributes and returns not
supported for any flag set, since DSA does not currently support
toggling those bridge port attributes (yet).

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/dsa_priv.h |  2 ++
 net/dsa/port.c     | 12 ++++++++++++
 net/dsa/slave.c    |  4 ++++
 3 files changed, 18 insertions(+)

diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index f4f99ec29f5d..47a1d1379d15 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -160,6 +160,8 @@ int dsa_port_mdb_add(const struct dsa_port *dp,
 		     struct switchdev_trans *trans);
 int dsa_port_mdb_del(const struct dsa_port *dp,
 		     const struct switchdev_obj_port_mdb *mdb);
+int dsa_port_pre_bridge_flags(const struct dsa_port *dp, unsigned long flags,
+			      struct switchdev_trans *trans);
 int dsa_port_bridge_flags(const struct dsa_port *dp, unsigned long flags,
 			  struct switchdev_trans *trans);
 int dsa_port_vlan_add(struct dsa_port *dp,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 7bc2a5ad95c6..e9b5b50f8cf1 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -187,6 +187,18 @@ int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock,
 	return dsa_port_notify(dp, DSA_NOTIFIER_AGEING_TIME, &info);
 }
 
+int dsa_port_pre_bridge_flags(const struct dsa_port *dp, unsigned long flags,
+			      struct switchdev_trans *trans)
+{
+	struct dsa_switch *ds = dp->ds;
+
+	if (!ds->ops->port_egress_floods ||
+	    (flags & ~(BR_FLOOD | BR_MCAST_FLOOD)))
+		return -EINVAL;
+
+	return 0;
+}
+
 int dsa_port_bridge_flags(const struct dsa_port *dp, unsigned long flags,
 			  struct switchdev_trans *trans)
 {
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 85dc68611002..44cc4e50dd5a 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -295,6 +295,10 @@ static int dsa_slave_port_attr_set(struct net_device *dev,
 	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
 		ret = dsa_port_ageing_time(dp, attr->u.ageing_time, trans);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		ret = dsa_port_pre_bridge_flags(dp, attr->u.brport_flags,
+						trans);
+		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		ret = dsa_port_bridge_flags(dp, attr->u.brport_flags, trans);
 		break;
-- 
2.17.1

