Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=QA40rPEhuXPofIQU7vYAyGMcSK0VqfBQ5xwZGHv+dPM=;
	b=NBK1CTtryHR6sFv2CVIZlk/pkEccWfogqsWQT303Jbs4aAIm5Pnu88qp2UGAPOb7C0
	w0VKUdp8uCjti8rbPCs+KRTQ2AzaqvCNMVAeYThwWoIF08Vcn6pw+PFYg8FPH2wbWBrb
	3IRjUhCNV6nvqKMoTMwiIxcWcodqO3ikHY0CtS26nw0v1/WscuARB6huJV2vHGWp8Ga3
	Z7KHdWUHkTY93tQU6FQjZ14FfBQ6LRu4+uSrj6L36dBtgsVRHXq6if5HVh9geFtVO13b
	RtRH5m/ZrXGdL13DyVbekIGsYnF3pRi1EMLK5KpRFf30Ysn6BOdKEYvZ1d5AR8TLx/XM
	cZgg==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 10 Feb 2019 09:50:55 -0800
Message-Id: <20190210175105.31629-7-f.fainelli@gmail.com>
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 06/16] net: bridge: Stop calling
	switchdev_port_attr_get()
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

Now that all switchdev drivers have been converted to checking the
bridge port flags during the prepare phase of the
switchdev_port_attr_set(), we can move straight to trying to set the
desired flag through SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS.

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/bridge/br_switchdev.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index db9e8ab96d48..939f300522c5 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -64,29 +64,15 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 {
 	struct switchdev_attr attr = {
 		.orig_dev = p->dev,
-		.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
+		.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
+		.flags = SWITCHDEV_F_DEFER,
+		.u.brport_flags = flags,
 	};
 	int err;
 
 	if (mask & ~BR_PORT_FLAGS_HW_OFFLOAD)
 		return 0;
 
-	err = switchdev_port_attr_get(p->dev, &attr);
-	if (err == -EOPNOTSUPP)
-		return 0;
-	if (err)
-		return err;
-
-	/* Check if specific bridge flag attribute offload is supported */
-	if (!(attr.u.brport_flags_support & mask)) {
-		br_warn(p->br, "bridge flag offload is not supported %u(%s)\n",
-			(unsigned int)p->port_no, p->dev->name);
-		return -EOPNOTSUPP;
-	}
-
-	attr.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS;
-	attr.flags = SWITCHDEV_F_DEFER;
-	attr.u.brport_flags = flags;
 	err = switchdev_port_attr_set(p->dev, &attr);
 	if (err) {
 		br_warn(p->br, "error setting offload flag on port %u(%s)\n",
-- 
2.19.1

