Return-Path: <hkallweit1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=11y0pgG7aEVp4MN5bK5igJeBve2DHauuUJfvXQcU/cQ=;
 b=S7Yhz7FN4RrMaWZm062rjZtizkHtS2nV//ChDYOYkWaZc2/x3cEdl0rYtGoalmayEv
 l6AXRWI4xAJDVQC++R7i4AUWeE9nt3IDlOsLJfhNz/n0nROqitAsJb1eMMW0Yhfeyapq
 qMxH65BqWerBKZ4RgZ9KNhyYwXdUKGtBcQJnmk0ChQ/rARn80X/hhBRogAcNMNwiCk1R
 WCL9mXtmyKYZletsrxv5wKAuFEwNw0sfn4YhHnyFiqudQ0WPzB9n0wZfD0dXd67mpvtu
 OQJX97FsIVmi7NonufBQle/Iu1kSzfxG+Pr4jFLedyLWzd079oE6JpWXdDobDiqzrc4Z
 L9qQ==
From: Heiner Kallweit <hkallweit1@gmail.com>
References: <a46f539e-a54d-7e92-0372-cd96bb280729@gmail.com>
Message-ID: <5bb71143-0dac-c413-7e97-50eed8a57862@gmail.com>
Date: Sun, 11 Oct 2020 21:36:43 +0200
MIME-Version: 1.0
In-Reply-To: <a46f539e-a54d-7e92-0372-cd96bb280729@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH net-next 01/12] net: core: add function
 dev_fetch_sw_netstats for fetching pcpu_sw_netstats
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

In several places the same code is used to populate rtnl_link_stats64
fields with data from pcpu_sw_netstats. Therefore factor out this code
to a new function dev_fetch_sw_netstats().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a0df43b13..ca4736349 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4495,6 +4495,8 @@ struct rtnl_link_stats64 *dev_get_stats(struct net_device *dev,
 					struct rtnl_link_stats64 *storage);
 void netdev_stats_to_stats64(struct rtnl_link_stats64 *stats64,
 			     const struct net_device_stats *netdev_stats);
+void dev_fetch_sw_netstats(struct rtnl_link_stats64 *s,
+			   struct pcpu_sw_netstats __percpu *netstats);
 
 extern int		netdev_max_backlog;
 extern int		netdev_tstamp_prequeue;
diff --git a/net/core/dev.c b/net/core/dev.c
index 7d18560b2..ba91bf16b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10323,6 +10323,42 @@ struct rtnl_link_stats64 *dev_get_stats(struct net_device *dev,
 }
 EXPORT_SYMBOL(dev_get_stats);
 
+/**
+ *	dev_fetch_sw_netstats - get per-cpu network device statistics
+ *	@s: place to store stats
+ *	@netstats: per-cpu network stats to read from
+ *
+ *	Read per-cpu network statistics and populate the related fields in s.
+ */
+void dev_fetch_sw_netstats(struct rtnl_link_stats64 *s,
+			   struct pcpu_sw_netstats __percpu *netstats)
+{
+	int cpu;
+
+	if (IS_ERR_OR_NULL(netstats))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct pcpu_sw_netstats *stats, tmp;
+		unsigned int start;
+
+		stats = per_cpu_ptr(netstats, cpu);
+		do {
+			start = u64_stats_fetch_begin_irq(&stats->syncp);
+			tmp.rx_packets = stats->rx_packets;
+			tmp.rx_bytes   = stats->rx_bytes;
+			tmp.tx_packets = stats->tx_packets;
+			tmp.tx_bytes   = stats->tx_bytes;
+		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
+
+		s->rx_packets += tmp.rx_packets;
+		s->rx_bytes   += tmp.rx_bytes;
+		s->tx_packets += tmp.tx_packets;
+		s->tx_bytes   += tmp.tx_bytes;
+	}
+}
+EXPORT_SYMBOL(dev_fetch_sw_netstats);
+
 struct netdev_queue *dev_ingress_queue_create(struct net_device *dev)
 {
 	struct netdev_queue *queue = dev_ingress_queue(dev);
-- 
2.28.0


