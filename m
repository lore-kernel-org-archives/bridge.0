Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=33kk5S35E4b328f8vXqo4LKpo2Z5ZPT3Y6kFb640bVo=;
	b=ds1cgo2iCYBWm6Cr+ZtQVCrU1lUdjl4DdnRf47CsrsS7lKxG6+CqmEYNb+UwnjyiEb
	vNFrwL+t/iNRr37Xp6ssDjtzdATTya7BC+0BuH3MVBq8/AZAb5HIpPUlKy+9175rOSKk
	OqUEJrhG58MSkw7OXIIESlaa8fnHjE2SemIM3u9HBNqdNDQfyAkaniHRIAXX+4w45Bsj
	ndijfSkd9TGTgffO03RAOjYUaUcwnzwEGGyFdcBSN0gagYOmc7wwpFDuuuIflF27l8vg
	HUNRasl6vnMKzp6LeIqWtl9TB5bBhi9mUOJ++eCisW9SkcTiQpP4q8x4pUt7Val9w7pi
	e9WA==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri,  8 Feb 2019 16:32:35 -0800
Message-Id: <20190209003248.31088-4-f.fainelli@gmail.com>
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 03/16] staging: fsl-dpaa2: ethsw: Check
	bridge port flags during set
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
supported.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index e559f4c25cf7..6228c4375835 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -680,8 +680,11 @@ static int port_attr_br_flags_set(struct net_device *netdev,
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int err = 0;
 
-	if (switchdev_trans_ph_prepare(trans))
+	if (switchdev_trans_ph_prepare(trans)) {
+		if (flags & ~(BR_LEARNING | BR_FLOOD))
+			return -EOPNOTSUPP;
 		return 0;
+	}
 
 	/* Learning is enabled per switch */
 	err = ethsw_set_learning(port_priv->ethsw_data, flags & BR_LEARNING);
-- 
2.17.1

