Return-Path: <Horatiu.Vultur@microchip.com>
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Fri, 24 Jan 2020 17:18:23 +0100
Message-ID: <20200124161828.12206-6-horatiu.vultur@microchip.com>
In-Reply-To: <20200124161828.12206-1-horatiu.vultur@microchip.com>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [RFC net-next v3 05/10] net: bridge: mrp: Update MRP
	interface to add switchdev support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, anirudh.venkataramanan@intel.com, olteanv@gmail.com, andrew@lunn.ch, jeffrey.t.kirsher@intel.com, UNGLinuxDriver@microchip.com
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

Extend the MRP interface to allow switchdev support. The following functions are
added:

br_mrp_port_switchdev_add - this corresponds to the function br_mrp_add_port,
  and will notify the HW that a port is added to a MRP ring. The function gets
  as parameter the port and the ID of the ring.

br_mrp_port_switchdev_del - this corresponds to the function br_mrp_del_port
  and will notify the HW that a port is removed from a MRP ring. The function
  gets as parameter the port and the ID of the ring.

br_mrp_port_switchdev_set_state - this corresponds to the function
  br_mrp_port_state. It would notify the HW if it should block or not non-MRP
  frames.

br_mrp_port_switchdev_set_port - this corresponds to the function
  br_mrp_port_role. It would set the port role, primary or secondary.

br_mrp_switchdev_set_role - this corresponds to the function br_mrp_ring_role
  and would set one of the role MRM or MRC.

br_mrp_switchdev_set_ring_state - this corresponds to the function
  br_mrp_ring_state and would set the ring to be open or closed.

br_mrp_switchdev_send_ring_test - this corresponds to the function
  br_mrp_start_test. This will notify the HW to start or stop generating
  MRP_Test frames. Value 0 for the interval parameter means to stop generating
  the frames.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_private_mrp.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
index bea4ece4411c..de5ba7f730f6 100644
--- a/net/bridge/br_private_mrp.h
+++ b/net/bridge/br_private_mrp.h
@@ -35,6 +35,22 @@ int br_mrp_start_test(struct net_bridge *br, u32 ring_nr, u32 interval,
 		      u8 max_miss);
 int br_mrp_flush(struct net_bridge *br, u32 ring_nr);
 
+/* br_mrp_switchdev.c */
+int br_mrp_port_switchdev_add(struct net_bridge_port *p, u32 ring_nr);
+int br_mrp_port_switchdev_del(struct net_bridge_port *p, u32 ring_nr);
+int br_mrp_port_switchdev_set_state(struct net_bridge_port *p,
+				    enum br_mrp_port_state_type state);
+int br_mrp_port_switchdev_set_role(struct net_bridge_port *p,
+				   enum br_mrp_port_role_type role);
+
+int br_mrp_switchdev_set_ring_role(struct br_mrp *mrp,
+				   enum br_mrp_ring_role_type role);
+int br_mrp_switchdev_set_ring_state(struct br_mrp *mrp,
+				    enum br_mrp_ring_state_type state);
+
+int br_mrp_switchdev_send_ring_test(struct br_mrp *mrp, u32 interval,
+				    u8 max_miss);
+
 /* br_mrp_netlink.c */
 void br_mrp_port_open(struct net_device *dev, u8 loc);
 
-- 
2.17.1

