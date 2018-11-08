Return-Path: <mirq-linux@rere.qmqm.pl>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1541719026; bh=rQIk5+P6EcKbWCWWr4OJqJ7q7H1OwU7fRELwhVstikA=;
	h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
	b=UkhaiBA+o23XBWOGgOTA8QeUNAg1nhSaXia4a1Aa1JCOtzTNvWYWQ6f0cidWjXFVK
	SVgkbZXmTIOziWVUQyhCiA3x1r94dKWyEdYCIgXq8zZqAF/zV8sz8I6uSkJYvx3+cM
	gSLHfb1Akc6FbUTBAaDU0XZYUcdKRbaXOKAEA5IOw+2F85dBaSwW0M+cBNiUP3CG7f
	IDoms3XqjeW9Sp4GfHQ5s/yrFgLgtwe+2MtoVIKVApjZ4rKtI8wc64oCu9CAicl5GH
	pPPWRdiT5OASVIn0o3pBG3S6EoSDSlh1oYUwUi46GoE3PryGSpEwL48ufzMLX7/vwp
	TIQ4tA/W9vvgA==
Date: Fri, 09 Nov 2018 00:18:04 +0100
Message-Id: <53209e7c5fd949ac69087902ad42b1831eec0727.1541718583.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541718583.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541718583.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 6/9] ipv4/tunnel: use __vlan_hwaccel
	helpers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, coreteam@netfilter.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pablo Neira Ayuso <pablo@netfilter.org>, Jiri Pirko <jiri@resnulli.us>, Steve Wise <swise@chelsio.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Sathya Perla <sathya.perla@broadcom.com>, Cong Wang <xiyou.wangcong@gmail.com>, Mirko Lindner <mlindner@marvell.com>, Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Tariq Toukan <tariqt@mellanox.com>

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 net/ipv4/ip_tunnel_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index dde671e97829..f45b96d715f0 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -120,7 +120,7 @@ int __iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
 	}
 
 	skb_clear_hash_if_not_l4(skb);
-	skb->vlan_tci = 0;
+	__vlan_hwaccel_clear_tag(skb);
 	skb_set_queue_mapping(skb, 0);
 	skb_scrub_packet(skb, xnet);
 
-- 
2.19.1

