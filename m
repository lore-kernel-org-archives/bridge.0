Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C53DB4154A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5CC8041548
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDjQ80FxKDBMZsQI1GulWLm/sHgS9qG0CVg2VFDT9Uw=;
 b=Qefg1adAKoLOow2GJjS4SycoHYC4KDWKZzw3WjYK36stW62oZoUvOGByTklRa5YBilT/j7x+tjWErxJXQn3QpIpsI3oryW4Q8zRnDWpgYgzoESeNX7dUhE331jjWoMmDFrvUXQiyULtc98sGxQ0X2EcFsCFs/T/LGdn3n0k8KmSPK6wxk3p5noMLdEuf9KICgh1mINWzRdmkbSYvmyiRJT3rfOt75O84ET6jWEHouYBi0mjJIoxocxcRpWG2Rc+aDur6TiWk8awS9rTMXdq136+PYXEUh3ptobcg4UDsb1VShndpMGyyFVNQd1jaVbfQw633XXgGdgHQA+QAi4CGFA==
From: Petr Machata <petrm@nvidia.com>
Date: Wed, 19 Jul 2023 13:01:16 +0200
Message-ID: <009406289387d9d34b76085fa858b8cd4d287851.1689763088.git.petrm@nvidia.com>
In-Reply-To: <cover.1689763088.git.petrm@nvidia.com>
References: <cover.1689763088.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 01/17] net: bridge: br_switchdev: Tolerate
	-EOPNOTSUPP when replaying MDB
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, Jiri Pirko <jiri@resnulli.us>, Danielle Ratson <danieller@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, mlxsw@nvidia.com

There are two kinds of MDB entries to be replayed: port MDB entries, and
host MDB entries. They are both replayed by br_switchdev_mdb_replay(). If
the driver supports one kind, but lacks the other, the first -EOPNOTSUPP
returned terminates the whole replay, including any further still-supported
objects in the list.

For this to cause issues, there must be MDB entries for both the host and
the port being replayed. In that case, if the driver bails out from
handling the host entry, the port entries are never replayed. However, the
replay is currently only done when a switchdev port joins a bridge. There
would be no port memberships at that point. Thus despite being erroneous,
the code does not cause observable bugs.

This is not an issue with other object kinds either, because there, each
function replays one object kind. If a driver does not support that kind,
it makes sense to bail out early. -EOPNOTSUPP is then ignored in
nbp_switchdev_sync_objs().

For MDB, suppress the -EOPNOTSUPP error code in br_switchdev_mdb_replay()
already, so that the whole list gets replayed.

The reason we need this patch is that a future patch will introduce a
replay that should be used when a front-panel port netdevice is enslaved to
a bridge lower, in particular a LAG. The LAG netdevice can already have
both host and port MDB entries. The port entries need to be replayed so
that they are offloaded on the port that joins the LAG.

Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Ivan Vecera <ivecera@redhat.com>
Cc: Roopa Prabhu <roopa@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: bridge@lists.linux-foundation.org
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 net/bridge/br_switchdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index ba95c4d74a60..e92e0338afee 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -727,6 +727,8 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
 		err = br_switchdev_mdb_replay_one(nb, dev,
 						  SWITCHDEV_OBJ_PORT_MDB(obj),
 						  action, ctx, extack);
+		if (err == -EOPNOTSUPP)
+			err = 0;
 		if (err)
 			goto out_free_mdb;
 	}
@@ -759,8 +761,10 @@ static int nbp_switchdev_sync_objs(struct net_bridge_port *p, const void *ctx,
 
 	err = br_switchdev_mdb_replay(br_dev, dev, ctx, true, blocking_nb,
 				      extack);
-	if (err && err != -EOPNOTSUPP)
+	if (err) {
+		/* -EOPNOTSUPP not propagated from MDB replay. */
 		return err;
+	}
 
 	err = br_switchdev_fdb_replay(br_dev, ctx, true, atomic_nb);
 	if (err && err != -EOPNOTSUPP)
-- 
2.40.1

