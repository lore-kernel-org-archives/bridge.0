Return-Path: <antonio@open-mesh.com>
From: Antonio Quartulli <antonio@open-mesh.com>
Date: Mon, 8 Apr 2013 19:41:02 +0200
Message-ID: <1365442863-32394-3-git-send-email-antonio@open-mesh.com>
In-Reply-To: <1365442863-32394-1-git-send-email-antonio@open-mesh.com>
References: <1365442863-32394-1-git-send-email-antonio@open-mesh.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH 2/3] sk_buff: add bridge_restricted flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Antonio Quartulli <antonio@open-mesh.com>

This new flag tells whether the skb has been originated by
an interface marked with the IFF_BRIDGE_RESTRICTED flag.

This information can be used to prevent a packet from being
forwarded to another restricted interface.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 include/linux/skbuff.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index e27d1c7..2054073 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -492,7 +492,8 @@ struct sk_buff {
 	 * headers if needed
 	 */
 	__u8			encapsulation:1;
-	/* 7/9 bit hole (depending on ndisc_nodetype presence) */
+	__u8			bridge_restricted:1;
+	/* 9/11 bit hole (depending on ndisc_nodetype presence) */
 	kmemcheck_bitfield_end(flags2);
 
 #ifdef CONFIG_NET_DMA
-- 
1.8.1.5

