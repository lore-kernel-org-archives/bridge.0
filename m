Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=akWzYrIA0f7A74GU4gqxjh8xdXZeuUVFKu3EYBQU0u8=;
 b=5WCup1a1iZIhs6zKsDXNRtYiF+OmuSJenUiuhmrGMbgRY2VLwJEBUpkIv4WJZavNsG
 Li67VLDKgBwFlZAuviq670EL7VcNtfKUKkX44EYzda+3gd1yVkxcExaN+6F/yhPpmJHN
 vaEkjBUdAal3Uu/zxHVjZpqKA4gLOdYaz3bFDXPEr6uU5+405HHkzE4GB4omBcdKUPMR
 uA10X0CygKXZFgOFCIy5Jrm40jdf//jSpuMWLMXsEpb6Dvv41iM3bnfiL3R3LFsYcDtA
 gPrPy7pC6uKk+y1pj4Vs4N+SXANsU89aeiPDVnA5WXyPPfeBAu/42HZ5WTnhLXdvC2ai
 sZDw==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Wed, 16 Mar 2022 16:08:52 +0100
Message-Id: <20220316150857.2442916-11-tobias@waldekranz.com>
In-Reply-To: <20220316150857.2442916-1-tobias@waldekranz.com>
References: <20220316150857.2442916-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v5 net-next 10/15] net: dsa: Validate hardware
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
index f9cecda791d5..2e8f62476ce9 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -464,6 +464,12 @@ static int dsa_slave_port_attr_set(struct net_device *dev, const void *ctx,
 
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

