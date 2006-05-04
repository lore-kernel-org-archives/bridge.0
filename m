Date: Thu, 4 May 2006 16:10:19 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060504161019.17feb2aa@localhost.localdomain>
In-Reply-To: <FFEPKIHJDEDDAAFOFDGFMEJGCBAA.PCDiem@FoxValley.net>
References: <20060504143624.324274f6@localhost.localdomain>
	<FFEPKIHJDEDDAAFOFDGFMEJGCBAA.PCDiem@FoxValley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] bridge: keep track of received multicast packets
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Paul C. Diem" <PCDiem@foxvalley.net>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.osdl.org

It makes sense to add this simple statistic to keep track of received
multicast packets.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- bridge.orig/net/bridge/br_input.c	2006-04-21 14:28:55.000000000 -0700
+++ bridge/net/bridge/br_input.c	2006-05-04 16:07:24.000000000 -0700
@@ -66,6 +66,7 @@
 	}
 
 	if (is_multicast_ether_addr(dest)) {
+		br->statistics.multicast++;
 		br_flood_forward(br, skb, !passedup);
 		if (!passedup)
 			br_pass_frame_up(br, skb);
