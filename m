Return-Path: <hkallweit1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EZ+IbzJK89SwFCG1NFlS+aDcNGqO/ZCcv8sBQgOTnbQ=;
 b=r6+dEJT54fqzUWR5q15h1ohJU7GSqwKNPr0wwYUCR9XCTdLKdbLl/g2lZ0nXs1jQvz
 C3Tv1XZvTVgoZJF6UHs3Oc46DUIMvnDnj7uDDoOFCg2ArDh/KfqcGsd/dCYiNTUEguqh
 SpGuK9so6KztFAnhdlzmi/xYloxnwgRARGt9EymKxkpsWZ5X1E4y5I/3MnmldroXGDYl
 W3dzUuQu//7BXtLGhsrAm16WbAs+JczHD/hob7XjLNoGgReKiCCjGjMTzY/MskbPU2gG
 to+57D9kJ4xDijHR0OplnAMPNUcBg0Y2AmvGHyf8Tc2W2qArQbsfgunDPnK+5uJHVDDQ
 +EbQ==
From: Heiner Kallweit <hkallweit1@gmail.com>
References: <d77b65de-1793-f808-66b5-aaa4e7c8a8f0@gmail.com>
Message-ID: <6cad1a04-f021-d94b-45fd-7cc7cf07367d@gmail.com>
Date: Mon, 12 Oct 2020 10:03:02 +0200
MIME-Version: 1.0
In-Reply-To: <d77b65de-1793-f808-66b5-aaa4e7c8a8f0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH net-next v2 02/12] IB/hfi1: use new function
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
 drivers/infiniband/hw/hfi1/ipoib_main.c | 34 +------------------------
 1 file changed, 1 insertion(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib_main.c b/drivers/infiniband/hw/hfi1/ipoib_main.c
index 014351ebb..9f71b9d70 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_main.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_main.c
@@ -97,41 +97,9 @@ static void hfi1_ipoib_dev_get_stats64(struct net_device *dev,
 				       struct rtnl_link_stats64 *storage)
 {
 	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
-	u64 rx_packets = 0ull;
-	u64 rx_bytes = 0ull;
-	u64 tx_packets = 0ull;
-	u64 tx_bytes = 0ull;
-	int i;
 
 	netdev_stats_to_stats64(storage, &dev->stats);
-
-	for_each_possible_cpu(i) {
-		const struct pcpu_sw_netstats *stats;
-		unsigned int start;
-		u64 trx_packets;
-		u64 trx_bytes;
-		u64 ttx_packets;
-		u64 ttx_bytes;
-
-		stats = per_cpu_ptr(priv->netstats, i);
-		do {
-			start = u64_stats_fetch_begin_irq(&stats->syncp);
-			trx_packets = stats->rx_packets;
-			trx_bytes = stats->rx_bytes;
-			ttx_packets = stats->tx_packets;
-			ttx_bytes = stats->tx_bytes;
-		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
-
-		rx_packets += trx_packets;
-		rx_bytes += trx_bytes;
-		tx_packets += ttx_packets;
-		tx_bytes += ttx_bytes;
-	}
-
-	storage->rx_packets += rx_packets;
-	storage->rx_bytes += rx_bytes;
-	storage->tx_packets += tx_packets;
-	storage->tx_bytes += tx_bytes;
+	dev_fetch_sw_netstats(storage, priv->netstats);
 }
 
 static const struct net_device_ops hfi1_ipoib_netdev_ops = {
-- 
2.28.0


