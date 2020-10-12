Return-Path: <hkallweit1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KFsZNGzDx3aV9CBTy2OuwyFykIUFu3usYnhhVM1hRRA=;
 b=Xmk4y4x522mXEH+Dhh4RrFypK4roS1v/xIOaX0lr0EZq27TaCNE5OZORYclY3v3o2r
 eP3NMqn+4pUQLmpYKg7wehIGmg24sF+V8wC2AYunxZvEsdHiPwZgjNakCons7Yvfss53
 NIxxAZ2kDrjvgpXioN4FIN/07nmPdNNRsCr5/fLGLNriL9DJvJaHtmHcDvpsyN6OCpF3
 g3qvkvaYv+zFlMlI0+trdkTAyYVsOfNQsNYLpPStxXPd4IVqAyUOgOJQi4iACnIndZGZ
 1EJ/k1a3TGNlZxxSlUmVxfqfwo03c6W4uDKplq+kdP0W6/DQ6qrzLOM3ljaQ62jwmr/S
 W8Fg==
From: Heiner Kallweit <hkallweit1@gmail.com>
References: <d77b65de-1793-f808-66b5-aaa4e7c8a8f0@gmail.com>
Message-ID: <0d81e0f7-7784-42df-8e10-d0b77ca5b7ee@gmail.com>
Date: Mon, 12 Oct 2020 10:04:11 +0200
MIME-Version: 1.0
In-Reply-To: <d77b65de-1793-f808-66b5-aaa4e7c8a8f0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH net-next v2 03/12] net: macsec: use new function
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
 drivers/net/macsec.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 2b0c8f01d..11ca5fa90 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3647,30 +3647,10 @@ static int macsec_change_mtu(struct net_device *dev, int new_mtu)
 static void macsec_get_stats64(struct net_device *dev,
 			       struct rtnl_link_stats64 *s)
 {
-	int cpu;
-
 	if (!dev->tstats)
 		return;
 
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


