Return-Path: <hkallweit1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=K5p6PQe9PHlb+DeFu3qCLN+dyNKfD6AR/iCNZWeTJCc=;
 b=u6vzQZjpjUwAoxgsdIvqGoW2wscsD+27fYStwCH0/DAdwWm40pGzmqma6NZfzR2nY4
 FraHh5xiK/XNO/MGkH2q10HSSExTebIq4cBbJ5G0a+fA1d5/0R0JL0xHn2iWHdC4cXjh
 3zcrCQJXT974X8B2at1b6ft2C7z6Wni/rrcSNWwAS16OOfclGUAxh3qlA5QQYpmDMr5+
 SBfTMY55MMCVP6q9lIzHYl9Lf8zxTCzI/ADBY5mYJYrF0q9NQxICntDL6447ROzmLpbJ
 ccZIbeOlF2Vt9eZEOvuJCUrmFAhAZZYOBEGA6EH4/cDWprQdM7QP/i/4RE/eeApna4oe
 wlwA==
From: Heiner Kallweit <hkallweit1@gmail.com>
References: <d77b65de-1793-f808-66b5-aaa4e7c8a8f0@gmail.com>
Message-ID: <d1c3ff29-5691-9d54-d164-16421905fa59@gmail.com>
Date: Mon, 12 Oct 2020 10:15:22 +0200
MIME-Version: 1.0
In-Reply-To: <d77b65de-1793-f808-66b5-aaa4e7c8a8f0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH net-next v2 07/12] net: bridge: use new function
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
 net/bridge/br_device.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 9a2fb4aa1..6f742fee8 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -206,27 +206,8 @@ static void br_get_stats64(struct net_device *dev,
 			   struct rtnl_link_stats64 *stats)
 {
 	struct net_bridge *br = netdev_priv(dev);
-	struct pcpu_sw_netstats tmp, sum = { 0 };
-	unsigned int cpu;
-
-	for_each_possible_cpu(cpu) {
-		unsigned int start;
-		const struct pcpu_sw_netstats *bstats
-			= per_cpu_ptr(br->stats, cpu);
-		do {
-			start = u64_stats_fetch_begin_irq(&bstats->syncp);
-			memcpy(&tmp, bstats, sizeof(tmp));
-		} while (u64_stats_fetch_retry_irq(&bstats->syncp, start));
-		sum.tx_bytes   += tmp.tx_bytes;
-		sum.tx_packets += tmp.tx_packets;
-		sum.rx_bytes   += tmp.rx_bytes;
-		sum.rx_packets += tmp.rx_packets;
-	}
 
-	stats->tx_bytes   = sum.tx_bytes;
-	stats->tx_packets = sum.tx_packets;
-	stats->rx_bytes   = sum.rx_bytes;
-	stats->rx_packets = sum.rx_packets;
+	dev_fetch_sw_netstats(stats, br->stats);
 }
 
 static int br_change_mtu(struct net_device *dev, int new_mtu)
-- 
2.28.0


