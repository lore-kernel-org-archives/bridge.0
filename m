Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=FGFWf5U9CHtZ6FB5zlzDIcFUgfeHDErZdPOql/NjREc=;
	b=U5pnJnzi48HrxK6RxIa5OSjwz0/2L0TQnyMRZ4Tm+xif1YMbHJprB+onmSkF2bd457
	DsUlwbe3TNherXstL0/xa8GSJTebXKNK4gO0d5y4Y2zdW7B03a5p1fCLufp8OitBK05k
	WaZIeT1P/JpV3JLoxf53pdjUO/h3jYfUcKvRecTyeOS0EUPrvv6BYEhM+m0T+lxCrDQl
	iqe1wuEefekU9BAA0yxQo6iqXW1LPvRbMWdb+lEKkARsPYXlY8jY6+eQL5RRreJqpeti
	mfbnXUlrwOUCKp07hcg4aovGARIy8DLLsbmVWHC4uDeU8RyL5zCTKLMP7GwqP74+a54B
	jv0g==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 10 Feb 2019 09:51:03 -0800
Message-Id: <20190210175105.31629-15-f.fainelli@gmail.com>
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 14/16] staging: fsl-dpaa2: ethsw:
	Handle SWITCHDEV_PORT_ATTR_SET
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

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare ethsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
swdev_port_attr_set() call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index b195b09e0d1d..8baa503d9a6a 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1092,6 +1092,20 @@ ethsw_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
+static int
+ethsw_switchdev_port_attr_set_event(unsigned long event,
+		struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err;
+
+	err = swdev_port_attr_set(netdev, port_attr_info->attr,
+				  port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int port_switchdev_blocking_event(struct notifier_block *unused,
 					 unsigned long event, void *ptr)
 {
@@ -1104,6 +1118,8 @@ static int port_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return ethsw_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return ethsw_switchdev_port_attr_set_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.19.1

