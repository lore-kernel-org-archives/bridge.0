Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=a873itx+S/T6yC+oMc+1M1LiImcgfFyeED4oExKC26w=;
	b=mKaPj6sm8tggLzNs698hl1jZiyYmcNwQSzZ1b7TwTtX6DapyetiOaR4Azzlo9/pDDy
	yZDQ9nhhHJGcDxDqj3/f5G+EJZI4a+/2CMm+Wr+xo+6o7xvxJ0BIhjWYiXxtgvWULLXm
	HXo/x3VR04o90sr171OmGBP4/s0LyFrO0DgBYkFNdeOHLrqycgzDTGTmcUD41+OJTGYq
	uuKq2QZJQHAK9fj3spFs4fgBOxJsF8o1rim92padBvg4S7qnci7boN9mGJF/IASIv8QC
	DHmund0/LVFNKI3uOYI5V/ffOFLXykVjllaOfikCTuME3qgMdl5VbiELKNWwOpy1j3+l
	TUBQ==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 13 Feb 2019 14:06:33 -0800
Message-Id: <20190213220638.1552-5-f.fainelli@gmail.com>
In-Reply-To: <20190213220638.1552-1-f.fainelli@gmail.com>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 4/9] staging: fsl-dpaa2: ethsw: Check
	bridge port flags during prepare
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
have ethsw check that the bridge port flags that are being set are
supported when SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS is specified.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 1b3943b71254..f788a9458b89 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -668,13 +668,16 @@ static int port_attr_stp_state_set(struct net_device *netdev,
 
 static int port_attr_br_flags_set(struct net_device *netdev,
 				  struct switchdev_trans *trans,
-				  unsigned long flags)
+				  unsigned long flags, bool pre_set)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int err = 0;
 
-	if (switchdev_trans_ph_prepare(trans))
+	if (switchdev_trans_ph_prepare(trans) && pre_set) {
+		if (flags & ~(BR_LEARNING | BR_FLOOD))
+			return -EOPNOTSUPP;
 		return 0;
+	}
 
 	/* Learning is enabled per switch */
 	err = ethsw_set_learning(port_priv->ethsw_data, flags & BR_LEARNING);
@@ -691,6 +694,7 @@ static int swdev_port_attr_set(struct net_device *netdev,
 			       const struct switchdev_attr *attr,
 			       struct switchdev_trans *trans)
 {
+	bool pre_set = false;
 	int err = 0;
 
 	switch (attr->id) {
@@ -698,9 +702,11 @@ static int swdev_port_attr_set(struct net_device *netdev,
 		err = port_attr_stp_state_set(netdev, trans,
 					      attr->u.stp_state);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		pre_set = true; /* fall through */
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		err = port_attr_br_flags_set(netdev, trans,
-					     attr->u.brport_flags);
+					     attr->u.brport_flags, pre_set);
 		break;
 	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
 		/* VLANs are supported by default  */
-- 
2.17.1

