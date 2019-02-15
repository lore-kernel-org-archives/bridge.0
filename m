Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=n2/1JGLjz3gI0i0km/VMbftbaECrLXWDDsdiVS5YC7k=;
	b=Pza6dnJZmj4HZD8QFkaW8X3wWci5bwclZAeF4EWR3Po9m2NBomOZP3HPj7WfsMdUjz
	W1nyIulcOWb9eEZvavsBcS2pR6lj0lyeHOTzsFgfS/XrGCYJyiit8+f3Fin+y9OvsrrC
	hVBGMjEdjqKOxbPfcaol2CJw4BzFOD2UMfnxn46hUybTn1guv1w+iU9KFCMQn5ZWSc1/
	vLuFIV3r97/F5emOVrrzcM+279Ts7olbXGIBqHsMTA9FY9gwU3Iue/viyiLwl1fGXbcL
	yfhgl2bnHw8NR3QBTrS6nkUpKWMpDYtDEaxzaFBCava3fhWZ2U1o3hyUk7r+O4ulqU52
	i+rA==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 15 Feb 2019 14:53:08 -0800
Message-Id: <20190215225313.32303-5-f.fainelli@gmail.com>
In-Reply-To: <20190215225313.32303-1-f.fainelli@gmail.com>
References: <20190215225313.32303-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v2 4/9] staging: fsl-dpaa2: ethsw: Handle
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
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 1b3943b71254..640fd6834be1 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -666,6 +666,19 @@ static int port_attr_stp_state_set(struct net_device *netdev,
 	return ethsw_port_set_stp_state(port_priv, state);
 }
 
+static int port_attr_br_flags_pre_set(struct net_device *netdev,
+				      struct switchdev_trans *trans,
+				      unsigned long flags)
+{
+	if (switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	if (flags & ~(BR_LEARNING | BR_FLOOD))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int port_attr_br_flags_set(struct net_device *netdev,
 				  struct switchdev_trans *trans,
 				  unsigned long flags)
@@ -698,6 +711,10 @@ static int swdev_port_attr_set(struct net_device *netdev,
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

