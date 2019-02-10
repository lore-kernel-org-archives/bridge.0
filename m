Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=81DjCgz+iyCtT5UWtxC0sunQeOYy1ppR2RSyv4AVzCg=;
	b=CNJJyBLB2tLVddFJ2LsHHczCUzrZYJe/u6ZVOeym6EOWO1QRjP5hyihNVBivQ1uhSR
	8knwLaI67D+lt3XKeg5r/JTvmLzUPf/u9RFutmQbgYG4YU3QqO1vNA752Oh0GAy1Ye+v
	eiuSrpkdK66kPRe4DfZYKrnWjthWxulQ4/hehAQZpQgKBaFgHXoA30cd2ohrJ8GxhOYo
	TzM0gAjPOwO/CROxdjsxhsJ1fimeWoQunp0Flkbl3kdSYDfhzVsZkiQ1uJbVm2t6HpIs
	gikhmHG5EIRAhiBpkAoFGtptYr/sXsSxlL+6RjRUSYKD+lUNW4srNIECQIND8JNFSoNo
	Uu4A==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 10 Feb 2019 09:50:58 -0800
Message-Id: <20190210175105.31629-10-f.fainelli@gmail.com>
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 09/16] switchdev: Add
	SWITCHDEV_PORT_ATTR_SET
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
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/switchdev.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 96cd3e795f7f..7bc6a004d32a 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -135,6 +135,7 @@ enum switchdev_notifier_type {
 
 	SWITCHDEV_PORT_OBJ_ADD, /* Blocking. */
 	SWITCHDEV_PORT_OBJ_DEL, /* Blocking. */
+	SWITCHDEV_PORT_ATTR_SET, /* Blocking. */
 
 	SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE,
 	SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE,
@@ -163,6 +164,13 @@ struct switchdev_notifier_port_obj_info {
 	bool handled;
 };
 
+struct switchdev_notifier_port_attr_info {
+	struct switchdev_notifier_info info; /* must be first */
+	const struct switchdev_attr *attr;
+	struct switchdev_trans *trans;
+	bool handled;
+};
+
 static inline struct net_device *
 switchdev_notifier_info_to_dev(const struct switchdev_notifier_info *info)
 {
-- 
2.19.1

