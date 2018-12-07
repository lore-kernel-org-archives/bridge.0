Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=/4T9aSrxXcxw4Z1uIfjwejr6PBIZ1f/vdEM014dA0ns=;
	b=Wp7RHKDLnkxy5BA9UbW8aK4em0gjQ10f0qYNoNc7WGCjy2Kka+0aFokqsC7T90FKlxbicJFSMqdqgjY97nDkI5r10qHx9Sjeoe5+IYg0q8J8HXxaSj4GZ+x8hXacFc3rUiY7rDi6sSgW7gfGjb8QO4YgWmbJ7WpMHGayzw4SFUc=
From: Ido Schimmel <idosch@mellanox.com>
Date: Fri, 7 Dec 2018 19:55:07 +0000
Message-ID: <20181207195433.22540-5-idosch@mellanox.com>
References: <20181207195433.22540-1-idosch@mellanox.com>
In-Reply-To: <20181207195433.22540-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 04/12] bridge: Add
	br_fdb_clear_offload()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

From: Petr Machata <petrm@mellanox.com>

When a driver unoffloads all FDB entries en bloc, it's inefficient to
send the switchdev notification one by one. Add a helper that unsets the
offload flag on FDB entries on a given bridge port and VLAN.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 include/linux/if_bridge.h |  6 ++++++
 net/bridge/br_fdb.c       | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index ef7c3d376b21..627b788ba0ff 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -119,6 +119,7 @@ static inline int br_vlan_get_info(const struct net_dev=
ice *dev, u16 vid,
 struct net_device *br_fdb_find_port(const struct net_device *br_dev,
 				    const unsigned char *addr,
 				    __u16 vid);
+void br_fdb_clear_offload(const struct net_device *dev, u16 vid);
 bool br_port_flag_is_set(const struct net_device *dev, unsigned long flag)=
;
 #else
 static inline struct net_device *
@@ -128,6 +129,11 @@ br_fdb_find_port(const struct net_device *br_dev,
 {
 	return NULL;
 }
+
+static inline void br_fdb_clear_offload(const struct net_device *dev, u16 =
vid)
+{
+}
+
 static inline bool
 br_port_flag_is_set(const struct net_device *dev, unsigned long flag)
 {
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e56ba3912a90..38b1d0dd0529 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1164,3 +1164,23 @@ void br_fdb_offloaded_set(struct net_bridge *br, str=
uct net_bridge_port *p,
=20
 	spin_unlock_bh(&br->hash_lock);
 }
+
+void br_fdb_clear_offload(const struct net_device *dev, u16 vid)
+{
+	struct net_bridge_fdb_entry *f;
+	struct net_bridge_port *p;
+
+	ASSERT_RTNL();
+
+	p =3D br_port_get_rtnl(dev);
+	if (!p)
+		return;
+
+	spin_lock_bh(&p->br->hash_lock);
+	hlist_for_each_entry(f, &p->br->fdb_list, fdb_node) {
+		if (f->dst =3D=3D p && f->key.vlan_id =3D=3D vid)
+			f->offloaded =3D 0;
+	}
+	spin_unlock_bh(&p->br->hash_lock);
+}
+EXPORT_SYMBOL_GPL(br_fdb_clear_offload);
--=20
2.19.1

