Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=G7oQe2cpTDpisPCmbwC7oQE+H3DLD/kOIxG11vmN0kE=;
 b=AWIOUkmA5DjJERUOTnY8KYJSVBNhBmn10maOhYm7Zi5sCALL2TIJzVv5C8ji7X+f7J
 n+QCz18Kt0u2U7lc+kdMld4egNuEPSzVMg0yIxBSQ4YBFYnQ2U6T/X5eFsZvhJXIHGIz
 psJBtt0oYRTGzbSOA8NGuTgpR/j3jawr2q37s+15L65O95Ce6PIiGUfPepqB+68/Pf5Q
 sg0p6aM9m9AswDVEtQwfT1FOJJ7wNYSZ2BwMdd/ptkq0DO6d2CilHPOTLhBj+5ztY9ol
 3uONDBxqpVTfLhvJdTGJOagpeBbowAPxz25cFjdmH+Es46gGIqPmGzpslzU+j8pgp3PS
 0+BQ==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Tue, 15 Mar 2022 01:25:38 +0100
Message-Id: <20220315002543.190587-11-tobias@waldekranz.com>
In-Reply-To: <20220315002543.190587-1-tobias@waldekranz.com>
References: <20220315002543.190587-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v4 net-next 10/15] net: dsa: Validate hardware
	support for MST
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

When joining a bridge where MST is enabled, we validate that the
proper offloading support is in place, otherwise we fallback to
software bridging.

When then mode is changed on a bridge in which we are members, we
refuse the change if offloading is not supported.

At the moment we only check for configurable learning, but this will
be further restricted as we support more MST related switchdev events.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 net/dsa/dsa_priv.h |  2 ++
 net/dsa/port.c     | 22 ++++++++++++++++++++++
 net/dsa/slave.c    |  6 ++++++
 3 files changed, 30 insertions(+)

diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index f20bdd8ea0a8..2aba420696ef 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -234,6 +234,8 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 			    struct netlink_ext_ack *extack);
 bool dsa_port_skip_vlan_configuration(struct dsa_port *dp);
 int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock);
+int dsa_port_mst_enable(struct dsa_port *dp, bool on,
+			struct netlink_ext_ack *extack);
 int dsa_port_mtu_change(struct dsa_port *dp, int new_mtu,
 			bool targeted_match);
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 58291df14cdb..02214033cec0 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -321,6 +321,11 @@ static void dsa_port_bridge_destroy(struct dsa_port *dp,
 	kfree(bridge);
 }
 
+static bool dsa_port_supports_mst(struct dsa_port *dp)
+{
+	return dsa_port_can_configure_learning(dp);
+}
+
 int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 			 struct netlink_ext_ack *extack)
 {
@@ -334,6 +339,9 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 	struct net_device *brport_dev;
 	int err;
 
+	if (br_mst_enabled(br) && !dsa_port_supports_mst(dp))
+		return -EOPNOTSUPP;
+
 	/* Here the interface is already bridged. Reflect the current
 	 * configuration so that drivers can program their chips accordingly.
 	 */
@@ -735,6 +743,20 @@ int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock)
 	return 0;
 }
 
+int dsa_port_mst_enable(struct dsa_port *dp, bool on,
+			struct netlink_ext_ack *extack)
+{
+	if (!on)
+		return 0;
+
+	if (!dsa_port_supports_mst(dp)) {
+		NL_SET_ERR_MSG_MOD(extack, "Hardware does not support MST");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int dsa_port_pre_bridge_flags(const struct dsa_port *dp,
 			      struct switchdev_brport_flags flags,
 			      struct netlink_ext_ack *extack)
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 647adee97f7f..879d18cc99cb 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -463,6 +463,12 @@ static int dsa_slave_port_attr_set(struct net_device *dev, const void *ctx,
 
 		ret = dsa_port_ageing_time(dp, attr->u.ageing_time);
 		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_MST:
+		if (!dsa_port_offloads_bridge_dev(dp, attr->orig_dev))
+			return -EOPNOTSUPP;
+
+		ret = dsa_port_mst_enable(dp, attr->u.mst, extack);
+		break;
 	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
 		if (!dsa_port_offloads_bridge_port(dp, attr->orig_dev))
 			return -EOPNOTSUPP;
-- 
2.25.1

