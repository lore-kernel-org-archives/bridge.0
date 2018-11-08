Return-Path: <mirq-linux@rere.qmqm.pl>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1541719025; bh=Qc7PnMXGc8+FfHDHzLrLqc5PfyMzVK3ZXR888xiFvgE=;
	h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
	b=Ve3N14x6Efv9F25iyjVT9uL761sMUveOcEy78JWbvd5aj25YROZY4GZEhqdimE9Px
	alVoUhxxY750SWqL1lFOH6t0ekzo9Ls+WrccudsZ79q8Ib2TbuIOanEE0e2R0tJR8x
	nhtyTYlB0f0xKMrwqjsjCiSYvCKREqFUPNJMHVWbcw2x8SEqOxdkT3IWPeIqJ63gss
	Qz+W9irOny4daCBrdBuJkYrfBvaY9f37juKQyDRugly7gs4vx/gkd0pDIC+DBIiL9D
	hMICZRcdp+m0DCFPVpUntMzjGflA8BTQf3TQATxq4i5jnakVRcZTRa/bqWpPCilPeQ
	Mi2fC5u8gkaXg==
Date: Fri, 09 Nov 2018 00:18:03 +0100
Message-Id: <e016c369084d747bdd4b1cd5956f2272261ff678.1541718583.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541718583.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541718583.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 4/9] 8021q: use __vlan_hwaccel helpers
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
 net/8021q/vlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index 4f60e86f4b8d..dd39489c829a 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -57,7 +57,7 @@ bool vlan_do_receive(struct sk_buff **skbp)
 	}
 
 	skb->priority = vlan_get_ingress_priority(vlan_dev, skb->vlan_tci);
-	skb->vlan_tci = 0;
+	__vlan_hwaccel_clear_tag(skb);
 
 	rx_stats = this_cpu_ptr(vlan_dev_priv(vlan_dev)->vlan_pcpu_stats);
 
-- 
2.19.1

