From: Vlad Drukker <vlad@storewiz.com>
Content-Type: multipart/mixed; boundary="=-bwoRTEpMM6EcIhBwIV/w"
Date: Thu, 06 Apr 2006 19:15:06 +0300
Message-Id: <1144340106.17145.8.camel@quant>
Mime-Version: 1.0
Subject: [Bridge] [PATCH] fix 802.3ad multicast
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: shemminger@osdl.org
Cc: bridge@osdl.org


--=-bwoRTEpMM6EcIhBwIV/w
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Stephen,

there was a bug in bridging bonds.
multicast packets needed for 802.3ad netif_carrier_ok() were dropped.
attached patch works for me.

Cheers,
Vlad.




--=-bwoRTEpMM6EcIhBwIV/w
Content-Disposition: attachment; filename=fix_br_multicast.patch
Content-Type: text/x-patch; name=fix_br_multicast.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Signed-off-by: Vlad Drukker <vlad@storewiz.com>
---
[BRIDGE] fix 802.3ad multicast frame handling
	core netif code does handle_bridge before calling protocol handler
	for ETH_P_SLOW packet_type. when BR_STATE_DISABLED is set for
	bonded port, netif_carrier_ok() will always fail for 802.3ad bond,
	because 'partner' (multicast) packet has to be received via
	_disabled_ port, causing bond to stay in BR_STATE_DISABLED forever.

---
commit e78e0ecc216f934662ae0a10df61c9e2ade44647
tree d491d94f3f043fa698e25cde863b97adc34693b2
parent e77d1795d3eb2999e271cee8957240f161a5461c
author Vlad Drukker <vlad@storewiz.com> Thu, 06 Apr 2006 18:56:51 +0300
committer Vlad Drukker <vlad@storewiz.com> Thu, 06 Apr 2006 18:56:51 +0300

 net/bridge/br_input.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index b776656..6c72c5e 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -125,7 +125,9 @@ int br_handle_frame(struct net_bridge_po
 	struct sk_buff *skb = *pskb;
 	const unsigned char *dest = eth_hdr(skb)->h_dest;
 
-	if (p->state == BR_STATE_DISABLED)
+	if (p->state == BR_STATE_DISABLED
+			&& !(skb->dev->priv_flags & IFF_MASTER_8023AD
+			&& skb->protocol == __constant_htons(ETH_P_SLOW)))
 		goto err;
 
 	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))

--=-bwoRTEpMM6EcIhBwIV/w--

