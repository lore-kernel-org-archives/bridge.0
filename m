Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=V1eQh2z2Mp1dVqtDPqG/YccGeTfz3qSetOtmZo+4lcI=;
 b=4Z9spyZJh7I6GdzYp1fUuY70ylRefnQynE2afvnnLFa/c9ru744iYsrV7GcIN6GCIr
 azVyPHTH8XsrmRbOF/9lSx5VTcSZAfTlNk0LmtMdOvUycpITjHKdm01opJv6+j3Yz5Ro
 c/ztRs1SefZd5LUk5cDjkz1Vq+TR6PsWDvLGVHZhnLPP8axeyShWStroQAlIxab7MZp1
 UwS+th+DXfSoDOp92F7yzPH6Xv/F71AhcnEd0lepnoZ5ry01Sf1xg95Y1uTY779/YcvD
 vMgLZV5svdBdcAST0pvnBH6TS1vD0+BOGrVJg6VUSR9cMTYLcbrkYGzHSYtxN3geykH+
 V/6g==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Wed, 16 Feb 2022 14:29:30 +0100
Message-Id: <20220216132934.1775649-6-tobias@waldekranz.com>
In-Reply-To: <20220216132934.1775649-1-tobias@waldekranz.com>
References: <20220216132934.1775649-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC net-next 5/9] net: dsa: Pass VLAN MST migration
	notifications to driver
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

Add the usual trampoline functionality from the generic DSA layer down
to the drivers for VLAN MST migrations.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/dsa.h    |  3 +++
 net/bridge/br_vlan.c |  2 +-
 net/dsa/dsa_priv.h   |  1 +
 net/dsa/port.c       | 10 ++++++++++
 net/dsa/slave.c      |  6 ++++++
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index fd1f62a6e0a8..2aabe7f0b176 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -901,6 +901,9 @@ struct dsa_switch_ops {
 				 struct netlink_ext_ack *extack);
 	int	(*port_vlan_del)(struct dsa_switch *ds, int port,
 				 const struct switchdev_obj_port_vlan *vlan);
+	int	(*vlan_mstid_set)(struct dsa_switch *ds,
+				  const struct switchdev_attr *attr);
+
 	/*
 	 * Forwarding database
 	 */
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index c45a34c14e10..48b2f5dd277c 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -173,7 +173,7 @@ static int br_vlan_mst_migrate(struct net_bridge_vlan *v, u16 mstid)
 	old_mst = rtnl_dereference(v->mst);
 	rcu_assign_pointer(v->mst, mst);
 
-	if (br_vlan_is_master(v)) {
+	if (!old_mst || br_vlan_is_master(v)) {
 		struct switchdev_attr attr = {
 			.id = SWITCHDEV_ATTR_ID_VLAN_MSTID,
 			.flags = SWITCHDEV_F_DEFER,
diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 2bbfa9efe9f8..43709c005461 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -204,6 +204,7 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 			    struct netlink_ext_ack *extack);
 bool dsa_port_skip_vlan_configuration(struct dsa_port *dp);
 int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock);
+int dsa_port_vlan_mstid(struct dsa_port *dp, const struct switchdev_attr *attr);
 int dsa_port_mtu_change(struct dsa_port *dp, int new_mtu,
 			bool targeted_match);
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index bd78192e0e47..4fb2bf2383d9 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -729,6 +729,16 @@ int dsa_port_bridge_flags(struct dsa_port *dp,
 	return 0;
 }
 
+int dsa_port_vlan_mstid(struct dsa_port *dp, const struct switchdev_attr *attr)
+{
+	struct dsa_switch *ds = dp->ds;
+
+	if (!ds->ops->vlan_mstid_set)
+		return -EOPNOTSUPP;
+
+	return ds->ops->vlan_mstid_set(ds, attr);
+}
+
 int dsa_port_mtu_change(struct dsa_port *dp, int new_mtu,
 			bool targeted_match)
 {
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 2f6caf5d037e..0a5e44105add 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -314,6 +314,12 @@ static int dsa_slave_port_attr_set(struct net_device *dev, const void *ctx,
 
 		ret = dsa_port_bridge_flags(dp, attr->u.brport_flags, extack);
 		break;
+	case SWITCHDEV_ATTR_ID_VLAN_MSTID:
+		if (!dsa_port_offloads_bridge_dev(dp, attr->orig_dev))
+			return -EOPNOTSUPP;
+
+		ret = dsa_port_vlan_mstid(dp, attr);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
-- 
2.25.1

