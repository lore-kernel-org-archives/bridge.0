Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=hWVdHii8ckcvI1Css/ppCdD5B7yTXb8aPWmds2fbqAc=;
	b=UIVhll2JY7NyNcFWY+FaVozzgAko5FkXAbOhZC4y4yEQa0Unnqa9tDmWlBkbhBDTkb
	LAk5v+zCfJZbeLAaUEEdhmn+uSPpBDc05yKkrAkWFJZ/soU/KFUJZcvgJ5ykZIZBCTGp
	54Cdhv1F+GZtRhfaPMSWce/4ps2jtAnrfh9VTXbUphGoZP/qnNDEbD/+rfd/UsWGGl+k
	aN17JYDTkA/mybijkjcTes+d6pRkw/ltA6pJ/4qoAshsUEyQ3zazwEQe1pwwqcYJGcOF
	pnxyD7eTEnSxN2kGpln6T66fP0yfpFX/yQt4HcuEFxUnwL8T6L/2aspcnFA9LidTVAel
	kWZg==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 10 Feb 2019 15:40:00 -0800
Message-Id: <20190210234007.16173-3-f.fainelli@gmail.com>
In-Reply-To: <20190210234007.16173-1-f.fainelli@gmail.com>
References: <20190210234007.16173-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v3 2/9] switchdev: Add
	SWITCHDEV_PORT_ATTR_SET, SWITCHDEV_PORT_ATTR_GET
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

In preparation for allowing switchdev enabled drivers to veto specific
attribute settings from within the context of the caller, introduce a
new switchdev notifier type for port attributes.

Suggested-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/switchdev.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 5e87b54c5dc5..b8becabbef38 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -143,6 +143,9 @@ enum switchdev_notifier_type {
 	SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
 	SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE,
 	SWITCHDEV_VXLAN_FDB_OFFLOADED,
+
+	SWITCHDEV_PORT_ATTR_SET, /* Blocking. */
+	SWITCHDEV_PORT_ATTR_GET, /* Blocking. */
 };
 
 struct switchdev_notifier_info {
@@ -165,6 +168,13 @@ struct switchdev_notifier_port_obj_info {
 	bool handled;
 };
 
+struct switchdev_notifier_port_attr_info {
+	struct switchdev_notifier_info info; /* must be first */
+	struct switchdev_attr *attr;
+	struct switchdev_trans *trans;
+	bool handled;
+};
+
 static inline struct net_device *
 switchdev_notifier_info_to_dev(const struct switchdev_notifier_info *info)
 {
-- 
2.19.1

