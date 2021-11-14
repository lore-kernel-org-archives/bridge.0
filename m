Return-Path: <christophe.jaillet@wanadoo.fr>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sun, 14 Nov 2021 20:02:35 +0100
Message-Id: <00c39d09c8df7ad0673bf2043f6566d6ef08b789.1636916479.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH] net: bridge: Slightly optimize 'find_portno()'
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@nvidia.com, nikolay@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

The 'inuse' bitmap is local to this function. So we can use the
non-atomic '__set_bit()' to save a few cycles.

While at it, also remove some useless {}.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 net/bridge/br_if.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index c1183fef1f21..64b2d4fb50f5 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -397,10 +397,10 @@ static int find_portno(struct net_bridge *br)
 	if (!inuse)
 		return -ENOMEM;
 
-	set_bit(0, inuse);	/* zero is reserved */
-	list_for_each_entry(p, &br->port_list, list) {
-		set_bit(p->port_no, inuse);
-	}
+	__set_bit(0, inuse);	/* zero is reserved */
+	list_for_each_entry(p, &br->port_list, list)
+		__set_bit(p->port_no, inuse);
+
 	index = find_first_zero_bit(inuse, BR_MAX_PORTS);
 	bitmap_free(inuse);
 
-- 
2.30.2

