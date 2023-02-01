Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14840419DD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83AB04148A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdxOT8hga45jvdVP19SiFKaS4BJtGLG/uAo2D7DDn6U=;
 b=hwTdo+1aX4nqJCKU9TgbtoSsKKfw4I+TKYr0KfVf9ac8YAETEY+A8SkmonmzVfifLRqMmLqtZEVcutjc+d+k0NdUley62/8Dcarzu7WiM081eo42StuQJr+5IyBcY7gT/y59XrZ1VvxD5aAyahsUvMdIHQ0hbUu4CIv5PLdDlMV7c3hqzGXSU50tk94GQImDGyHvOpBZZ2Pd11pUyn1XoXA+OYrp63JyUtcPzLW6QL+z+lupvfgGzkEqi8tAMTMTZJ1E3ow/iR+k2gASw4W9fPziHoS/5hoZRlgnst9MJ+9/I2i/22yTv++R30+mJ24DGbukoNvzHGdncKI2/J/xRA==
From: Petr Machata <petrm@nvidia.com>
Date: Wed, 1 Feb 2023 18:28:40 +0100
Message-ID: <706d902460b69454ffeb57908beb8dce46e9b064.1675271084.git.petrm@nvidia.com>
In-Reply-To: <cover.1675271084.git.petrm@nvidia.com>
References: <cover.1675271084.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next mlxsw v2 07/16] net: bridge: Maintain
	number of MDB entries in net_bridge_mcast_port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org

The MDB maintained by the bridge is limited. When the bridge is configured
for IGMP / MLD snooping, a buggy or malicious client can easily exhaust its
capacity. In SW datapath, the capacity is configurable through the
IFLA_BR_MCAST_HASH_MAX parameter, but ultimately is finite. Obviously a
similar limit exists in the HW datapath for purposes of offloading.

In order to prevent the issue of unilateral exhaustion of MDB resources,
introduce two parameters in each of two contexts:

- Per-port and per-port-VLAN number of MDB entries that the port
  is member in.

- Per-port and (when BROPT_MCAST_VLAN_SNOOPING_ENABLED is enabled)
  per-port-VLAN maximum permitted number of MDB entries, or 0 for
  no limit.

The per-port multicast context is used for tracking of MDB entries for the
port as a whole. This is available for all bridges.

The per-port-VLAN multicast context is then only available on
VLAN-filtering bridges on VLANs that have multicast snooping on.

With these changes in place, it will be possible to configure MDB limit for
bridge as a whole, or any one port as a whole, or any single port-VLAN.

Note that unlike the global limit, exhaustion of the per-port and
per-port-VLAN maximums does not cause disablement of multicast snooping.
It is also permitted to configure the local limit larger than hash_max,
even though that is not useful.

In this patch, introduce only the accounting for number of entries, and the
max field itself, but not the means to toggle the max. The next patch
introduces the netlink APIs to toggle and read the values.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    - In br_multicast_port_ngroups_inc_one(), bounce
      if n>=max, not if n==max
    - Adjust extack messages to mention ngroups, now that
      the bounces appear when n>=max, not n==max
    - In __br_multicast_enable_port_ctx(), do not reset
      max to 0. Also do not count number of entries by
      going through _inc, as that would end up incorrectly
      bouncing the entries.

 net/bridge/br_multicast.c | 132 +++++++++++++++++++++++++++++++++++++-
 net/bridge/br_private.h   |   2 +
 2 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 51b622afdb67..e7ae339a8757 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -31,6 +31,7 @@
 #include <net/ip6_checksum.h>
 #include <net/addrconf.h>
 #endif
+#include <trace/events/bridge.h>
 
 #include "br_private.h"
 #include "br_private_mcast_eht.h"
@@ -234,6 +235,29 @@ br_multicast_pg_to_port_ctx(const struct net_bridge_port_group *pg)
 	return pmctx;
 }
 
+static struct net_bridge_mcast_port *
+br_multicast_port_vid_to_port_ctx(struct net_bridge_port *port, u16 vid)
+{
+	struct net_bridge_mcast_port *pmctx = NULL;
+	struct net_bridge_vlan *vlan;
+
+	lockdep_assert_held_once(&port->br->multicast_lock);
+
+	if (!br_opt_get(port->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED))
+		return NULL;
+
+	/* Take RCU to access the vlan. */
+	rcu_read_lock();
+
+	vlan = br_vlan_find(nbp_vlan_group_rcu(port), vid);
+	if (vlan && !br_multicast_port_ctx_vlan_disabled(&vlan->port_mcast_ctx))
+		pmctx = &vlan->port_mcast_ctx;
+
+	rcu_read_unlock();
+
+	return pmctx;
+}
+
 /* when snooping we need to check if the contexts should be used
  * in the following order:
  * - if pmctx is non-NULL (port), check if it should be used
@@ -668,6 +692,82 @@ void br_multicast_del_group_src(struct net_bridge_group_src *src,
 	__br_multicast_del_group_src(src);
 }
 
+static int
+br_multicast_port_ngroups_inc_one(struct net_bridge_mcast_port *pmctx,
+				  struct netlink_ext_ack *extack)
+{
+	if (pmctx->mdb_max_entries &&
+	    pmctx->mdb_n_entries >= pmctx->mdb_max_entries)
+		return -E2BIG;
+
+	pmctx->mdb_n_entries++;
+	return 0;
+}
+
+static void br_multicast_port_ngroups_dec_one(struct net_bridge_mcast_port *pmctx)
+{
+	WARN_ON_ONCE(pmctx->mdb_n_entries-- == 0);
+}
+
+static int br_multicast_port_ngroups_inc(struct net_bridge_port *port,
+					 const struct br_ip *group,
+					 struct netlink_ext_ack *extack)
+{
+	struct net_bridge_mcast_port *pmctx;
+	int err;
+
+	lockdep_assert_held_once(&port->br->multicast_lock);
+
+	/* Always count on the port context. */
+	err = br_multicast_port_ngroups_inc_one(&port->multicast_ctx, extack);
+	if (err) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Port is already in %u groups, and mcast_max_groups=%u",
+				       port->multicast_ctx.mdb_n_entries,
+				       port->multicast_ctx.mdb_max_entries);
+		trace_br_mdb_full(port->dev, group);
+		return err;
+	}
+
+	/* Only count on the VLAN context if VID is given, and if snooping on
+	 * that VLAN is enabled.
+	 */
+	if (!group->vid)
+		return 0;
+
+	pmctx = br_multicast_port_vid_to_port_ctx(port, group->vid);
+	if (!pmctx)
+		return 0;
+
+	err = br_multicast_port_ngroups_inc_one(pmctx, extack);
+	if (err) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Port-VLAN is already in %u groups, and mcast_max_groups=%u",
+				       pmctx->mdb_n_entries,
+				       pmctx->mdb_max_entries);
+		trace_br_mdb_full(port->dev, group);
+		goto dec_one_out;
+	}
+
+	return 0;
+
+dec_one_out:
+	br_multicast_port_ngroups_dec_one(&port->multicast_ctx);
+	return err;
+}
+
+static void br_multicast_port_ngroups_dec(struct net_bridge_port *port, u16 vid)
+{
+	struct net_bridge_mcast_port *pmctx;
+
+	lockdep_assert_held_once(&port->br->multicast_lock);
+
+	if (vid) {
+		pmctx = br_multicast_port_vid_to_port_ctx(port, vid);
+		if (pmctx)
+			br_multicast_port_ngroups_dec_one(pmctx);
+	}
+	br_multicast_port_ngroups_dec_one(&port->multicast_ctx);
+}
+
 static void br_multicast_destroy_port_group(struct net_bridge_mcast_gc *gc)
 {
 	struct net_bridge_port_group *pg;
@@ -702,6 +802,7 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 	} else {
 		br_multicast_star_g_handle_mode(pg, MCAST_INCLUDE);
 	}
+	br_multicast_port_ngroups_dec(pg->key.port, pg->key.addr.vid);
 	hlist_add_head(&pg->mcast_gc.gc_node, &br->mcast_gc_list);
 	queue_work(system_long_wq, &br->mcast_gc_work);
 
@@ -1165,6 +1266,7 @@ struct net_bridge_mdb_entry *br_multicast_new_group(struct net_bridge *br,
 		return mp;
 
 	if (atomic_read(&br->mdb_hash_tbl.nelems) >= br->hash_max) {
+		trace_br_mdb_full(br->dev, group);
 		br_mc_disabled_update(br->dev, false, NULL);
 		br_opt_toggle(br, BROPT_MULTICAST_ENABLED, false);
 		return ERR_PTR(-E2BIG);
@@ -1288,11 +1390,16 @@ struct net_bridge_port_group *br_multicast_new_port_group(
 			struct netlink_ext_ack *extack)
 {
 	struct net_bridge_port_group *p;
+	int err;
+
+	err = br_multicast_port_ngroups_inc(port, group, extack);
+	if (err)
+		return NULL;
 
 	p = kzalloc(sizeof(*p), GFP_ATOMIC);
 	if (unlikely(!p)) {
 		NL_SET_ERR_MSG_MOD(extack, "Couldn't allocate new port group");
-		return NULL;
+		goto dec_out;
 	}
 
 	p->key.addr = *group;
@@ -1326,18 +1433,22 @@ struct net_bridge_port_group *br_multicast_new_port_group(
 
 free_out:
 	kfree(p);
+dec_out:
+	br_multicast_port_ngroups_dec(port, group->vid);
 	return NULL;
 }
 
 void br_multicast_del_port_group(struct net_bridge_port_group *p)
 {
 	struct net_bridge_port *port = p->key.port;
+	__u16 vid = p->key.addr.vid;
 
 	hlist_del_init(&p->mglist);
 	if (!br_multicast_is_star_g(&p->key.addr))
 		rhashtable_remove_fast(&port->br->sg_port_tbl, &p->rhnode,
 				       br_sg_port_rht_params);
 	kfree(p);
+	br_multicast_port_ngroups_dec(port, vid);
 }
 
 void br_multicast_host_join(const struct net_bridge_mcast *brmctx,
@@ -1951,6 +2062,25 @@ static void __br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
 		br_ip4_multicast_add_router(brmctx, pmctx);
 		br_ip6_multicast_add_router(brmctx, pmctx);
 	}
+
+	if (br_multicast_port_ctx_is_vlan(pmctx)) {
+		struct net_bridge_port_group *pg;
+		u32 n = 0;
+
+		/* The mcast_n_groups counter might be wrong. First,
+		 * BR_VLFLAG_MCAST_ENABLED is toggled before temporary entries
+		 * are flushed, thus mcast_n_groups after the toggle does not
+		 * reflect the true values. And second, permanent entries added
+		 * while BR_VLFLAG_MCAST_ENABLED was disabled, are not reflected
+		 * either. Thus we have to refresh the counter.
+		 */
+
+		hlist_for_each_entry(pg, &pmctx->port->mglist, mglist) {
+			if (pg->key.addr.vid == pmctx->vlan->vid)
+				n++;
+		}
+		pmctx->mdb_n_entries = n;
+	}
 }
 
 void br_multicast_enable_port(struct net_bridge_port *port)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index e4069e27b5c6..49f411a0a1f1 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -126,6 +126,8 @@ struct net_bridge_mcast_port {
 	struct hlist_node		ip6_rlist;
 #endif /* IS_ENABLED(CONFIG_IPV6) */
 	unsigned char			multicast_router;
+	u32				mdb_n_entries;
+	u32				mdb_max_entries;
 #endif /* CONFIG_BRIDGE_IGMP_SNOOPING */
 };
 
-- 
2.39.0

