Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=idQcbvzPIu1BSdVQIplt97QLkM9ok6uSRBt+kD2R0VY=;
	b=Jcf5gvAuECDHnSqlWrJl59LMVaLbAq8Zcjj51ekAPjCZnrcPLabHmGPaEC/zzSNAPh
	REueJzvJg/hipwla5YFSjsi+BhDtSH0TpqY2lAxiiGvHbJ+3/HB8eyarYmn5Q3PdrQTy
	kwUI9wi0zeGfbhZDFT/O6IAGaK/a5cYvHspWg=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue,  2 Jul 2019 15:00:21 +0300
Message-Id: <20190702120021.13096-5-nikolay@cumulusnetworks.com>
In-Reply-To: <20190702120021.13096-1-nikolay@cumulusnetworks.com>
References: <20190702120021.13096-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net 4/4] net: bridge: stp: don't cache eth dest
	pointer before skb pull
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: martin@linuxlounge.net, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, yoshfuji@linux-ipv6.org, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, davem@davemloft.net

Don't cache eth dest pointer before calling pskb_may_pull.

Fixes: cf0f02d04a83 ("[BRIDGE]: use llc for receiving STP packets")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_stp_bpdu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bridge/br_stp_bpdu.c b/net/bridge/br_stp_bpdu.c
index 68a6922b4141..7796dd9d42d7 100644
--- a/net/bridge/br_stp_bpdu.c
+++ b/net/bridge/br_stp_bpdu.c
@@ -143,7 +143,6 @@ void br_send_tcn_bpdu(struct net_bridge_port *p)
 void br_stp_rcv(const struct stp_proto *proto, struct sk_buff *skb,
 		struct net_device *dev)
 {
-	const unsigned char *dest = eth_hdr(skb)->h_dest;
 	struct net_bridge_port *p;
 	struct net_bridge *br;
 	const unsigned char *buf;
@@ -172,7 +171,7 @@ void br_stp_rcv(const struct stp_proto *proto, struct sk_buff *skb,
 	if (p->state == BR_STATE_DISABLED)
 		goto out;
 
-	if (!ether_addr_equal(dest, br->group_addr))
+	if (!ether_addr_equal(eth_hdr(skb)->h_dest, br->group_addr))
 		goto out;
 
 	if (p->flags & BR_BPDU_GUARD) {
-- 
2.21.0

