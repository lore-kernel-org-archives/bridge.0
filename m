Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=H4Y8A4xuqg0j64rJEM05W/f+R8PtN6hAxCFyq/qFXl0=;
	b=dvmCLGCnlWZxeH3BCjRHqaQc+cFdaTO6WoXfuP0Xtw8cxXtITrjGHPi/M+f6typUAQ
	DKOxlZGb9MS0dFdzMz/kxVBV1daoqKEU6mWD67Jd2mRCgx+7suuRHAQQH382cIQhupkr
	bTMhr+Zjw4JQRUvwng6K7gFY18SZwgkGwT4KK1TbvDanaa2alSt/4G/DkgegTOxLSVRt
	DuBrxkgO/P4ZCy8XwvUmzr1UQ+JeiyCADvEmflmNMgJ3P9YYE0v3FxDDt+teLeCUsELH
	/kZ7yQzPe/HRmHXP7AoH2HnGzOvdGoZMM4Yuf+i99cESRVCJBvRX93xGgdnp7CxrkGvi
	Jwyw==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 11 Feb 2019 13:17:49 -0800
Message-Id: <20190211211749.19847-4-f.fainelli@gmail.com>
In-Reply-To: <20190211211749.19847-1-f.fainelli@gmail.com>
References: <20190211211749.19847-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 3/3] staging: fsl-dpaa2: ethsw: Remove
	getting PORT_BRIDGE_FLAGS
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

There is no code that tries to get the attribute
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS, remove support for doing that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index e559f4c25cf7..e5a14c7c777f 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -646,11 +646,6 @@ static int swdev_port_attr_get(struct net_device *netdev,
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 
 	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
-		attr->u.brport_flags =
-			(port_priv->ethsw_data->learning ? BR_LEARNING : 0) |
-			(port_priv->flood ? BR_FLOOD : 0);
-		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
 		attr->u.brport_flags_support = BR_LEARNING | BR_FLOOD;
 		break;
-- 
2.17.1

