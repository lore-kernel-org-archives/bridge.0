Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=SrfBV6sMfKn5kftN7j9UYGK0gm1FsB0zr8/yiSFRNK8=;
	b=rGHRTrlUuKJbkPSNg+GmzA527l10JLzlMKa7WYVso+1dpglnGx3fCMH4Nxlr1q8q25
	byp/loWueYScC7XukBSJ+wlvh63tLUo+GLHN7dAEaP9tFDejX12zOPBqk0Xge6p7UUXb
	tuHK2Q380fFi4xHkJpRqNlIPCr4CszWQgr3QHUL9YnBa4sj8SZj4qy8ovJj0j5+XSgDa
	Z4JbbVeW0P5UWDkN+y9MbsVJsZZAiSqnd5+BpzNPJATeUMVOeARauAYM+hdp24moILNb
	opHFqcW6t5GDZ4NbbPGfOT5ZH1HnsHD9SYzIgN3yBkT0pAkBfGW8w7RSg/oM5AfN+kSH
	UQKA==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri,  8 Feb 2019 16:32:36 -0800
Message-Id: <20190209003248.31088-5-f.fainelli@gmail.com>
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 04/16] net: dsa: Add setter for
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
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS attribute and returns not supported
for any flag set, since DSA does not currently support toggling those
bridge port attributes (yet).

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
index 70395a0ae52e..212fc1cc27fc 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -292,6 +292,10 @@ static int dsa_slave_port_attr_set(struct net_device *dev,
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
2.17.1

