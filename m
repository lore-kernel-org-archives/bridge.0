Return-Path: <igor.mitsyanko.os@quantenna.com>
From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Date: Fri,  9 Mar 2018 19:03:04 -0800
Message-Id: <20180310030308.12947-2-igor.mitsyanko.os@quantenna.com>
In-Reply-To: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
References: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
Subject: [Bridge] [PATCH net-next 1/5] bridge: initialize port flags with
	switchdev defaults
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: ivecera@redhat.com, igor.mitsyanko.os@quantenna.com, jiri@resnulli.us, sergey.matyukevich.os@quantenna.com, ashevchenko@quantenna.com, smaksimenko@quantenna.com, dlebed@quantenna.com

Default bridge port flags for switchdev devices can be different from
what is used in bridging core. Get default value from switchdev itself
on port initialization.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 net/bridge/br_if.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 9ba4ed6..d658b55 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -342,6 +342,21 @@ static int find_portno(struct net_bridge *br)
 	return (index >= BR_MAX_PORTS) ? -EXFULL : index;
 }
 
+static unsigned long nbp_flags_get_default(struct net_device *dev)
+{
+	struct switchdev_attr attr = {
+		.orig_dev = dev,
+		.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
+	};
+	int ret;
+
+	ret = switchdev_port_attr_get(dev, &attr);
+	if (ret)
+		return BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD;
+	else
+		return attr.u.brport_flags;
+}
+
 /* called with RTNL but without bridge lock */
 static struct net_bridge_port *new_nbp(struct net_bridge *br,
 				       struct net_device *dev)
@@ -363,7 +378,7 @@ static struct net_bridge_port *new_nbp(struct net_bridge *br,
 	p->path_cost = port_cost(dev);
 	p->priority = 0x8000 >> BR_PORT_BITS;
 	p->port_no = index;
-	p->flags = BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD;
+	p->flags = nbp_flags_get_default(dev);
 	br_init_port(p);
 	br_set_state(p, BR_STATE_DISABLED);
 	br_stp_port_timer_init(p);
-- 
2.9.5

