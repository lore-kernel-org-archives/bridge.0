From: Benjamin Poirier <benjamin.poirier@polymtl.ca>
Date: Mon, 18 Oct 2010 22:09:35 -0400
Message-Id: <1287454175-22903-1-git-send-email-benjamin.poirier@polymtl.ca>
In-Reply-To: <20101018093837.26bb149a@nehalam>
References: <20101018093837.26bb149a@nehalam>
Subject: [Bridge] [PATCH] bridge: Forward reserved group addresses if !STP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, Jiri Pirko <jpirko@redhat.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.hengli.com.au>, "David S. Miller" <davem@davemloft.net>

Make all frames sent to reserved group MAC addresses (01:80:c2:00:00:00 to
01:80:c2:00:00:0f) be forwarded if STP is disabled. This enables
forwarding EAPOL frames, among other things.

Signed-off-by: Benjamin Poirier <benjamin.poirier@polymtl.ca>
---
 net/bridge/br_input.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 826cd52..436488c 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -159,7 +159,7 @@ struct sk_buff *br_handle_frame(struct sk_buff *skb)
 			goto drop;
 
 		/* If STP is turned off, then forward */
-		if (p->br->stp_enabled == BR_NO_STP && dest[5] == 0)
+		if (p->br->stp_enabled == BR_NO_STP)
 			goto forward;
 
 		if (NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN, skb, skb->dev,
-- 
1.7.1

