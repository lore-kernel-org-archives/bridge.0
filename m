Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=W/bK0uM1qvCsahePr0Vi1JK2YG8XlOrGmQc4rU8B8ls=;
	b=i3JcjDzEixDMnRDJVS0tfgTfpDL5KZHkm9izBxwVoMwA9kaAio3en9RuWhwOVVAAMCL4P9Bc0TS7eX0w+noe0hfpLzqZ5J1n5lsOik+TfjfO+R8omo5ZxrkCfxTzJdcwp9AyRjF/SP13fGYCRxES+6UY/uG9/KeJhmOhGtWCZDQ=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 21 Nov 2018 08:02:41 +0000
Message-ID: <20181121080141.16676-8-idosch@mellanox.com>
References: <20181121080141.16676-1-idosch@mellanox.com>
In-Reply-To: <20181121080141.16676-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 07/16] bridge: Allow querying bridge port
	flags
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, Ido Schimmel <idosch@mellanox.com>, mlxsw <mlxsw@mellanox.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

Allow querying bridge port flags so that drivers capable of performing
VxLAN learning will update the bridge driver only if learning is enabled
on its bridge port corresponding to the VxLAN device.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 include/linux/if_bridge.h |  6 ++++++
 net/bridge/br_if.c        | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index c20c7e197d07..ef7c3d376b21 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -119,6 +119,7 @@ static inline int br_vlan_get_info(const struct net_dev=
ice *dev, u16 vid,
 struct net_device *br_fdb_find_port(const struct net_device *br_dev,
 				    const unsigned char *addr,
 				    __u16 vid);
+bool br_port_flag_is_set(const struct net_device *dev, unsigned long flag)=
;
 #else
 static inline struct net_device *
 br_fdb_find_port(const struct net_device *br_dev,
@@ -127,6 +128,11 @@ br_fdb_find_port(const struct net_device *br_dev,
 {
 	return NULL;
 }
+static inline bool
+br_port_flag_is_set(const struct net_device *dev, unsigned long flag)
+{
+	return false;
+}
 #endif
=20
 #endif
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 9b46d2dc4c22..d4863f5679ac 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -741,3 +741,15 @@ void br_port_flags_change(struct net_bridge_port *p, u=
nsigned long mask)
 	if (mask & BR_NEIGH_SUPPRESS)
 		br_recalculate_neigh_suppress_enabled(br);
 }
+
+bool br_port_flag_is_set(const struct net_device *dev, unsigned long flag)
+{
+	struct net_bridge_port *p;
+
+	p =3D br_port_get_rtnl_rcu(dev);
+	if (!p)
+		return false;
+
+	return p->flags & flag;
+}
+EXPORT_SYMBOL_GPL(br_port_flag_is_set);
--=20
2.19.1

