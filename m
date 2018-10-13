Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=KV8E6iK0s17v+ZI/KhQWJpzK4Uf/qJi/osweKRs9glg=;
	b=i91yHPlYqbMm+u1DN39nSJi20sxuBjnzS8XpA9gsnNBVo4TLQ9awYkl3sylInG+iF7OkctOG/yAHTypD+TNiUl5x09LKiIsHRq/J0TMveLaBSGec/Ejz+45RksFrhmzy4lMX9PhQStUOYQRiEkwkoL7QLk4TuZerr2ozWtlU3h0=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sat, 13 Oct 2018 17:18:42 +0000
Message-ID: <20181013171725.3261-14-idosch@mellanox.com>
References: <20181013171725.3261-1-idosch@mellanox.com>
In-Reply-To: <20181013171725.3261-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 13/18] vxlan: Add vxlan_fdb_find_uc() for
 FDB querying
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, mlxsw <mlxsw@mellanox.com>, Ido Schimmel <idosch@mellanox.com>, "vivien.didelot@savoirfairelinux.com" <vivien.didelot@savoirfairelinux.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

From: Petr Machata <petrm@mellanox.com>

A switchdev-capable driver that is aware of VXLAN may need to query
VXLAN FDB. In the particular case of mlxsw, this functionality is
limited to querying UC FDBs. Those being easier to deal with than the
general case of RDST chain traversal, introduce an interface to query
specifically UC FDBs: vxlan_fdb_find_uc().

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/vxlan.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/net/vxlan.h | 12 ++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index f8b579648d42..97c2218569d9 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -504,6 +504,46 @@ static struct vxlan_rdst *vxlan_fdb_find_rdst(struct v=
xlan_fdb *f,
 	return NULL;
 }
=20
+int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
+		      struct switchdev_notifier_vxlan_fdb_info *fdb_info)
+{
+	struct vxlan_dev *vxlan =3D netdev_priv(dev);
+	u8 eth_addr[ETH_ALEN + 2] =3D { 0 };
+	struct vxlan_rdst *rdst;
+	struct vxlan_fdb *f;
+	int rc =3D 0;
+
+	if (is_multicast_ether_addr(mac) ||
+	    is_zero_ether_addr(mac))
+		return -EINVAL;
+
+	ether_addr_copy(eth_addr, mac);
+
+	rcu_read_lock();
+
+	f =3D __vxlan_find_mac(vxlan, eth_addr, vni);
+	if (!f) {
+		rc =3D -ENOENT;
+		goto out;
+	}
+
+	rdst =3D first_remote_rcu(f);
+
+	memset(fdb_info, 0, sizeof(*fdb_info));
+	fdb_info->info.dev =3D dev;
+	fdb_info->remote_ip =3D rdst->remote_ip;
+	fdb_info->remote_port =3D rdst->remote_port;
+	fdb_info->remote_vni =3D rdst->remote_vni;
+	fdb_info->remote_ifindex =3D rdst->remote_ifindex;
+	fdb_info->vni =3D vni;
+	ether_addr_copy(fdb_info->eth_addr, mac);
+
+out:
+	rcu_read_unlock();
+	return rc;
+}
+EXPORT_SYMBOL_GPL(vxlan_fdb_find_uc);
+
 /* Replace destination of unicast mac */
 static int vxlan_fdb_replace(struct vxlan_fdb *f,
 			     union vxlan_addr *ip, __be16 port, __be32 vni,
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index a82b735decbc..798ba5019f4e 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -413,4 +413,16 @@ struct switchdev_notifier_vxlan_fdb_info {
 	__be32 vni;
 };
=20
+#if IS_ENABLED(CONFIG_VXLAN)
+int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
+		      struct switchdev_notifier_vxlan_fdb_info *fdb_info);
+#else
+static inline int
+vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
+		  struct switchdev_notifier_vxlan_fdb_info *fdb_info)
+{
+	return -ENOENT;
+}
+#endif
+
 #endif
--=20
2.17.2

