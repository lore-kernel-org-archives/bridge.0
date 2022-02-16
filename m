Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=sO7CNG0sSQG2qIDEEmS29gE5qWYIsAYkV+SmsMaOSJ4=;
 b=gOrriYj16c35aVCnfYWpRbk0Atd6fYsrMATkiD1ZUM2tcGyId/6rTmembEUOmPLJSt
 gYijA3m/cbaLv75Kj/xyi/3f2Q7QHz96y0zSfBlh4uPonHh+xibUVzAMwPEL6+fhG2AH
 ftAolTsPvTIDoCuNzUzo6W3B3+BAFCyL9ERaqw/WsOwOdlMHiDErnfbSL7oTtmDBmAyj
 oJxh/5dbwEEgXqQuLGtCO3UwBt3jvfHB66SzfHwCPhIYrvatLaSrPCU5unZzssKxe80Y
 NQjwDtsDSqD4ZMOprRF+nJtsB13dFQ54jUCWS+wUh2gHHgRoQb6NpjO8g1+v4MHrT9HX
 4G8Q==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Wed, 16 Feb 2022 14:29:31 +0100
Message-Id: <20220216132934.1775649-7-tobias@waldekranz.com>
In-Reply-To: <20220216132934.1775649-1-tobias@waldekranz.com>
References: <20220216132934.1775649-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC net-next 6/9] net: dsa: Pass MST state changes to
	driver
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
to the drivers for MST state changes.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/dsa.h  |  2 ++
 net/dsa/dsa_priv.h |  2 ++
 net/dsa/port.c     | 30 ++++++++++++++++++++++++++++++
 net/dsa/slave.c    |  6 ++++++
 4 files changed, 40 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 2aabe7f0b176..f030afb68f46 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -882,6 +882,8 @@ struct dsa_switch_ops {
 				     struct dsa_bridge bridge);
 	void	(*port_stp_state_set)(struct dsa_switch *ds, int port,
 				      u8 state);
+	int	(*port_mst_state_set)(struct dsa_switch *ds, int port,
+				      const struct switchdev_mst_state *state);
 	void	(*port_fast_age)(struct dsa_switch *ds, int port);
 	int	(*port_pre_bridge_flags)(struct dsa_switch *ds, int port,
 					 struct switchdev_brport_flags flags,
diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 43709c005461..96d09184de5d 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -185,6 +185,8 @@ static inline struct net_device *dsa_master_find_slave(struct net_device *dev,
 void dsa_port_set_tag_protocol(struct dsa_port *cpu_dp,
 			       const struct dsa_device_ops *tag_ops);
 int dsa_port_set_state(struct dsa_port *dp, u8 state, bool do_fast_age);
+int dsa_port_set_mst_state(struct dsa_port *dp,
+			   const struct switchdev_mst_state *state);
 int dsa_port_enable_rt(struct dsa_port *dp, struct phy_device *phy);
 int dsa_port_enable(struct dsa_port *dp, struct phy_device *phy);
 void dsa_port_disable_rt(struct dsa_port *dp);
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 4fb2bf2383d9..a34779658f17 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -108,6 +108,36 @@ int dsa_port_set_state(struct dsa_port *dp, u8 state, bool do_fast_age)
 	return 0;
 }
 
+int dsa_port_set_mst_state(struct dsa_port *dp,
+			   const struct switchdev_mst_state *state)
+{
+	struct dsa_switch *ds = dp->ds;
+	int err, port = dp->index;
+
+	if (!ds->ops->port_mst_state_set)
+		return -EOPNOTSUPP;
+
+	err = ds->ops->port_mst_state_set(ds, port, state);
+	if (err)
+		return err;
+
+	if (!dsa_port_can_configure_learning(dp) || dp->learning) {
+		switch (state->state) {
+		case BR_STATE_DISABLED:
+		case BR_STATE_BLOCKING:
+		case BR_STATE_LISTENING:
+			/* Ideally we would only fast age entries
+			 * belonging to VLANs controlled by this
+			 * MST.
+			 */
+			dsa_port_fast_age(dp);
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static void dsa_port_set_state_now(struct dsa_port *dp, u8 state,
 				   bool do_fast_age)
 {
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 0a5e44105add..48075d697588 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -288,6 +288,12 @@ static int dsa_slave_port_attr_set(struct net_device *dev, const void *ctx,
 
 		ret = dsa_port_set_state(dp, attr->u.stp_state, true);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_MST_STATE:
+		if (!dsa_port_offloads_bridge_port(dp, attr->orig_dev))
+			return -EOPNOTSUPP;
+
+		ret = dsa_port_set_mst_state(dp, &attr->u.mst_state);
+		break;
 	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
 		if (!dsa_port_offloads_bridge_dev(dp, attr->orig_dev))
 			return -EOPNOTSUPP;
-- 
2.25.1

