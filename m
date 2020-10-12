Return-Path: <hkallweit1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QgEFAZvIGUs9d79dSBvM16GKW6VzPnxLl+Fxh+U3V5E=;
 b=smMjqkLUc83TdlNXcDcI3M3/ULwnTf55iu2dvwq3DZB3ijaghGEg1QucVM48Q59Xei
 PhCJRKNkGb6mEr/MRzSqyVNV4fflsAxkglH2EZ7WsMPP0qYCAMMKkJfrlb0Te3v932Kj
 u04qGb9yhQ1k2CE2QwduucTZPxyUTXc6f7vZLCvLmEUzn/FDxBGxmAIpH705hS2LrQ/+
 +SOYOqNpqZrunAzwqopXYlPOD0/GDk4BgwqEYxQYMykZ+qxKMd/llLUBmr2yahu1s5mQ
 T/ll3jwrsNZlgaP76L6IGirBg7GpdPamcuyboxa4oE4J03+nQ3j2KUDK6SR2oN8ZurC5
 kFvA==
From: Heiner Kallweit <hkallweit1@gmail.com>
References: <d77b65de-1793-f808-66b5-aaa4e7c8a8f0@gmail.com>
Message-ID: <166259f2-084c-45d7-e610-2de2a0bdae06@gmail.com>
Date: Mon, 12 Oct 2020 10:14:08 +0200
MIME-Version: 1.0
In-Reply-To: <d77b65de-1793-f808-66b5-aaa4e7c8a8f0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH net-next v2 06/12] qtnfmac: use new function
 dev_fetch_sw_netstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>, Oliver Neukum <oneukum@suse.com>, Igor Mitsyanko <imitsyanko@quantenna.com>, Sergey Matyukevich <geomatsi@gmail.com>, Kalle Valo <kvalo@codeaurora.org>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Johannes Berg <johannes@sipsolutions.net>, Pravin B Shelar <pshelar@ovn.org>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-rdma@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, bridge@lists.linux-foundation.org

Simplify the code by using new function dev_fetch_sw_netstats().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/quantenna/qtnfmac/core.c | 23 +------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index 374074dc7..bf6dbeb61 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -139,34 +139,13 @@ static void qtnf_netdev_get_stats64(struct net_device *ndev,
 				    struct rtnl_link_stats64 *stats)
 {
 	struct qtnf_vif *vif = qtnf_netdev_get_priv(ndev);
-	unsigned int start;
-	int cpu;
 
 	netdev_stats_to_stats64(stats, &ndev->stats);
 
 	if (!vif->stats64)
 		return;
 
-	for_each_possible_cpu(cpu) {
-		struct pcpu_sw_netstats *stats64;
-		u64 rx_packets, rx_bytes;
-		u64 tx_packets, tx_bytes;
-
-		stats64 = per_cpu_ptr(vif->stats64, cpu);
-
-		do {
-			start = u64_stats_fetch_begin_irq(&stats64->syncp);
-			rx_packets = stats64->rx_packets;
-			rx_bytes = stats64->rx_bytes;
-			tx_packets = stats64->tx_packets;
-			tx_bytes = stats64->tx_bytes;
-		} while (u64_stats_fetch_retry_irq(&stats64->syncp, start));
-
-		stats->rx_packets += rx_packets;
-		stats->rx_bytes += rx_bytes;
-		stats->tx_packets += tx_packets;
-		stats->tx_bytes += tx_bytes;
-	}
+	dev_fetch_sw_netstats(stats, vif->stats64);
 }
 
 /* Netdev handler for transmission timeout.
-- 
2.28.0


