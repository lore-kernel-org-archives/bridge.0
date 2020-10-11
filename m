Return-Path: <hkallweit1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WQbLDoFSeSltH3nftOw/NOzLE5EP1LZ6y+xL/a85h+w=;
 b=GRfTQACPyYtR9pqybfVbLmIpJpuRl0C7wsrFoWXj0QX2wcH42Nf5udem/k1aVfah6x
 5vyHB7w2Bv/AM6CamTx3zwA3DYcGCYNGJArU2vV3132pEcwY9490f1rV9XqSsKjP2P6P
 uxm6ihfKy1Z0s9suALkvOACSWG9AS0rfoXB5Ev8q5jjvCRxdzC5SialMoEui+aiDT2OO
 Nav4/AveRUsUVI91sXydnB/YWzuq6GtOeFMFMELGgiFo2RLcSvAabyKUnJK34V7pMJII
 op63g+Mx29KT9idfNKqGYQ0Z3lXoirpktiUjywSNtNwi0K3Dd9JCFhi2raiJVTREJtBZ
 jn4w==
From: Heiner Kallweit <hkallweit1@gmail.com>
References: <a46f539e-a54d-7e92-0372-cd96bb280729@gmail.com>
Message-ID: <4c7b9a8d-caa2-52dd-8973-10f4e2892dd6@gmail.com>
Date: Sun, 11 Oct 2020 21:41:27 +0200
MIME-Version: 1.0
In-Reply-To: <a46f539e-a54d-7e92-0372-cd96bb280729@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH net-next 08/12] net: dsa: use new function
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
---
 net/dsa/slave.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index e7c1d62fd..3bc5ca40c 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1221,28 +1221,9 @@ static void dsa_slave_get_stats64(struct net_device *dev,
 				  struct rtnl_link_stats64 *stats)
 {
 	struct dsa_slave_priv *p = netdev_priv(dev);
-	struct pcpu_sw_netstats *s;
-	unsigned int start;
-	int i;
 
 	netdev_stats_to_stats64(stats, &dev->stats);
-	for_each_possible_cpu(i) {
-		u64 tx_packets, tx_bytes, rx_packets, rx_bytes;
-
-		s = per_cpu_ptr(p->stats64, i);
-		do {
-			start = u64_stats_fetch_begin_irq(&s->syncp);
-			tx_packets = s->tx_packets;
-			tx_bytes = s->tx_bytes;
-			rx_packets = s->rx_packets;
-			rx_bytes = s->rx_bytes;
-		} while (u64_stats_fetch_retry_irq(&s->syncp, start));
-
-		stats->tx_packets += tx_packets;
-		stats->tx_bytes += tx_bytes;
-		stats->rx_packets += rx_packets;
-		stats->rx_bytes += rx_bytes;
-	}
+	dev_fetch_sw_netstats(stats, p->stats64);
 }
 
 static int dsa_slave_get_rxnfc(struct net_device *dev,
-- 
2.28.0


