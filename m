Return-Path: <zahari.doychev@googlemail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=googlemail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=qNxM9Hb0kCtLvQAiNq6wya0I6xrnWFNPO2CcDtAeFFo=;
	b=f1rzUEHmxzLqYV9qswwFq7Zc/A+rC4uPY2Ugk3ZAUEiz2DSymGvfwA0bekELK3VkZH
	WZG+TRemIsM1IHb592EJP9ngXl/a2iqhvyOP3dUHgZaLaa9D2orTDYMlsjnY0IXqtP+E
	GcqFO5b9eE3Rl5E0tELEbR1bd+iUT6nSH82ioHhXhW9aKBn3HJB8o3YrD/Jyb0muQQJ5
	b++mcneB4TVuhmtDkENqIfyj9zTP56rQd1ycmw9ptKg4JA5Sbrmb395+zTEgdyReNpT5
	vCtcHl7/leNK5pyn+u6oXZuLdf/THdnYi7hFbg7z0RZ2rfbVwRTdkyzv+w0QSH1iHyRC
	jURA==
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
From: Zahari Doychev <zahari.doychev@linux.com>
Date: Sun, 13 Jan 2019 14:59:39 +0100
Message-Id: <20190113135939.8970-3-zahari.doychev@linux.com>
In-Reply-To: <20190113135939.8970-1-zahari.doychev@linux.com>
References: <20190113135939.8970-1-zahari.doychev@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 2/2] net: bridge: fix tc added vlan insert as
	payload
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com
Cc: johannes@sipsolutions.net, zahari.doychev@linux.com, jhs@mojatatu.com

The skb->mac_len is used for the skb_push before inserting the vlan tag to
the packet payload. After that the skb is pulled only ETH_HLEN and the
network header is being reset to get the correct packet mac header. This
avoids sending packets with incorrect mac header when vlan tags are pushed
with tc-vlan and the bridge tpid does not match the inserted vlan tpid. The
vlan tag is inserted at the right place of the header.

Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
---
 net/bridge/br_vlan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 4a2f31157ef5..f857487245c6 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -460,13 +460,14 @@ static bool __allowed_ingress(const struct net_bridge *br,
 		/* Tagged frame */
 		if (skb->vlan_proto != br->vlan_proto) {
 			/* Protocol-mismatch, empty out vlan_tci for new tag */
-			skb_push(skb, ETH_HLEN);
+			skb_push(skb, skb->mac_len);
 			skb = vlan_insert_tag_set_proto(skb, skb->vlan_proto,
 							skb_vlan_tag_get(skb));
 			if (unlikely(!skb))
 				return false;
 
 			skb_pull(skb, ETH_HLEN);
+			skb_reset_network_header(skb);
 			skb_reset_mac_len(skb);
 			*vid = 0;
 			tagged = false;
-- 
2.20.1

