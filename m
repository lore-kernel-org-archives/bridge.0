Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Y8cTug1MK//k9Db5o5+0BQipNr3buFiSVSYrdmVTLt0=;
	b=s5Txl0w08kvB8rj/qhwE8TSWEgp5Pv+gpFpYiLq9AcCIsSRkIp7AGb227mXMKAmEvQ
	oEwl6VcefRBKfq/AONU9fLscQIEHODKVXT31KnnZU4wOpjJutyoqlnt7ir4MREEcM2zY
	757a2pxH49+RWT3hlwxCN/UOKaoUyKK3iNf0iSAl/TcW9Zruf7LW5UMsg5V+zopNdFCs
	Ge5z/WxPQQMOQ1Z3mCROh4RTMGnvNZWpKKQMXvfWw3mgjNcu/euCHtGhPZ6PtVvBkIVz
	W15vz7lS9lY8xt1oxpHAJeT+OszxemQQjKr2Ssbh1wHXLvFRS1L7aly2rQYc7u9r2SxQ
	a3Ow==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 15 Feb 2019 14:53:06 -0800
Message-Id: <20190215225313.32303-3-f.fainelli@gmail.com>
In-Reply-To: <20190215225313.32303-1-f.fainelli@gmail.com>
References: <20190215225313.32303-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v2 2/9] net: switchdev: Add
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

In preparation for removing switchdev_port_attr_get(), introduce
PORT_PRE_BRIDGE_FLAGS which will be called through
switchdev_port_attr_set(), in the caller's context (possibly atomic) and
which must be checked by the switchdev driver in order to return whether
the operation is supported or not.

This is entirely analoguous to how the BRIDGE_FLAGS_SUPPORT works,
except it goes through a set() instead of get().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/switchdev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 5e87b54c5dc5..de72b0a3867f 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -46,6 +46,7 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_PORT_STP_STATE,
 	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
 	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
+	SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
 	SWITCHDEV_ATTR_ID_PORT_MROUTER,
 	SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME,
 	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING,
@@ -61,7 +62,7 @@ struct switchdev_attr {
 	void (*complete)(struct net_device *dev, int err, void *priv);
 	union {
 		u8 stp_state;				/* PORT_STP_STATE */
-		unsigned long brport_flags;		/* PORT_BRIDGE_FLAGS */
+		unsigned long brport_flags;		/* PORT_{PRE}_BRIDGE_FLAGS */
 		unsigned long brport_flags_support;	/* PORT_BRIDGE_FLAGS_SUPPORT */
 		bool mrouter;				/* PORT_MROUTER */
 		clock_t ageing_time;			/* BRIDGE_AGEING_TIME */
-- 
2.17.1

