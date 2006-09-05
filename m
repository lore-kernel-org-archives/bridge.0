Date: Tue, 5 Sep 2006 09:59:07 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060905095907.3d3c58f7@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] bridge: random extra bytes on STP TCN packet
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@osdl.org

We seem to send 3 extra bytes in a TCN, which will be whatever happens
to be on the stack. Thanks to Aji_Srinivas@emc.com for seeing.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

diff -Naur a/net/bridge/br_stp_bpdu.c b/net/bridge/br_stp_bpdu.c
--- a/net/bridge/br_stp_bpdu.c	2006-09-03 23:40:08.000000000 +0530
+++ b/net/bridge/br_stp_bpdu.c	2006-09-03 23:40:33.000000000 +0530
@@ -121,7 +121,7 @@
 	buf[1] = 0;
 	buf[2] = 0;
 	buf[3] = BPDU_TYPE_TCN;
-	br_send_bpdu(p, buf, 7);
+	br_send_bpdu(p, buf, 4);
 }
 
 /*

