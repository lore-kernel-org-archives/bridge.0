Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=exDgzfiqwA3z8lOpN/VUH5vzBnnYQ2SOMaSyGMBZROQ=;
	b=AgYAp9no8pvAvhahS4zyEYOHWK5zf+kFJSllL5DEUXl1fxLONkSRzYz4e30Z0xlMaV
	wfpgwhE5AK9LuE0/11ZRAf9Y6OKE81L+wgGo4AFfmqOj0rI+BZb9f3OzVoIB3niDuSt2
	o0bDBjXzHFpV8o/TL2pSRAtMR3AEhGIgQpP4gGBAhRgbCWn+1rgjUOveU4h4thWPNwdn
	nwTcYvzt9ODORTlV3z+NiFi3b0YoicrVfb3x3OypO8bMLZH/aLlJ5fpNIWZN/s6JIu3f
	1YlizvlIgdvTt/VlS23Q19yObJzYbQlySh3ioBHmdRXX+GiiDoY6ZBhyKdso13kyh7MK
	Uh1g==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 10 Feb 2019 09:50:52 -0800
Message-Id: <20190210175105.31629-4-f.fainelli@gmail.com>
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 03/16] staging: fsl-dpaa2: ethsw: Check
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
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@gmail.com

In preparation for removing SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
have ethsw check that the bridge port flags that are being set are
supported.

Acked-by: Jiri Pirko <jiri@mellanox.com>
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
2.19.1

