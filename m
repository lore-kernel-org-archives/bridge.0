Date: Fri, 5 Sep 2003 11:30:47 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20030905113047.196563c4.shemminger@osdl.org>
In-Reply-To: <20030830190100.4eac4504.davem@redhat.com>
References: <p05111b01bb728bc8972e@[10.96.96.13]>
	<20030827132810.65010eac.shemminger@osdl.org>
	<p05111b00bb740b63506b@[10.96.96.13]>
	<20030830190100.4eac4504.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH 2.4] bridging and hw checksum fix.
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://localhost.localdomain/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Cc: Hannes Schulz <schulz@schwaar.com>, bridge@osdl.org

Could someone who was having problems with a board that does hardware
receive checksumming, test this please.

diff -Nru a/net/bridge/br_forward.c b/net/bridge/br_forward.c
--- a/net/bridge/br_forward.c	Fri Sep  5 11:28:33 2003
+++ b/net/bridge/br_forward.c	Fri Sep  5 11:28:33 2003
@@ -59,6 +59,7 @@
 
 	indev = skb->dev;
 	skb->dev = to->dev;
+	skb->ip_summed = CHECKSUM_NONE;
 
 	NF_HOOK(PF_BRIDGE, NF_BR_FORWARD, skb, indev, skb->dev,
 			__br_forward_finish);

