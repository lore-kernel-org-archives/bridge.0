Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aF26U34aBL8K6bVtwaJCBU2DkCwMTfcd91sYoywprTY=;
 b=WCKQ+LtKE/UOlQrWFxrHn28+qeGzJlG6joOQzDOEXxMuc52/bvbwwIWCJfpSdEnemZ
 i9+ZCibdt0/ARIwOmkJfNQQx3wjQfdNwdri68i5YfKJC57taNHzwEPJoLse0GkTvHUBu
 d3oCV0gH5620B/1/yyQ4yYuEUQNqbhWqbJClWRwEJJRbT06RhSnIMfyV06exk1J9ZNrb
 Q64okac0fkO1ek5M9R7yG/XL04bchQfjJxOIQzLwwxD3ZPcwLvU0H4pEWMwA6HAWRpT2
 yRVark7GGOD3fhXGEPbP7xu6nHE/k6LJijyA0s/cg4QhLuCl+evXa7iYZk4tLFOupnen
 81KQ==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Wed, 10 Feb 2021 11:14:42 +0200
Message-Id: <20210210091445.741269-9-olteanv@gmail.com>
In-Reply-To: <20210210091445.741269-1-olteanv@gmail.com>
References: <20210210091445.741269-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v3 net-next 08/11] net: bridge: put
	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS on the blocking call chain
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Since we would like br_switchdev_set_port_flag to not use an atomic
notifier, it should be called from outside spinlock context.

We can temporarily drop br->lock, but that creates some concurrency
complications (example below is given for sysfs):
- There might be an "echo 1 > multicast_flood" simultaneous with an
  "echo 0 > multicast_flood". The result of this is nondeterministic
  either way, so I'm not too concerned as long as the result is
  consistent (no other flags have changed).
- There might be an "echo 1 > multicast_flood" simultaneous with an
  "echo 0 > learning". My expectation is that none of the two writes are
  "eaten", and the final flags contain BR_MCAST_FLOOD=1 and BR_LEARNING=0
  regardless of the order of execution. That is actually possible if, on
  the commit path, we don't do a trivial "p->flags = flags" which might
  overwrite bits outside of our mask, but instead we just change the
  flags corresponding to our mask.

Now that br_switchdev_set_port_flag is never called from under br->lock,
it runs in sleepable context.

All switchdev drivers handle SWITCHDEV_PORT_ATTR_SET as both blocking
and atomic, so no changes are needed on that front.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v3:
- Drop the br->lock around br_switchdev_set_port_flag in this patch, for
  both sysfs and netlink.
- Only set/restore the masked bits in p->flags to avoid concurrency
  issues.

Changes in v2:
Patch is new.

 net/bridge/br_netlink.c   | 10 +++++++---
 net/bridge/br_switchdev.c |  5 ++---
 net/bridge/br_sysfs_if.c  | 22 ++++++++++++++--------
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index b7731614c036..8f09106966c4 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -869,7 +869,7 @@ static void br_set_port_flag(struct net_bridge_port *p, struct nlattr *tb[],
 static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 		      struct netlink_ext_ack *extack)
 {
-	unsigned long old_flags, changed_mask;
+	unsigned long flags, old_flags, changed_mask;
 	bool br_vlan_tunnel_old;
 	int err;
 
@@ -896,10 +896,14 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 	br_set_port_flag(p, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
 
 	changed_mask = old_flags ^ p->flags;
+	flags = p->flags;
 
-	err = br_switchdev_set_port_flag(p, p->flags, changed_mask, extack);
+	spin_unlock_bh(&p->br->lock);
+	err = br_switchdev_set_port_flag(p, flags, changed_mask, extack);
+	spin_lock_bh(&p->br->lock);
 	if (err) {
-		p->flags = old_flags;
+		p->flags &= ~changed_mask;
+		p->flags |= (old_flags & changed_mask);
 		goto out;
 	}
 
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index dbd94156960f..a79164ee65b9 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -79,9 +79,8 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 	attr.u.brport_flags.val = flags & mask;
 	attr.u.brport_flags.mask = mask;
 
-	/* We run from atomic context here */
-	err = call_switchdev_notifiers(SWITCHDEV_PORT_ATTR_SET, p->dev,
-				       &info.info, extack);
+	err = call_switchdev_blocking_notifiers(SWITCHDEV_PORT_ATTR_SET, p->dev,
+						&info.info, extack);
 	err = notifier_to_errno(err);
 	if (err == -EOPNOTSUPP)
 		return 0;
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 72e92376eef1..3f21fdd1cdaa 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -68,16 +68,22 @@ static int store_flag(struct net_bridge_port *p, unsigned long v,
 	else
 		flags &= ~mask;
 
-	if (flags != p->flags) {
-		err = br_switchdev_set_port_flag(p, flags, mask, &extack);
-		if (err) {
-			netdev_err(p->dev, "%s\n", extack._msg);
-			return err;
-		}
+	if (flags == p->flags)
+		return 0;
 
-		p->flags = flags;
-		br_port_flags_change(p, mask);
+	spin_unlock_bh(&p->br->lock);
+	err = br_switchdev_set_port_flag(p, flags, mask, &extack);
+	spin_lock_bh(&p->br->lock);
+	if (err) {
+		netdev_err(p->dev, "%s\n", extack._msg);
+		return err;
 	}
+
+	p->flags &= ~mask;
+	p->flags |= (flags & mask);
+
+	br_port_flags_change(p, mask);
+
 	return 0;
 }
 
-- 
2.25.1

