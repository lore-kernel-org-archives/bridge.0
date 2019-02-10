Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=RoEf5Fd90q4JOx/RAzYyPMDHBqBYHJwO/D8F0sElp4M=;
	b=SFF8qviz4fxEwgKMc+kkg6W/Ia+3p6O64ML8ipA1mqvuZzVY1QeSYO1qYySPZluGzz
	cKFVdjChvoM9H+3lvVUbPYj8UDvkllQkzkL/uMG3zhNOiX5wNGKa6jMHFqMbNbPb6WrC
	iR2x2fwRPVf4QjfDlIgb5BY4dHf5W2K2vPFdR4wdqTeMW32mZXfmZUTxT2AgY2Jx3FDS
	OCEi7lc1ci3tovGBKrGaAyZQJZ+NDm9IVGVWHoP71apdXRIfUuIgldIDQ/7C6C/OjW9a
	r6h4+i+KTH6sUJG+OyfQOVCO2fBPqV9qbOPqvDPm4N43yarCJQoltXhp1zagIuEuc4AF
	CW+w==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 10 Feb 2019 09:50:53 -0800
Message-Id: <20190210175105.31629-5-f.fainelli@gmail.com>
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 04/16] net: dsa: Add setter for
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
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@gmail.com

In preparation for removing SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
add support for a function that processes the
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS attribute and returns not supported
for any flag set, since DSA does not currently support toggling those
bridge port attributes (yet).

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/dsa_priv.h |  3 +++
 net/dsa/port.c     | 10 ++++++++++
 net/dsa/slave.c    |  4 ++++
 3 files changed, 17 insertions(+)

diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 1f4972dab9f2..97594f0b6efb 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -150,6 +150,9 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 			    struct switchdev_trans *trans);
 int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock,
 			 struct switchdev_trans *trans);
+int dsa_port_bridge_port_flags_set(struct dsa_port *dp,
+				   unsigned long brport_flags,
+				   struct switchdev_trans *trans);
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 		     u16 vid);
 int dsa_port_fdb_del(struct dsa_port *dp, const unsigned char *addr,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 2d7e01b23572..2ce3752203cf 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -177,6 +177,16 @@ int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock,
 	return dsa_port_notify(dp, DSA_NOTIFIER_AGEING_TIME, &info);
 }
 
+int dsa_port_bridge_port_flags_set(struct dsa_port *dp,
+				   unsigned long brport_flags,
+				   struct switchdev_trans *trans)
+{
+	if (brport_flags)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 		     u16 vid)
 {
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 2e5e7c04821b..9b499ba88aa7 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -295,6 +295,10 @@ static int dsa_slave_port_attr_set(struct net_device *dev,
 	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
 		ret = dsa_port_ageing_time(dp, attr->u.ageing_time, trans);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
+		ret = dsa_port_bridge_port_flags_set(dp, attr->u.brport_flags,
+						     trans);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
-- 
2.19.1

