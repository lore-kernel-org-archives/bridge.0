Return-Path: <sashal@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608689998;
 bh=qvD3SMMH9TlnZI5UCoeyWYZQOxEJ1KO9nA3Cw6KRVG0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PF+Fw7YiEmlhhPZY26Ne2Gf1OfJr2IydW3fjtbZmjfXlGApbMo1SqRc6R1E64DBEd
 MNCttHlt0PgkHxHVjtpbclFILu+iLiLfwNmSkkhf7xoqb82cpCGE1Qr2MntqsavG14
 e74JDFTmno9pQG0Jodm/7c31UgygPCXv9m1yA34xKUGX8YT/QN1yYT5cz37OAW4ABN
 M5you9eZU4S6TASr/SwEyxZzh+l1e2QbAUdOpOfhINvKhaYlQh2YTx0P5crzoibwcU
 3g9sN59uECo+4Sz3vX2s0GODLHsbYeHoWx3Zl8BObIDw6+nFAYiYvN/CJgiJ2g5FnH
 CtQPZBrXmx2DQ==
From: Sasha Levin <sashal@kernel.org>
Date: Tue, 22 Dec 2020 21:17:24 -0500
Message-Id: <20201223021813.2791612-81-sashal@kernel.org>
In-Reply-To: <20201223021813.2791612-1-sashal@kernel.org>
References: <20201223021813.2791612-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH AUTOSEL 5.4 081/130] bridge: switchdev: Notify
	about VLAN protocol changes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Ivan Vecera <ivecera@redhat.com>, Danielle Ratson <danieller@nvidia.com>, Sasha Levin <sashal@kernel.org>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>

From: Danielle Ratson <danieller@nvidia.com>

[ Upstream commit 22ec19f3aee327806c37c9fa1188741574bc6445 ]

Drivers that support bridge offload need to be notified about changes to
the bridge's VLAN protocol so that they could react accordingly and
potentially veto the change.

Add a new switchdev attribute to communicate the change to drivers.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/switchdev.h |  2 ++
 net/bridge/br_vlan.c    | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index aee86a1894327..1d54d468934ac 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -38,6 +38,7 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_PORT_MROUTER,
 	SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME,
 	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING,
+	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL,
 	SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED,
 	SWITCHDEV_ATTR_ID_BRIDGE_MROUTER,
 };
@@ -54,6 +55,7 @@ struct switchdev_attr {
 		bool mrouter;				/* PORT_MROUTER */
 		clock_t ageing_time;			/* BRIDGE_AGEING_TIME */
 		bool vlan_filtering;			/* BRIDGE_VLAN_FILTERING */
+		u16 vlan_protocol;			/* BRIDGE_VLAN_PROTOCOL */
 		bool mc_disabled;			/* MC_DISABLED */
 	} u;
 };
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 48413b5eb61fc..5536e1c9d5537 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -809,15 +809,25 @@ EXPORT_SYMBOL_GPL(br_vlan_get_proto);
 
 int __br_vlan_set_proto(struct net_bridge *br, __be16 proto)
 {
+	struct switchdev_attr attr = {
+		.orig_dev = br->dev,
+		.id = SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL,
+		.flags = SWITCHDEV_F_SKIP_EOPNOTSUPP,
+		.u.vlan_protocol = ntohs(proto),
+	};
 	int err = 0;
 	struct net_bridge_port *p;
 	struct net_bridge_vlan *vlan;
 	struct net_bridge_vlan_group *vg;
-	__be16 oldproto;
+	__be16 oldproto = br->vlan_proto;
 
 	if (br->vlan_proto == proto)
 		return 0;
 
+	err = switchdev_port_attr_set(br->dev, &attr);
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
 	/* Add VLANs for the new proto to the device filter. */
 	list_for_each_entry(p, &br->port_list, list) {
 		vg = nbp_vlan_group(p);
@@ -828,7 +838,6 @@ int __br_vlan_set_proto(struct net_bridge *br, __be16 proto)
 		}
 	}
 
-	oldproto = br->vlan_proto;
 	br->vlan_proto = proto;
 
 	recalculate_group_addr(br);
@@ -844,6 +853,9 @@ int __br_vlan_set_proto(struct net_bridge *br, __be16 proto)
 	return 0;
 
 err_filt:
+	attr.u.vlan_protocol = ntohs(oldproto);
+	switchdev_port_attr_set(br->dev, &attr);
+
 	list_for_each_entry_continue_reverse(vlan, &vg->vlan_list, vlist)
 		vlan_vid_del(p->dev, proto, vlan->vid);
 
-- 
2.27.0

