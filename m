Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1589973085; x=1621509085;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WV0s6syDCFCLZ7SWuRmHom6k1uwxvsH4yqT1PpZ4Ge4=;
 b=iryf6IwZgwKZH2Ik4k+rjS8+ypExZ8mdzy+vj6mV+VBH6TD5BKdgSp+C
 IxocxXTLhUyggKpxxFYvJBs3+cCCjFSuabLLFM1eORB6JI+5VxQQxkmYg
 Oyd6WTax/8FybwQvQs72L1P9ak671ScMxFHPxLVG5whGjVbRjn7+zLxnx
 CY+Iw/pSDwelJynpx5K64ngSdOOAbG0tjBS9AjOy8mJsDpxyLty/vlVNH
 sSygmz0ukfFdZZq/KKuvlDY/a2mLra0iJE5iZrW91ed9I+6WDEppRw5SP
 iXU8aNbpiGs1JUi3YMl3Fi9t438cNSvkxrA3MAR/BigP5XURqbiwWJ/2r Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Wed, 20 May 2020 13:09:23 +0000
Message-ID: <20200520130923.3196432-4-horatiu.vultur@microchip.com>
In-Reply-To: <20200520130923.3196432-1-horatiu.vultur@microchip.com>
References: <20200520130923.3196432-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH 3/3] bridge: mrp: Restore port state when deleting
	MRP instance
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

When a MRP instance is deleted, then restore the port according to the
bridge state. If the bridge is up then the ports will be in forwarding
state otherwise will be in disabled state.

Fixes: 9a9f26e8f7ea ("bridge: mrp: Connect MRP API with the switchdev API")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index a5a3fa59c078a..bdd8920c15053 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -229,6 +229,7 @@ static void br_mrp_test_work_expired(struct work_struct *work)
 static void br_mrp_del_impl(struct net_bridge *br, struct br_mrp *mrp)
 {
 	struct net_bridge_port *p;
+	u8 state;
 
 	/* Stop sending MRP_Test frames */
 	cancel_delayed_work_sync(&mrp->test_work);
@@ -240,20 +241,24 @@ static void br_mrp_del_impl(struct net_bridge *br, struct br_mrp *mrp)
 	p = rtnl_dereference(mrp->p_port);
 	if (p) {
 		spin_lock_bh(&br->lock);
-		p->state = BR_STATE_FORWARDING;
+		state = netif_running(br->dev) ?
+				BR_STATE_FORWARDING : BR_STATE_DISABLED;
+		p->state = state;
 		p->flags &= ~BR_MRP_AWARE;
 		spin_unlock_bh(&br->lock);
-		br_mrp_port_switchdev_set_state(p, BR_STATE_FORWARDING);
+		br_mrp_port_switchdev_set_state(p, state);
 		rcu_assign_pointer(mrp->p_port, NULL);
 	}
 
 	p = rtnl_dereference(mrp->s_port);
 	if (p) {
 		spin_lock_bh(&br->lock);
-		p->state = BR_STATE_FORWARDING;
+		state = netif_running(br->dev) ?
+				BR_STATE_FORWARDING : BR_STATE_DISABLED;
+		p->state = state;
 		p->flags &= ~BR_MRP_AWARE;
 		spin_unlock_bh(&br->lock);
-		br_mrp_port_switchdev_set_state(p, BR_STATE_FORWARDING);
+		br_mrp_port_switchdev_set_state(p, state);
 		rcu_assign_pointer(mrp->s_port, NULL);
 	}
 
-- 
2.26.2

