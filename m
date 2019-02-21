Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=eZxdWd5BQlnzdNHuRiN/vDhYfkVgZqkkTonly3+6XNg=;
	b=bXcOXwYtbhyqPtx2gy03bNk8/8R7tM/L1iu2dyH+wXVFAhsCx6o0VQ1qc/dSnhZ+38
	LQEUYG6vjjvIqpgCAYzdT3oLXkWrPf06Sr6v5NqzygTmK3yZKXPeXcxlA0PcLsLmn3x4
	iF9LuC9X1R95bA5ONPpwcqwQy/R8pHoRkVCynAqs7IxhYNy1jDZdEnwXU8D7P/7IGFdO
	RYqv5J+4irDAO3u4mPb2YGAKDOKHpBKMw8fbn99v5eQ5kY7tDwq9Ro6sVwKX4T8ya9l6
	OFZvDWpclJ3ByYNXXTeSSFPmiXmF6hzDUeuYT9gFMlmdg19h17zvgxAqsnYhgChJB99P
	R2Fw==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 20 Feb 2019 16:58:21 -0800
Message-Id: <20190221005826.26317-4-f.fainelli@gmail.com>
In-Reply-To: <20190221005826.26317-1-f.fainelli@gmail.com>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v3 3/8] staging: fsl-dpaa2: ethsw: Handle
	PORT_PRE_BRIDGE_FLAGS
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
handle the SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute and check
that the bridge port flags being configured are supported.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 1b3943b71254..331625137717 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -666,6 +666,16 @@ static int port_attr_stp_state_set(struct net_device *netdev,
 	return ethsw_port_set_stp_state(port_priv, state);
 }
 
+static int port_attr_br_flags_pre_set(struct net_device *netdev,
+				      struct switchdev_trans *trans,
+				      unsigned long flags)
+{
+	if (flags & ~(BR_LEARNING | BR_FLOOD))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int port_attr_br_flags_set(struct net_device *netdev,
 				  struct switchdev_trans *trans,
 				  unsigned long flags)
@@ -698,6 +708,10 @@ static int swdev_port_attr_set(struct net_device *netdev,
 		err = port_attr_stp_state_set(netdev, trans,
 					      attr->u.stp_state);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		err = port_attr_br_flags_pre_set(netdev, trans,
+						 attr->u.brport_flags);
+		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		err = port_attr_br_flags_set(netdev, trans,
 					     attr->u.brport_flags);
-- 
2.17.1

