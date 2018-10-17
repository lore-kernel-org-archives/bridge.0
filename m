Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=t+G85UTX9aclid1DDoU8w6D2FE52kqmfRrz7coBm91w=;
	b=oHIwqCldz2NyX9toALRGaL6zWOwPWq7KbamZDEJKxMU9/W2CBIxJLeC7XwxDEdaDa04T7XBpphDB57KwxdNkCABlo6p99O7RuH5ZMYLHC1fgO7FsjGypTcLmifWGbowN/mzpgXmjlVzojEiw7uVydSSeoCT62d2s5x/X6T+MJCk=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 17 Oct 2018 08:53:22 +0000
Message-ID: <20181017085215.26607-13-idosch@mellanox.com>
References: <20181017085215.26607-1-idosch@mellanox.com>
In-Reply-To: <20181017085215.26607-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 12/18] vxlan: Add switchdev
	notifications
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, Ido Schimmel <idosch@mellanox.com>, "vivien.didelot@savoirfairelinux.com" <vivien.didelot@savoirfairelinux.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Jiri Pirko <jiri@mellanox.com>, mlxsw <mlxsw@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

From: Petr Machata <petrm@mellanox.com>

When offloading VXLAN devices, drivers need to know about events in
VXLAN FDB database. Since VXLAN models a bridge, it is natural to
distribute the VXLAN FDB notifications using the pre-existing switchdev
notification mechanism.

To that end, introduce two new notification types:
SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE and SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE.
Introduce a new function, vxlan_fdb_switchdev_call_notifiers() to send
the new notifier types, and a struct switchdev_notifier_vxlan_fdb_info
to communicate the details of the FDB entry under consideration.

Invoke the new function from vxlan_fdb_notify().

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/vxlan.c     | 46 +++++++++++++++++++++++++++++++++++++++--
 include/net/switchdev.h |  3 +++
 include/net/vxlan.h     | 11 ++++++++++
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 0fc2b1d82d4c..de5caa2f6aac 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -327,8 +327,8 @@ static inline size_t vxlan_nlmsg_size(void)
 		+ nla_total_size(sizeof(struct nda_cacheinfo));
 }
=20
-static void vxlan_fdb_notify(struct vxlan_dev *vxlan, struct vxlan_fdb *fd=
b,
-			     struct vxlan_rdst *rd, int type)
+static void __vxlan_fdb_notify(struct vxlan_dev *vxlan, struct vxlan_fdb *=
fdb,
+			       struct vxlan_rdst *rd, int type)
 {
 	struct net *net =3D dev_net(vxlan->dev);
 	struct sk_buff *skb;
@@ -353,6 +353,48 @@ static void vxlan_fdb_notify(struct vxlan_dev *vxlan, =
struct vxlan_fdb *fdb,
 		rtnl_set_sk_err(net, RTNLGRP_NEIGH, err);
 }
=20
+static void vxlan_fdb_switchdev_call_notifiers(struct vxlan_dev *vxlan,
+					       struct vxlan_fdb *fdb,
+					       struct vxlan_rdst *rd,
+					       bool adding)
+{
+	struct switchdev_notifier_vxlan_fdb_info info;
+	enum switchdev_notifier_type notifier_type;
+
+	if (WARN_ON(!rd))
+		return;
+
+	notifier_type =3D adding ? SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE
+			       : SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE;
+
+	info =3D (struct switchdev_notifier_vxlan_fdb_info){
+		.remote_ip =3D rd->remote_ip,
+		.remote_port =3D rd->remote_port,
+		.remote_vni =3D rd->remote_vni,
+		.remote_ifindex =3D rd->remote_ifindex,
+		.vni =3D fdb->vni,
+	};
+	memcpy(info.eth_addr, fdb->eth_addr, ETH_ALEN);
+
+	call_switchdev_notifiers(notifier_type, vxlan->dev,
+				 &info.info);
+}
+
+static void vxlan_fdb_notify(struct vxlan_dev *vxlan, struct vxlan_fdb *fd=
b,
+			     struct vxlan_rdst *rd, int type)
+{
+	switch (type) {
+	case RTM_NEWNEIGH:
+		vxlan_fdb_switchdev_call_notifiers(vxlan, fdb, rd, true);
+		break;
+	case RTM_DELNEIGH:
+		vxlan_fdb_switchdev_call_notifiers(vxlan, fdb, rd, false);
+		break;
+	}
+
+	__vxlan_fdb_notify(vxlan, fdb, rd, type);
+}
+
 static void vxlan_ip_miss(struct net_device *dev, union vxlan_addr *ipa)
 {
 	struct vxlan_dev *vxlan =3D netdev_priv(dev);
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index d574ce63bf22..47199a11c586 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -145,6 +145,9 @@ enum switchdev_notifier_type {
 	SWITCHDEV_FDB_ADD_TO_DEVICE,
 	SWITCHDEV_FDB_DEL_TO_DEVICE,
 	SWITCHDEV_FDB_OFFLOADED,
+
+	SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
+	SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE,
 };
=20
 struct switchdev_notifier_info {
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 95227fa925e8..3f00877f5edf 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -6,6 +6,7 @@
 #include <net/udp_tunnel.h>
 #include <net/dst_metadata.h>
 #include <net/rtnetlink.h>
+#include <net/switchdev.h>
=20
 /* VXLAN protocol (RFC 7348) header:
  * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
@@ -409,4 +410,14 @@ static inline bool netif_is_vxlan(const struct net_dev=
ice *dev)
 	       !strcmp(dev->rtnl_link_ops->kind, "vxlan");
 }
=20
+struct switchdev_notifier_vxlan_fdb_info {
+	struct switchdev_notifier_info info; /* must be first */
+	union vxlan_addr remote_ip;
+	__be16 remote_port;
+	__be32 remote_vni;
+	u32 remote_ifindex;
+	u8 eth_addr[ETH_ALEN];
+	__be32 vni;
+};
+
 #endif
--=20
2.17.2

