Return-Path: <zahari.doychev@googlemail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=googlemail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=T6MKAF5sO0UFF7jfE2JZusXPWSZfUX6ZOmp/4r7o2uM=;
	b=dmRJ4wX5JToMweQLUWBDSKfPW4PdeHbYMrwY+y/IKvZhNVwv5UNHgsHrlrqoHykwwi
	5mDPpP0fcN/wfPbowbPlOemZOedBiN0cGjuT0eSRdWFUcAR2DAgguRu7yPF8iAnMXpwa
	b5WKvg+aXA3+Po22gQFD2CEOIUhruJCeqWXGsB+X8hdkU3XH4DVHcoa+gh65Fr4vQunO
	GWB0/8hq6QI221D/AyQul4JwN69iflQN5Dm8WXC1Ku4xmvT3654J9nxa2bbPLJbla3fy
	hiqbGv7wW16MHjQBjOomcmDUhhrKw1cXxEtJO9ymvmaW0HUhaUj8IscOukj2EiOwzxaP
	hplg==
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
From: Zahari Doychev <zahari.doychev@linux.com>
Date: Sun, 13 Jan 2019 14:59:38 +0100
Message-Id: <20190113135939.8970-2-zahari.doychev@linux.com>
In-Reply-To: <20190113135939.8970-1-zahari.doychev@linux.com>
References: <20190113135939.8970-1-zahari.doychev@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 1/2] net: bridge: fix tc added QinQ forwarding
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

Use the skb->mac_len instead of using the ETH_HLEN when pushing the skb
data pointer. This fixes sending incorrect packets when more than one
vlan tags are pushed by tc-vlan and the mac header length is bigger than
ETH_HLEN. In this way the vlan tagged contained in the skb is inserted at
right offset in the packet payload before sending the packet.

Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
---
 net/bridge/br_forward.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 5372e2042adf..55f928043f77 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -39,7 +39,7 @@ int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb
 	if (!is_skb_forwardable(skb->dev, skb))
 		goto drop;
 
-	skb_push(skb, ETH_HLEN);
+	skb_push(skb, skb->mac_len);
 	br_drop_fake_rtable(skb);
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-- 
2.20.1

