Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=JhDTjxL1DiADnRINxWwGqeDyEJSQNB5R03NAiQttvxw=;
	b=TH89cUZ81+yuazGUKZhe2pJ3nQu6GyAnfvwRidjVxgZsMcfaQ3rbfpoNVAVbqXL07l
	/n45ffeRhMs8AqJxqBqYhKI1ZYmq0h9kgM5FOmeLMZ8So+qXj6hUTegn3d2N2VvQhQbK
	BnsB4sAzaxWDRX+LAK/z/fD6YrCJuUG7nOkD5bC4dGwTuAftPMZipVufeFjd/Ohyn9Cf
	UCaII5KQ8k031GvIsg4/kKG10oBvhF54kh42IiFCZMwGpuhZ+r2+Rb3MZMAixWWkOOnp
	CQs+P1j9MTVummWS2mRJbNjiMbgN4er8xvKP4MF6YTBrBiRw5j8rEqUTKxIn1chfkL2V
	Q3OA==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri,  8 Feb 2019 16:32:41 -0800
Message-Id: <20190209003248.31088-10-f.fainelli@gmail.com>
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 09/16] switchdev: Add
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
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, vivien.didelot@gmail.com, Ido Schimmel <idosch@mellanox.com>, jiri@mellanox.com, "David S. Miller" <davem@davemloft.net>

In preparation for allowing switchdev enabled drivers to veto specific
attribute settings from within the context of the caller, introduce a
new switchdev notifier type for port attributes.

Suggested-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/switchdev.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 96cd3e795f7f..4c5f7e5430cf 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -141,6 +141,8 @@ enum switchdev_notifier_type {
 	SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
 	SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE,
 	SWITCHDEV_VXLAN_FDB_OFFLOADED,
+
+	SWITCHDEV_PORT_ATTR_SET, /* Blocking. */
 };
 
 struct switchdev_notifier_info {
@@ -163,6 +165,13 @@ struct switchdev_notifier_port_obj_info {
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
2.17.1

