Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6V55UnxJUNtfF6mxxNh3yKhc1dFJ3yj+qa4nTLp6jtE=;
 b=DPRbClDr7Vg+0mguADIfQHBYikc2VIF/iM9jM1UCG+tDLOMb14ohD6ddMzvpiWH6E+
 e3PuoUs0X8dmbHkNJEa+LpbU8LB7BYinlyk6jRSyDV5G3SCNyzqkcn1hCgosQwn0hN/M
 MShwLFFPiEXvVcai0LX5TmQZ9Xpr2mcTU+b4xGd4xpQwlUQFXd8pLktm/NSpaTsp3T6e
 RxHuhW6uy4eRxUt0IIVUNdGc6FlQY042PsLa1fB2zWO+Oj5Bi9rdHWb9juts3Lo4yA+M
 0LwOSZY0XxvXMvfP0XAJ+phaYAsHekZR1AwrikpYsQXv3nblfAm5YEnTRGE/ZdnipA0N
 OtsA==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Mon,  8 Feb 2021 01:21:34 +0200
Message-Id: <20210207232141.2142678-3-olteanv@gmail.com>
In-Reply-To: <20210207232141.2142678-1-olteanv@gmail.com>
References: <20210207232141.2142678-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 2/9] net: bridge: offload initial and
	final port flags through switchdev
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

It must first be admitted that switchdev device drivers have a life
beyond the bridge, and when they aren't offloading the bridge driver
they are operating with forwarding disabled between ports, emulating as
closely as possible N standalone network interfaces.

Now it must be said that for a switchdev port operating in standalone
mode, address learning doesn't make much sense since that is a bridge
function. In fact, address learning even breaks setups such as this one:

   +---------------------------------------------+
   |                                             |
   | +-------------------+                       |
   | |        br0        |    send      receive  |
   | +--------+-+--------+ +--------+ +--------+ |
   | |        | |        | |        | |        | |
   | |  swp0  | |  swp1  | |  swp2  | |  swp3  | |
   | |        | |        | |        | |        | |
   +-+--------+-+--------+-+--------+-+--------+-+
          |         ^           |          ^
          |         |           |          |
          |         +-----------+          |
          |                                |
          +--------------------------------+

because if the ASIC has a single FDB (can offload a single bridge)
then source address learning on swp3 can "steal" the source MAC address
of swp2 from br0's FDB, because learning frames coming from swp2 will be
done twice: first on the swp1 ingress port, second on the swp3 ingress
port. So the hardware FDB will become out of sync with the software
bridge, and when swp2 tries to send one more packet towards swp1, the
ASIC will attempt to short-circuit the forwarding path and send it
directly to swp3 (since that's the last port it learned that address on),
which it obviously can't, because swp3 operates in standalone mode.

So switchdev drivers operating in standalone mode should disable address
learning. As a matter of practicality, we can reduce code duplication in
drivers by having the bridge notify through switchdev of the initial and
final brport flags. Then, drivers can simply start up hardcoded for no
address learning (similar to how they already start up hardcoded for no
forwarding), then they only need to listen for
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS and their job is basically done, no
need for special cases when the port joins or leaves the bridge etc.

When a port leaves the bridge (and therefore becomes standalone), we
issue a switchdev attribute that apart from disabling address learning,
enables flooding of all kinds. This is also done for pragmatic reasons,
because even though standalone switchdev ports might not need to have
flooding enabled in order to inject traffic with any MAC DA from the
control interface, it certainly doesn't hurt either, and it even makes
more sense than disabling flooding of unknown traffic towards that port.

Note that the implementation is a bit wacky because the switchdev API
for port attributes is very counterproductive. Instead of issuing a
single switchdev notification with a bitwise OR of all flags that we're
modifying, we need to issue 4 individual notifications, one for each bit.
This is because the SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS notifier
forces you to refuse the entire operation if there's at least one bit
which you can't offload, and that is currently BR_BCAST_FLOOD which
nobody does. So this change would do nothing for no one if we offloaded
all flags at once, but the idea is to offload as much as possible
instead of all or nothing.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/bridge/br_if.c      | 24 +++++++++++++++++++++++-
 net/bridge/br_netlink.c | 16 ++++------------
 net/bridge/br_private.h |  2 ++
 3 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index f7d2f472ae24..8903333654f0 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -89,6 +89,21 @@ void br_port_carrier_check(struct net_bridge_port *p, bool *notified)
 	spin_unlock_bh(&br->lock);
 }
 
+int nbp_flags_change(struct net_bridge_port *p, unsigned long flags,
+		     unsigned long mask, struct netlink_ext_ack *extack)
+{
+	int err;
+
+	err = br_switchdev_set_port_flag(p, flags, mask, extack);
+	if (err)
+		return err;
+
+	p->flags &= ~mask;
+	p->flags |= flags;
+
+	return 0;
+}
+
 static void br_port_set_promisc(struct net_bridge_port *p)
 {
 	int err = 0;
@@ -343,6 +358,10 @@ static void del_nbp(struct net_bridge_port *p)
 		update_headroom(br, get_max_headroom(br));
 	netdev_reset_rx_headroom(dev);
 
+	nbp_flags_change(p, 0, BR_LEARNING, NULL);
+	nbp_flags_change(p, BR_FLOOD, BR_FLOOD, NULL);
+	nbp_flags_change(p, BR_MCAST_FLOOD, BR_MCAST_FLOOD, NULL);
+	nbp_flags_change(p, BR_BCAST_FLOOD, BR_BCAST_FLOOD, NULL);
 	nbp_vlan_flush(p);
 	br_fdb_delete_by_port(br, p, 0, 1);
 	switchdev_deferred_process();
@@ -428,7 +447,10 @@ static struct net_bridge_port *new_nbp(struct net_bridge *br,
 	p->path_cost = port_cost(dev);
 	p->priority = 0x8000 >> BR_PORT_BITS;
 	p->port_no = index;
-	p->flags = BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD;
+	nbp_flags_change(p, BR_LEARNING, BR_LEARNING, NULL);
+	nbp_flags_change(p, BR_FLOOD, BR_FLOOD, NULL);
+	nbp_flags_change(p, BR_MCAST_FLOOD, BR_MCAST_FLOOD, NULL);
+	nbp_flags_change(p, BR_BCAST_FLOOD, BR_BCAST_FLOOD, NULL);
 	br_init_port(p);
 	br_set_state(p, BR_STATE_DISABLED);
 	br_stp_port_timer_init(p);
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 02aa95c08b77..ab54d1daa9b4 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -852,28 +852,20 @@ static int br_set_port_state(struct net_bridge_port *p, u8 state)
 	return 0;
 }
 
-/* Set/clear or port flags based on attribute */
+/* Set/clear or port flags based on netlink attribute */
 static int br_set_port_flag(struct net_bridge_port *p, struct nlattr *tb[],
 			    int attrtype, unsigned long mask,
 			    struct netlink_ext_ack *extack)
 {
-	unsigned long flags;
-	int err;
+	unsigned long flags = 0;
 
 	if (!tb[attrtype])
 		return 0;
 
 	if (nla_get_u8(tb[attrtype]))
-		flags = p->flags | mask;
-	else
-		flags = p->flags & ~mask;
-
-	err = br_switchdev_set_port_flag(p, flags, mask, extack);
-	if (err)
-		return err;
+		flags = mask;
 
-	p->flags = flags;
-	return 0;
+	return nbp_flags_change(p, flags, mask, extack);
 }
 
 /* Process bridge protocol info on port */
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index a1639d41188b..f064abd86bdf 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -749,6 +749,8 @@ netdev_features_t br_features_recompute(struct net_bridge *br,
 void br_port_flags_change(struct net_bridge_port *port, unsigned long mask);
 void br_manage_promisc(struct net_bridge *br);
 int nbp_backup_change(struct net_bridge_port *p, struct net_device *backup_dev);
+int nbp_flags_change(struct net_bridge_port *p, unsigned long flags,
+		     unsigned long mask, struct netlink_ext_ack *extack);
 
 /* br_input.c */
 int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb);
-- 
2.25.1

