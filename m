Date: Wed, 21 Dec 2005 21:55:27 +0200
From: mikukkon@iki.fi
Message-ID: <20051221195527.GA24213@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [PATCH] BRIDGE: Fix faulty check in
	br_stp_recalculate_bridge_id()
Reply-To: mikukkon@iki.fi
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: shemminger@osdl.org
Cc: bridge@osdl.org, linux-kernel@vger.kernel.org

I did a compile with extra gcc warnings, and found a bug in
net/bridge/br_stp_if.c function br_stp_recalculate_bridge_id():
compare_ether_addr() returns 0 if match, positive if not, so
checking it for negative is wrong. 

Signed-of-by: Mika Kukkonen <mikukkon@iki.fi>

---

 net/bridge/br_stp_if.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index ac09b6a..08c52c2 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -158,7 +158,7 @@ void br_stp_recalculate_bridge_id(struct
 
 	list_for_each_entry(p, &br->port_list, list) {
 		if (addr == br_mac_zero ||
-		    compare_ether_addr(p->dev->dev_addr, addr) < 0)
+		    compare_ether_addr(p->dev->dev_addr, addr))
 			addr = p->dev->dev_addr;
 
 	}

