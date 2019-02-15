Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=VDGmRMfeqZv9NxuAeBQdbUzJUsHV0xq2Pnb3Ma6yPoU=;
	b=fHJi0B45dpX2nXBWIkj7n3csq8XA3GJLOSf315HQEMWlPPy4SQujmTv8qbRGV3YBVu
	AJZTtb5w3vxVwBoRm+nCexc7xqBPHXXkddRtnOr4cNqB7m7RfdPytw6NMrRQUHyHkm0h
	VXeVDzisTdNpAfag4yEVSjzq/BgPqnMZDGGZYL/Kl/2dUDO/Gt1pO/ROoGkQp7+6ef9u
	JCm1npFS938zhKmgaLEPIumpPH6hWU8uzL+jImgNY4kihFf0twkjlIV20J9yv83Gkmsp
	Z8DlSz2KfTtAlbtm/C+uDBKtU2QgQ1FYNLzAK76IxmELr+Eyb/msyOujzxA6F5J6x0XY
	Jh/Q==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 15 Feb 2019 14:53:09 -0800
Message-Id: <20190215225313.32303-6-f.fainelli@gmail.com>
In-Reply-To: <20190215225313.32303-1-f.fainelli@gmail.com>
References: <20190215225313.32303-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v2 5/9] net: dsa: Add setter for
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
 net/dsa/dsa_priv.h |  6 ++++++
 net/dsa/port.c     | 17 +++++++++++++++++
 net/dsa/slave.c    |  9 +++++++++
 3 files changed, 32 insertions(+)

diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 1f4972dab9f2..3d58dc4f4d46 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -150,6 +150,12 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 			    struct switchdev_trans *trans);
 int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock,
 			 struct switchdev_trans *trans);
+int dsa_port_bridge_port_pre_flags_set(struct dsa_port *dp,
+				       unsigned long brport_flags,
+				       struct switchdev_trans *trans);
+int dsa_port_bridge_port_flags_set(struct dsa_port *dp,
+				   unsigned long brport_flags,
+				   struct switchdev_trans *trans);
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 		     u16 vid);
 int dsa_port_fdb_del(struct dsa_port *dp, const unsigned char *addr,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 2d7e01b23572..c67a329d4414 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -177,6 +177,23 @@ int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock,
 	return dsa_port_notify(dp, DSA_NOTIFIER_AGEING_TIME, &info);
 }
 
+int dsa_port_bridge_port_pre_flags_set(struct dsa_port *dp,
+				       unsigned long brport_flags,
+				       struct switchdev_trans *trans)
+{
+	if (switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	return -EINVAL;
+}
+
+int dsa_port_bridge_port_flags_set(struct dsa_port *dp,
+				   unsigned long brport_flags,
+				   struct switchdev_trans *trans)
+{
+	return -EOPNOTSUPP;
+}
+
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 		     u16 vid)
 {
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 2e5e7c04821b..d3370e840956 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -295,6 +295,15 @@ static int dsa_slave_port_attr_set(struct net_device *dev,
 	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
 		ret = dsa_port_ageing_time(dp, attr->u.ageing_time, trans);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		ret = dsa_port_bridge_port_pre_flags_set(dp,
+							 attr->u.brport_flags,
+							 trans);
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
+		ret = dsa_port_bridge_port_flags_set(dp, attr->u.brport_flags,
+						     trans);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
-- 
2.17.1

