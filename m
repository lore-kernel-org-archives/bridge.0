Return-Path: <mirq-linux@rere.qmqm.pl>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1541719027; bh=+V3+AUMQPKtkxFH3ehE7O1MLwvQaBOyn0pjvj94G9oo=;
	h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
	b=pprk+kLyw8OzfR+bti/Oxd8h8O2w8j7xRDdt85CJiYfG7E62ceMEkneGIGX9CS8O0
	/e/izFIIKK6oXDjJI5ie1xHunB+WjhgaLafm/mGBMqEO+2i50pDRyHVJGXDGC6xJef
	+OWMfBYlXb/hoX2/lX0wbXxdtvBjD6vyuqro0cJWA8PydktrycQz24aCtZRj2q/2cB
	0OzUOcTvKGbYjglfnCELzgv2Hq7iuxVUbO2VqcHuRmdGO8kJ49nsqgVlMrs21tyXA7
	KVrEDl69hQxjTNDk78LNsUNkGbsMCfDpCzUiaU9WsVK0CZ+C+tOpxXWzw6GQPUHshH
	hWMO4cPFQ9ISQ==
Date: Fri, 09 Nov 2018 00:18:05 +0100
Message-Id: <d736b816ca21ee3fc466f2705f3d85448bd922f9.1541718583.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541718583.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541718583.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 8/9] mlx4: use __vlan_hwaccel helpers
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
 drivers/net/ethernet/mellanox/mlx4/en_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index db00bf1c23f5..fd09ba98c0a6 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -875,7 +875,7 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
 			skb->data_len = length;
 			napi_gro_frags(&cq->napi);
 		} else {
-			skb->vlan_tci = 0;
+			__vlan_hwaccel_clear_tag(skb);
 			skb_clear_hash(skb);
 		}
 next:
-- 
2.19.1

