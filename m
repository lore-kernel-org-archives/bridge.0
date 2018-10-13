Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ae6GkrQtNIjJHtl25BlZtSnToEuaOo6HEgUhbLZFLVA=;
	b=qr5ijVESPvD/GA20yog8O8gpesHX2QWd08tP96eKPcoXoCPeZeDPYhGdaXHodmp+tv+rBxse07rpnN3fOCTvf0MY+RHlCVMk35ouJjqBFX8g6lNEl3NzBuXXFLwqRNDsRT/zNxKldnPpbKpPDuo02TKm9lGS6LB98+D1QZYX5zQ=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sat, 13 Oct 2018 17:18:46 +0000
Message-ID: <20181013171725.3261-16-idosch@mellanox.com>
References: <20181013171725.3261-1-idosch@mellanox.com>
In-Reply-To: <20181013171725.3261-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 15/18] vxlan: Notify for each remote of a
 removed FDB entry
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

When notifications are sent about FDB activity, and an FDB entry with
several remotes is removed, the notification is sent only for the first
destination. That makes it impossible to distinguish between the case
where only this first remote is removed, and the one where the FDB entry
is removed as a whole.

Therefore send one notification for each remote of a removed FDB entry.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/vxlan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 0be9e285f265..db5d390b9130 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -839,12 +839,15 @@ static void vxlan_fdb_free(struct rcu_head *head)
 static void vxlan_fdb_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f=
,
 			      bool do_notify)
 {
+	struct vxlan_rdst *rd;
+
 	netdev_dbg(vxlan->dev,
 		    "delete %pM\n", f->eth_addr);
=20
 	--vxlan->addrcnt;
 	if (do_notify)
-		vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f), RTM_DELNEIGH);
+		list_for_each_entry(rd, &f->remotes, list)
+			vxlan_fdb_notify(vxlan, f, rd, RTM_DELNEIGH);
=20
 	hlist_del_rcu(&f->hlist);
 	call_rcu(&f->rcu, vxlan_fdb_free);
--=20
2.17.2

