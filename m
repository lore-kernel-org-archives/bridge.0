Return-Path: <Joseph.Huang@garmin.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pps1;
 bh=NevxT241im1sompXtnoojFuHhyOb8qL5q3yVwdaLpKw=;
 b=jt1UrfMrCaoiZYxrll0NBrtsXHQMCijieZi1/+1EH3UyPRAyBTpOrLL7X9KLBgidk3Jg
 pKHuKZrx6szm5UfyG2LflIbUxzZ9iAd858n1fI8hXr667ZWggQ6ZqEFDWPF9ydsUAVNr
 hu/1G9CP6/PQeR56W9OA553OJb6hJCK+c+2asdNOSDiSbvQfyAaJzCVYUZLDV4/rKvbl
 fqBCGtsV7w4yGh9hzxohjh8swQCcDboLM1bseaefbjDs6iyeYigLxAEToeUoyt3qwAhk
 aNN6aS4CRpSz5Nxk38HslWOqkE2ySNt4t6afIWYrK0eL94P0bzNBsFB9locarXGh8EbC nA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=garmin.onmicrosoft.com; s=selector1-garmin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NevxT241im1sompXtnoojFuHhyOb8qL5q3yVwdaLpKw=;
 b=Aa9PF6ml7wwVuEi21SFpiybOtLwOeyI0q5XNF5QN1vJ9s7k7KTQEtK+HJn+StMd4uRIbWbZit/gQteNoPvFqVFAJHGn5LrTnRI+ojDItI6Rx2Z0YcVaWB22WEul+X6kMzwQbQvBUxsiFPcwwLzYdW+AuY+InkkrWJoFqYsv2DtvO80Iq6yR27+7h1vYM/9fAb1qDQz8DsNKVkr09cTE01nJXjzjJSPJTRzvVfLZ9MO//yhgHhcRTLj3mB62jYYw6R6FiqZsaOO0UIOOO+fHX3Pdny4S6eJnji/nKqQaoGkyRgDIvyVoDc5KwTALgQZNRw708oUvbOToAb4Dk0TK46Q==
From: Joseph Huang <Joseph.Huang@garmin.com>
Date: Tue, 4 May 2021 14:22:57 -0400
Message-ID: <20210504182259.5042-5-Joseph.Huang@garmin.com>
In-Reply-To: <20210504182259.5042-1-Joseph.Huang@garmin.com>
References: <20210504182259.5042-1-Joseph.Huang@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH 4/6] bridge: Force mcast_flooding for mrouter ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joseph Huang <Joseph.Huang@garmin.com>

When a port turns into an mrouter port, enable multicast flooding
on that port even if mcast_flood is disabled by user config. This
is necessary so that in a distributed system, the multicast packets
can be fowarded to the Querier when the multicast source is attached
to a Non-Querier bridge.

Consider the following scenario:

                 +--------------------+
                 |                    |
                 |      Snooping      |    +------------+
                 |      Bridge 1      |----| Listener 1 |
                 |     (Querier)      |    +------------+
                 |                    |
                 +--------------------+
                           |
                           |
                 +--------------------+
                 |    | mrouter |     |
+-----------+    |    +---------+     |
| MC Source |----|      Snooping      |
+-----------|    |      Bridge 2      |
                 |    (Non-Querier)   |
                 +--------------------+

In this scenario, Listener 1 will never receive multicast traffic
from MC Source if mcast_flood is disabled on the mrouter port on
Snooping Bridge 2.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 net/bridge/br_multicast.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index d7fbe1f3af18..719ded3204a0 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2680,6 +2680,21 @@ static void br_port_mc_router_state_change(struct net_bridge_port *port,
 
 	switchdev_port_attr_set(port->dev, &attr, NULL);
 
+	/* Force mcast_flood if mrouter port
+	 * this does not prevent netlink from changing it again
+	 */
+	if (is_mc_router && !(port->flags & BR_MCAST_FLOOD)) {
+		attr.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS;
+		attr.u.brport_flags.val = BR_MCAST_FLOOD;
+		attr.u.brport_flags.mask = BR_MCAST_FLOOD;
+		switchdev_port_attr_set(port->dev, &attr, NULL);
+	} else if (!is_mc_router) {
+		attr.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS;
+		attr.u.brport_flags.val = port->flags & BR_MCAST_FLOOD;
+		attr.u.brport_flags.mask = BR_MCAST_FLOOD;
+		switchdev_port_attr_set(port->dev, &attr, NULL);
+	}
+
 	/* Add/delete the router port to/from all multicast group
 	 * called whle br->multicast_lock is held
 	 */
-- 
2.17.1

