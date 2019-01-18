Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=PlpRXaOWEXwcAymcf+Y5YrE93is1Hpea2xnnnNyhB2E=;
	b=MJnUClCYu7SeNBzz1CkgHr84/OxFadZAMlBrR/FnfFfDYqZUacWnmgV7hpHmpZZaLI3dd0JVHmQ9b5+HsmoC079Oybv12Au6EIXKmLEYoCanEY53INZjM+6DM5AdTEaYEegeiEyebmnhH2iLzUVmms2SRaFBvBADhG6/HRJDEW4=
From: Ido Schimmel <idosch@mellanox.com>
Date: Fri, 18 Jan 2019 15:58:00 +0000
Message-ID: <20190118155719.14827-6-idosch@mellanox.com>
References: <20190118155719.14827-1-idosch@mellanox.com>
In-Reply-To: <20190118155719.14827-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net 5/8] net: bridge: Mark FDB entries that were
 added by user as such
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: mlxsw <mlxsw@mellanox.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, Alexander Petrovskiy <alexpe@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

Externally learned entries can be added by a user or by a switch driver
that is notifying the bridge driver about entries that were learned in
hardware.

In the first case, the entries are not marked with the 'added_by_user'
flag, which causes switch drivers to ignore them and not offload them.

The 'added_by_user' flag can be set on externally learned FDB entries
based on the 'swdev_notify' parameter in br_fdb_external_learn_add(),
which effectively means if the created / updated FDB entry was added by
a user or not.

Fixes: 816a3bed9549 ("switchdev: Add fdb.added_by_user to switchdev notific=
ations")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Alexander Petrovskiy <alexpe@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: bridge@lists.linux-foundation.org
---
 net/bridge/br_fdb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index fe3c758791ca..9e14767500ea 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1128,6 +1128,8 @@ int br_fdb_external_learn_add(struct net_bridge *br, =
struct net_bridge_port *p,
 			err =3D -ENOMEM;
 			goto err_unlock;
 		}
+		if (swdev_notify)
+			fdb->added_by_user =3D 1;
 		fdb->added_by_external_learn =3D 1;
 		fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	} else {
@@ -1147,6 +1149,9 @@ int br_fdb_external_learn_add(struct net_bridge *br, =
struct net_bridge_port *p,
 			modified =3D true;
 		}
=20
+		if (swdev_notify)
+			fdb->added_by_user =3D 1;
+
 		if (modified)
 			fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	}
--=20
2.20.1

