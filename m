Return-Path: <hkallweit1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gfr3ALYPLKmxZda8jB3ld1N0hpEXjoqgwocV8/nd3X0=;
 b=UbL1GtjqXIjEGis5eM/8DwyMsHni206CGfZbq8bJ4Cq/dPqLWTpDUaxfFfzUN/NQ0R
 WNmYW3qdxh0pnWXQaoDe1nChSTIh6UTJ1SUMKcaQwRu7tQHbnHMJYc9b60vNWy4nh2aR
 39ZLS52ZJ30L2HF+21PL5XB8xlAqyxKt0lsCWZO9rcVudZySuROSZS34XHNWL3VL6POI
 W9VRr+t4S9PS8gPdJ6DjdYR+h3OE9rx1F5wr5xgIPwYgalHlaXejI9sL//flzgCHykQy
 G2u1erqZ9fsK4FIHDpNBHaAuHIFP5hkKTLCqnvVJlEoUoVZHPXw9YfD1SP1dRKmk2vw8
 oFFw==
From: Heiner Kallweit <hkallweit1@gmail.com>
References: <a46f539e-a54d-7e92-0372-cd96bb280729@gmail.com>
Message-ID: <7debf7e5-ea7f-6fec-4f58-7dd6c8f28b7b@gmail.com>
Date: Sun, 11 Oct 2020 21:43:18 +0200
MIME-Version: 1.0
In-Reply-To: <a46f539e-a54d-7e92-0372-cd96bb280729@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH net-next 11/12] net: openvswitch: use new function
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
 net/openvswitch/vport-internal_dev.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index d8fe66eea..1e30d8df3 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -86,31 +86,13 @@ static void internal_dev_destructor(struct net_device *dev)
 static void
 internal_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
 {
-	int i;
-
 	memset(stats, 0, sizeof(*stats));
 	stats->rx_errors  = dev->stats.rx_errors;
 	stats->tx_errors  = dev->stats.tx_errors;
 	stats->tx_dropped = dev->stats.tx_dropped;
 	stats->rx_dropped = dev->stats.rx_dropped;
 
-	for_each_possible_cpu(i) {
-		const struct pcpu_sw_netstats *percpu_stats;
-		struct pcpu_sw_netstats local_stats;
-		unsigned int start;
-
-		percpu_stats = per_cpu_ptr(dev->tstats, i);
-
-		do {
-			start = u64_stats_fetch_begin_irq(&percpu_stats->syncp);
-			local_stats = *percpu_stats;
-		} while (u64_stats_fetch_retry_irq(&percpu_stats->syncp, start));
-
-		stats->rx_bytes         += local_stats.rx_bytes;
-		stats->rx_packets       += local_stats.rx_packets;
-		stats->tx_bytes         += local_stats.tx_bytes;
-		stats->tx_packets       += local_stats.tx_packets;
-	}
+	dev_fetch_sw_netstats(stats, dev->tstats);
 }
 
 static const struct net_device_ops internal_dev_netdev_ops = {
-- 
2.28.0


