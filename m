Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l2f8wSd2cFUSrpRoYeQ6oFo0IF2ypfibcU91DvCPZco=;
 b=wgmz7k/s54dbcXvrb+4rMBZQwTgHvK9EAWb8El5VRb4pA+H1C/njj2yPqKsVbkoDyq
 hb1QLfyM7pmQ4/LafPsodQpBu6ZS7Du86JZVHtcYDWCYpwXVHhlmE7augpY7WVW3XoNS
 uTZOVTmpp6BxA1p7n7amNMxqNBTlWYzSjr2y58XH4fpdUpZm9pjqmw5gumYK3EBmluLF
 nnbrqlvCU0ifK5hDRL9uT2tOQgx5vHbDIDUYqmzfOhGhQLPSGkl08MRIpQWQjlReK4P8
 8x2/CXBwbe0rN/FV4c0WmDwtS38M2Ub6GE1JI6yQDoH1TX7SgTPwMnEP5617q8it6mBb
 C78g==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 19 Jul 2021 20:06:29 +0300
Message-Id: <20210719170637.435541-8-razor@blackwall.org>
In-Reply-To: <20210719170637.435541-1-razor@blackwall.org>
References: <20210719170637.435541-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 07/15] net: bridge: multicast: add helper
	to get port mcast context from port group
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Add br_multicast_pg_to_port_ctx() which returns the proper port multicast
context from either port or vlan based on bridge option and vlan flags.
As the comment inside explains the locking is a bit tricky, we rely on
the fact that BR_VLFLAG_MCAST_ENABLED requires multicast_lock to change
and we also require it to be held to call that helper. If we find the
vlan under rcu and it still has the flag then we can be sure it will be
alive until we unlock multicast_lock which should be enough.
Note that the context might change from vlan to bridge between different
calls to this helper as the mcast vlan knob requires only rtnl so it should
be used carefully and for read-only/check purposes.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index b71772828b23..353406f2971a 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -192,6 +192,44 @@ struct net_bridge_mdb_entry *br_mdb_get(struct net_bridge_mcast *brmctx,
 	return br_mdb_ip_get_rcu(br, &ip);
 }
 
+/* IMPORTANT: this function must be used only when the contexts cannot be
+ * passed down (e.g. timer) and must be used for read-only purposes because
+ * the vlan snooping option can change, so it can return any context
+ * (non-vlan or vlan). Its initial intended purpose is to read timer values
+ * from the *current* context based on the option. At worst that could lead
+ * to inconsistent timers when the contexts are changed, i.e. src timer
+ * which needs to re-arm with a specific delay taken from the old context
+ */
+static struct net_bridge_mcast_port *
+br_multicast_pg_to_port_ctx(const struct net_bridge_port_group *pg)
+{
+	struct net_bridge_mcast_port *pmctx = &pg->key.port->multicast_ctx;
+	struct net_bridge_vlan *vlan;
+
+	lockdep_assert_held_once(&pg->key.port->br->multicast_lock);
+
+	/* if vlan snooping is disabled use the port's multicast context */
+	if (!pg->key.addr.vid ||
+	    !br_opt_get(pg->key.port->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED))
+		goto out;
+
+	/* locking is tricky here, due to different rules for multicast and
+	 * vlans we need to take rcu to find the vlan and make sure it has
+	 * the BR_VLFLAG_MCAST_ENABLED flag set, it can only change under
+	 * multicast_lock which must be already held here, so the vlan's pmctx
+	 * can safely be used on return
+	 */
+	rcu_read_lock();
+	vlan = br_vlan_find(nbp_vlan_group(pg->key.port), pg->key.addr.vid);
+	if (vlan && !br_multicast_port_ctx_vlan_disabled(&vlan->port_mcast_ctx))
+		pmctx = &vlan->port_mcast_ctx;
+	else
+		pmctx = NULL;
+	rcu_read_unlock();
+out:
+	return pmctx;
+}
+
 static bool br_port_group_equal(struct net_bridge_port_group *p,
 				struct net_bridge_port *port,
 				const unsigned char *src)
-- 
2.31.1

