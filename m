Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8FyuAvBiOLT1wV9WHhK/m2gvVYQtuLBYVGqY8Uxksmo=;
 b=EjDqlKOF5HwpEw9EuAQ4zs1FSd+tFqypUe8j7gfOGPO9vUtjLNScY29DOU7aeAyvlg
 iCjETv/Bc1EqraU1poY7pS4VJXZHAMVwOlmVw7+VpqLjL84f0S5NdBMs8LGxQ/egpMGe
 aEDFc8KCAmpaaMMtPXhKR6YjkxSocn/EoOIL7wjBxMd3nrbks6Im+5aRBvhgQVXpc1ht
 HOvny39mbZkw5OWSgLCvha0awcTr7c7fPn1IVOkCw7lfAKUZxu6vobytWqohHkXvWygR
 Z7aIn1oqYrh2RXldwuJAvZZd3H03DGJcCHSLv6U73xvhhYVj+OOWbabhcxwxa/2tS/8l
 hEcw==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue,  9 Feb 2021 17:19:29 +0200
Message-Id: <20210209151936.97382-5-olteanv@gmail.com>
In-Reply-To: <20210209151936.97382-1-olteanv@gmail.com>
References: <20210209151936.97382-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v2 net-next 04/11] net: bridge: offload initial and
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
Changes in v2:
- Renamed nbp_flags_change to nbp_flags_notify.
- Don't return any errors, offload flags one by one as opposed to all at
  once.

 include/linux/if_bridge.h |  3 +++
 net/bridge/br_if.c        | 21 ++++++++++++++++++++-
 net/bridge/br_switchdev.c |  3 +--
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index b979005ea39c..36d77fa8f40b 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -58,6 +58,9 @@ struct br_ip_list {
 #define BR_MRP_LOST_CONT	BIT(18)
 #define BR_MRP_LOST_IN_CONT	BIT(19)
 
+#define BR_PORT_DEFAULT_FLAGS	(BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD | \
+				 BR_LEARNING)
+
 #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
 
 extern void brioctl_set(int (*ioctl_hook)(struct net *, unsigned int, void __user *));
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index f7d2f472ae24..f813eec986ba 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -89,6 +89,23 @@ void br_port_carrier_check(struct net_bridge_port *p, bool *notified)
 	spin_unlock_bh(&br->lock);
 }
 
+/* If @mask has multiple bits set at once, offload them one by one to
+ * switchdev, to allow it to reject only what it doesn't support and accept
+ * what it does.
+ */
+static void nbp_flags_notify(struct net_bridge_port *p, unsigned long flags,
+			     unsigned long mask)
+{
+	int flag;
+
+	for_each_set_bit(flag, &mask, 32)
+		br_switchdev_set_port_flag(p, flags & BIT(flag),
+					   BIT(flag), NULL);
+
+	p->flags &= ~mask;
+	p->flags |= flags;
+}
+
 static void br_port_set_promisc(struct net_bridge_port *p)
 {
 	int err = 0;
@@ -343,6 +360,8 @@ static void del_nbp(struct net_bridge_port *p)
 		update_headroom(br, get_max_headroom(br));
 	netdev_reset_rx_headroom(dev);
 
+	nbp_flags_notify(p, BR_PORT_DEFAULT_FLAGS & ~BR_LEARNING,
+			 BR_PORT_DEFAULT_FLAGS);
 	nbp_vlan_flush(p);
 	br_fdb_delete_by_port(br, p, 0, 1);
 	switchdev_deferred_process();
@@ -428,7 +447,7 @@ static struct net_bridge_port *new_nbp(struct net_bridge *br,
 	p->path_cost = port_cost(dev);
 	p->priority = 0x8000 >> BR_PORT_BITS;
 	p->port_no = index;
-	p->flags = BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD;
+	nbp_flags_notify(p, BR_PORT_DEFAULT_FLAGS, BR_PORT_DEFAULT_FLAGS);
 	br_init_port(p);
 	br_set_state(p, BR_STATE_DISABLED);
 	br_stp_port_timer_init(p);
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index ac8dead86bf2..1fae532cfbb1 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -55,8 +55,7 @@ bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
 }
 
 /* Flags that can be offloaded to hardware */
-#define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | \
-				  BR_MCAST_FLOOD | BR_BCAST_FLOOD)
+#define BR_PORT_FLAGS_HW_OFFLOAD	BR_PORT_DEFAULT_FLAGS
 
 int br_switchdev_set_port_flag(struct net_bridge_port *p,
 			       unsigned long flags,
-- 
2.25.1

