Return-Path: <hkallweit1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sVZWFKmWX+WTmfjlAyUC3V6edudq39GypRePR5bJKiI=;
 b=C8xvNbM+J7NKyEsbDZKiT8wqKhDzG1DFSSWlnrqPaai0Klv4u9p1zLokAKzvkxFwWp
 zO2dkU1AsYfjQWsCvKmHA/Umrz4lQuwDVoZbNLIM1uc/OHlpSqGR2avkysv2IPZbmtFY
 EUoeHDUxGsRKq3XKvExP6ZRH3KjwfwPI3+L0y2ABlu4NYIkjCozJ32JDRRjFMGYQul+K
 1Ia8AZLZdMeNkGuLeSe1XbRtZ9YRMCbBdorm/KGI7i3sHpoJq6w2Ym7s4Vmv5IjHykPT
 NFqvGj3F79yfbFktAU8x/oRbKmOI4pHJUFSlHJLA8YqOAoJbM4xIjkxlLZT5J9M7bkUG
 PQrg==
From: Heiner Kallweit <hkallweit1@gmail.com>
References: <a46f539e-a54d-7e92-0372-cd96bb280729@gmail.com>
Message-ID: <26abd317-928e-3e52-698c-6b5feca2072f@gmail.com>
Date: Sun, 11 Oct 2020 21:38:05 +0200
MIME-Version: 1.0
In-Reply-To: <a46f539e-a54d-7e92-0372-cd96bb280729@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH net-next 03/12] net: macsec: use new function
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
 drivers/net/macsec.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 2b0c8f01d..e74483279 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3647,30 +3647,7 @@ static int macsec_change_mtu(struct net_device *dev, int new_mtu)
 static void macsec_get_stats64(struct net_device *dev,
 			       struct rtnl_link_stats64 *s)
 {
-	int cpu;
-
-	if (!dev->tstats)
-		return;
-
-	for_each_possible_cpu(cpu) {
-		struct pcpu_sw_netstats *stats;
-		struct pcpu_sw_netstats tmp;
-		int start;
-
-		stats = per_cpu_ptr(dev->tstats, cpu);
-		do {
-			start = u64_stats_fetch_begin_irq(&stats->syncp);
-			tmp.rx_packets = stats->rx_packets;
-			tmp.rx_bytes   = stats->rx_bytes;
-			tmp.tx_packets = stats->tx_packets;
-			tmp.tx_bytes   = stats->tx_bytes;
-		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
-
-		s->rx_packets += tmp.rx_packets;
-		s->rx_bytes   += tmp.rx_bytes;
-		s->tx_packets += tmp.tx_packets;
-		s->tx_bytes   += tmp.tx_bytes;
-	}
+	dev_fetch_sw_netstats(s, dev->tstats);
 
 	s->rx_dropped = dev->stats.rx_dropped;
 	s->tx_dropped = dev->stats.tx_dropped;
-- 
2.28.0


