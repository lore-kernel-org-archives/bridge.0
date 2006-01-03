Date: Tue, 3 Jan 2006 10:41:57 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060103104157.1512f5fa@dxpl.pdx.osdl.net>
In-Reply-To: <20051221.195107.113618698.davem@davemloft.net>
References: <20051221195527.GA24213@localhost.localdomain>
	<20051221132527.1ef12bcf@dxpl.pdx.osdl.net>
	<20051221.195107.113618698.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] BRIDGE: Fix faulty check in
	br_stp_recalculate_bridge_id()
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>
Cc: mikukkon@iki.fi, bridge@osdl.org, linux-kernel@vger.kernel.org

One of the conversions from memcmp to compare_ether_addr is incorrect.
We need to do relative comparison to determine min MAC address to
use in bridge id. 

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- linux-2.6.15.orig/net/bridge/br_stp_if.c
+++ linux-2.6.15/net/bridge/br_stp_if.c
@@ -158,7 +158,7 @@ void br_stp_recalculate_bridge_id(struct
 
 	list_for_each_entry(p, &br->port_list, list) {
 		if (addr == br_mac_zero ||
-		    compare_ether_addr(p->dev->dev_addr, addr) < 0)
+		    memcmp(p->dev->dev_addr, addr, ETH_ALEN) < 0)
 			addr = p->dev->dev_addr;
 
 	}
