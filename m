Date: Mon, 8 Sep 2003 09:36:49 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20030908093649.5b6dafc1.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH 2.6] clear hw checksum flags when bridging
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://localhost.localdomain/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, bridge@osdl.org

same patch as 2.4, just the offsets are changed.

diff -Nru a/net/bridge/br_forward.c b/net/bridge/br_forward.c
--- a/net/bridge/br_forward.c	Mon Sep  8 09:31:19 2003
+++ b/net/bridge/br_forward.c	Mon Sep  8 09:31:19 2003
@@ -69,6 +69,7 @@
 
 	indev = skb->dev;
 	skb->dev = to->dev;
+	skb->ip_summed = CHECKSUM_NONE;
 
 	NF_HOOK(PF_BRIDGE, NF_BR_FORWARD, skb, indev, skb->dev,
 			br_forward_finish);
