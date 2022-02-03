Return-Path: <oleksandr.mazur@plvision.eu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oilwTxtWG9ioJagG2A1UEQStcPOJxwa1T/rekfuWgyo=;
 b=U4dzlQVJaPv3sGXyzz3Z5x+0vk8BjaBq9E9J7mREyo6pKluj3QghT2StNWE/k4I4RGcv+3JvACebSJSjnVCMN1p/C3++cX/LJdJ3YH5eBvikJvn6ZWeqFIwLq+Z/DFnLL7Gctm5uNectVrCqpbIk3ZvkyLsTivwXolgyK1wJq94=
From: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
Date: Thu,  3 Feb 2022 19:06:54 +0200
Message-Id: <20220203170654.29784-1-oleksandr.mazur@plvision.eu>
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC net-next] net: bridge: multicast: notify switchdev
	driver whenever MC processing gets disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Oleksandr Mazur <oleksandr.mazur@plvision.eu>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

Whenever bridge driver hits the max capacity of MDBs, it disables
the MC processing (by setting corresponding bridge option), but never
notifies switchdev about such change (the notifiers are called only upon
explicit setting of this option, through the registered netlink interface).

This could lead to situation when Software MDB processing gets disabled,
but this event never gets offloaded to the underlying Hardware.

I would like to propose to simply add a notify message in such case,
as in other places where this option gets altered.

Signed-off-by: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
---
 net/bridge/br_multicast.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index de2409889489..d53c08906bc8 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -82,6 +82,9 @@ static void br_multicast_find_del_pg(struct net_bridge *br,
 				     struct net_bridge_port_group *pg);
 static void __br_multicast_stop(struct net_bridge_mcast *brmctx);
 
+static int br_mc_disabled_update(struct net_device *dev, bool value,
+				 struct netlink_ext_ack *extack);
+
 static struct net_bridge_port_group *
 br_sg_port_find(struct net_bridge *br,
 		struct net_bridge_port_group_sg_key *sg_p)
@@ -1156,6 +1159,8 @@ struct net_bridge_mdb_entry *br_multicast_new_group(struct net_bridge *br,
 		return mp;
 
 	if (atomic_read(&br->mdb_hash_tbl.nelems) >= br->hash_max) {
+		err = br_mc_disabled_update(br->dev, false, NULL);
+		WARN_ON(err && err != -EOPNOTSUPP);
 		br_opt_toggle(br, BROPT_MULTICAST_ENABLED, false);
 		return ERR_PTR(-E2BIG);
 	}
-- 
2.17.1

