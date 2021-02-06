Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1612648186; x=1644184186;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VfcYpmFuPF4yFqZyhgxuIVPMYyl9jq6z/cTu1Ke0+uI=;
 b=XDnuWEUeY+dQrxL4cY6kEYv1G8CtjH+DZCf8+xZLgbJ8lXzlR9wbLnJa
 fE5DZOVXdSjZRuylzri4pZi4yuvTXxbFXarv96e3wV1uAkOu5KZtZefpQ
 z9tL3KTHYlV+qq12dFUX9xlGdnLTX8hbGtq6l2QEoLyXhTAD20ESMy1D+
 ftCuD+ynkb4YyDMqN/KC/XYtgiH+e3J3h8l69YFqkfXh/irjnAxmamEBt
 ZW9XgYoQL9t0UMdlFhdGUCOm57fsncwghnGQ4Sa7DFegiiGdSqM27Kodp
 iaynxtUdAXGr5z3+aHkS20Ef3Wpm9a9RTz5rSPBy9i8gEog+iP+Lls4+u w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Sat, 6 Feb 2021 22:47:33 +0100
Message-ID: <20210206214734.1577849-2-horatiu.vultur@microchip.com>
In-Reply-To: <20210206214734.1577849-1-horatiu.vultur@microchip.com>
References: <20210206214734.1577849-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net 1/2] bridge: mrp: Fix the usage of
	br_mrp_port_switchdev_set_state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, rasmus.villemoes@prevas.dk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

The function br_mrp_port_switchdev_set_state was called both with MRP
port state and STP port state, which is an issue because they don't
match exactly.

Therefore, update the function to be used only with STP port state and
use the id SWITCHDEV_ATTR_ID_PORT_STP_STATE.

The choice of using STP over MRP is that the drivers already implement
SWITCHDEV_ATTR_ID_PORT_STP_STATE and already in SW we update the port
STP state.

Fixes: 9a9f26e8f7ea30 ("bridge: mrp: Connect MRP API with the switchdev API")
Fixes: fadd409136f0f2 ("bridge: switchdev: mrp: Implement MRP API for switchdev")
Fixes: 2f1a11ae11d222 ("bridge: mrp: Add MRP interface.")
Reported-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp.c           | 9 ++++++---
 net/bridge/br_mrp_switchdev.c | 7 +++----
 net/bridge/br_private_mrp.h   | 3 +--
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index cec2c4e4561d..5aeae6ad17b3 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -557,19 +557,22 @@ int br_mrp_del(struct net_bridge *br, struct br_mrp_instance *instance)
 int br_mrp_set_port_state(struct net_bridge_port *p,
 			  enum br_mrp_port_state_type state)
 {
+	u32 port_state;
+
 	if (!p || !(p->flags & BR_MRP_AWARE))
 		return -EINVAL;
 
 	spin_lock_bh(&p->br->lock);
 
 	if (state == BR_MRP_PORT_STATE_FORWARDING)
-		p->state = BR_STATE_FORWARDING;
+		port_state = BR_STATE_FORWARDING;
 	else
-		p->state = BR_STATE_BLOCKING;
+		port_state = BR_STATE_BLOCKING;
 
+	p->state = port_state;
 	spin_unlock_bh(&p->br->lock);
 
-	br_mrp_port_switchdev_set_state(p, state);
+	br_mrp_port_switchdev_set_state(p, port_state);
 
 	return 0;
 }
diff --git a/net/bridge/br_mrp_switchdev.c b/net/bridge/br_mrp_switchdev.c
index ed547e03ace1..75a7e8d0a268 100644
--- a/net/bridge/br_mrp_switchdev.c
+++ b/net/bridge/br_mrp_switchdev.c
@@ -169,13 +169,12 @@ int br_mrp_switchdev_send_in_test(struct net_bridge *br, struct br_mrp *mrp,
 	return err;
 }
 
-int br_mrp_port_switchdev_set_state(struct net_bridge_port *p,
-				    enum br_mrp_port_state_type state)
+int br_mrp_port_switchdev_set_state(struct net_bridge_port *p, u32 state)
 {
 	struct switchdev_attr attr = {
 		.orig_dev = p->dev,
-		.id = SWITCHDEV_ATTR_ID_MRP_PORT_STATE,
-		.u.mrp_port_state = state,
+		.id = SWITCHDEV_ATTR_ID_PORT_STP_STATE,
+		.u.stp_state = state,
 	};
 	int err;
 
diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
index 32a48e5418da..2514954c1431 100644
--- a/net/bridge/br_private_mrp.h
+++ b/net/bridge/br_private_mrp.h
@@ -72,8 +72,7 @@ int br_mrp_switchdev_set_ring_state(struct net_bridge *br, struct br_mrp *mrp,
 int br_mrp_switchdev_send_ring_test(struct net_bridge *br, struct br_mrp *mrp,
 				    u32 interval, u8 max_miss, u32 period,
 				    bool monitor);
-int br_mrp_port_switchdev_set_state(struct net_bridge_port *p,
-				    enum br_mrp_port_state_type state);
+int br_mrp_port_switchdev_set_state(struct net_bridge_port *p, u32 state);
 int br_mrp_port_switchdev_set_role(struct net_bridge_port *p,
 				   enum br_mrp_port_role_type role);
 int br_mrp_switchdev_set_in_role(struct net_bridge *br, struct br_mrp *mrp,
-- 
2.27.0

