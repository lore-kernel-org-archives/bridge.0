Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ndKg9ATVhqHRP+XyLBlEyLJKFXx1AU9l2lVP0bNXvFQ=;
 b=T7n2R3SDebIL8wwmeQq/l7XV31GhrJDyf2OAecvjBBlXBraKEaF8Eber9ZPUj0EYX2
 3QsQ73t9igXn/kgo2wKch1e0btUFWW4OGYf5tVcbANb6wSzEwUy/ud39akPkr6TXF1i3
 sSU181xplZDi2cmMznzDxAZtahtQ+sqlx4Yqb+Hi5vRgF8a05domsd/3Qfc7kXzKb5UY
 iDSjHEooE9CCChrI5Xmc9+n54qPhsmGfJxUeJGyQVY+b3oejgeY5/zsh5FEPfz+MjIme
 MCrDBO9sIGKIdbtkQaHRlIbdmDpu8hWksDWfxe1HU7uHxdRyQIAkG69lUKGP2gGljcUK
 Veiw==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue, 29 Jun 2021 17:06:45 +0300
Message-Id: <20210629140658.2510288-3-olteanv@gmail.com>
In-Reply-To: <20210629140658.2510288-1-olteanv@gmail.com>
References: <20210629140658.2510288-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v5 net-next 02/15] net: bridge: switchdev: send FDB
	notifications for host addresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

From: Tobias Waldekranz <tobias@waldekranz.com>

Treat addresses added to the bridge itself in the same way as regular
ports and send out a notification so that drivers may sync it down to
the hardware FDB.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v4->v5: rebased on top of the READ_ONCE change

 net/bridge/br_fdb.c       |  4 ++--
 net/bridge/br_private.h   |  7 ++++---
 net/bridge/br_switchdev.c | 11 +++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index dc3ecf2d5637..bad7e84d76af 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -607,7 +607,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 			/* fastpath: update of existing entry */
 			if (unlikely(source != READ_ONCE(fdb->dst) &&
 				     !test_bit(BR_FDB_STICKY, &fdb->flags))) {
-				br_switchdev_fdb_notify(fdb, RTM_DELNEIGH);
+				br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
 				WRITE_ONCE(fdb->dst, source);
 				fdb_modified = true;
 				/* Take over HW learned entry */
@@ -800,7 +800,7 @@ static void fdb_notify(struct net_bridge *br,
 	int err = -ENOBUFS;
 
 	if (swdev_notify)
-		br_switchdev_fdb_notify(fdb, type);
+		br_switchdev_fdb_notify(br, fdb, type);
 
 	skb = nlmsg_new(fdb_nlmsg_size(), GFP_ATOMIC);
 	if (skb == NULL)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index a684d0cfc58c..2b48b204205e 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1654,8 +1654,8 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 			       unsigned long flags,
 			       unsigned long mask,
 			       struct netlink_ext_ack *extack);
-void br_switchdev_fdb_notify(const struct net_bridge_fdb_entry *fdb,
-			     int type);
+void br_switchdev_fdb_notify(struct net_bridge *br,
+			     const struct net_bridge_fdb_entry *fdb, int type);
 int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags,
 			       struct netlink_ext_ack *extack);
 int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid);
@@ -1702,7 +1702,8 @@ static inline int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid)
 }
 
 static inline void
-br_switchdev_fdb_notify(const struct net_bridge_fdb_entry *fdb, int type)
+br_switchdev_fdb_notify(struct net_bridge *br,
+			const struct net_bridge_fdb_entry *fdb, int type)
 {
 }
 
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 192293fe37fd..d3adee0f91f9 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -108,9 +108,11 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 }
 
 void
-br_switchdev_fdb_notify(const struct net_bridge_fdb_entry *fdb, int type)
+br_switchdev_fdb_notify(struct net_bridge *br,
+			const struct net_bridge_fdb_entry *fdb, int type)
 {
 	const struct net_bridge_port *dst = READ_ONCE(fdb->dst);
+	struct net_device *dev = dst ? dst->dev : br->dev;
 	struct switchdev_notifier_fdb_info info = {
 		.addr = fdb->key.addr.addr,
 		.vid = fdb->key.vlan_id,
@@ -119,17 +121,14 @@ br_switchdev_fdb_notify(const struct net_bridge_fdb_entry *fdb, int type)
 		.offloaded = test_bit(BR_FDB_OFFLOADED, &fdb->flags),
 	};
 
-	if (!dst)
-		return;
-
 	switch (type) {
 	case RTM_DELNEIGH:
 		call_switchdev_notifiers(SWITCHDEV_FDB_DEL_TO_DEVICE,
-					 dst->dev, &info.info, NULL);
+					 dev, &info.info, NULL);
 		break;
 	case RTM_NEWNEIGH:
 		call_switchdev_notifiers(SWITCHDEV_FDB_ADD_TO_DEVICE,
-					 dst->dev, &info.info, NULL);
+					 dev, &info.info, NULL);
 		break;
 	}
 }
-- 
2.25.1

