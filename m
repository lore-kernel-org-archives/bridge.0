From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20110422163116.3C5C3138DD@rere.qmqm.pl>
Date: Fri, 22 Apr 2011 18:31:16 +0200 (CEST)
Subject: [Bridge] [PATCH] net: fix netdev_increment_features()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Ben Hutchings <bhutchings@solarflare.com>, bridge@lists.linux-foundation.org, Jay Vosburgh <fubar@us.ibm.com>

Simplify and fix netdev_increment_features() to conform to what is
stated in netdevice.h comments about NETIF_F_ONE_FOR_ALL.
Include FCoE segmentation and VLAN-challedged flags in computation.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---

I noticed this while converting bridge code to hw_features. After
adding devices to the bridge all features were always cleared regardless
of features active in those devices.

 include/linux/netdevice.h |    7 ++++++-
 net/core/dev.c            |   37 ++++++++++++-------------------------
 2 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 405ce21..86140e4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1107,7 +1107,12 @@ struct net_device {
 	 */
 #define NETIF_F_ONE_FOR_ALL	(NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ROBUST | \
 				 NETIF_F_SG | NETIF_F_HIGHDMA |		\
-				 NETIF_F_FRAGLIST)
+				 NETIF_F_FRAGLIST | NETIF_F_VLAN_CHALLENGED)
+	/*
+	 * If one device doesn't support one of these features, then disable it
+	 * for all in netdev_increment_features.
+	 */
+#define NETIF_F_ALL_FOR_ALL	(NETIF_F_NOCACHE_COPY | NETIF_F_FSO)
 
 	/* changeable features with no special hardware requirements */
 #define NETIF_F_SOFT_FEATURES	(NETIF_F_GSO | NETIF_F_GRO)
diff --git a/net/core/dev.c b/net/core/dev.c
index 3871bf6..1a2c91c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6184,33 +6184,20 @@ static int dev_cpu_callback(struct notifier_block *nfb,
  */
 u32 netdev_increment_features(u32 all, u32 one, u32 mask)
 {
+	if (mask & NETIF_F_GEN_CSUM)
+		mask |= NETIF_F_ALL_CSUM;
+	mask |= NETIF_F_VLAN_CHALLENGED;
+
+	all |= one & (NETIF_F_ONE_FOR_ALL|NETIF_F_ALL_CSUM) & mask;
+	all &= one | ~NETIF_F_ALL_FOR_ALL;
+
 	/* If device needs checksumming, downgrade to it. */
-	if (all & NETIF_F_NO_CSUM && !(one & NETIF_F_NO_CSUM))
-		all ^= NETIF_F_NO_CSUM | (one & NETIF_F_ALL_CSUM);
-	else if (mask & NETIF_F_ALL_CSUM) {
-		/* If one device supports v4/v6 checksumming, set for all. */
-		if (one & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM) &&
-		    !(all & NETIF_F_GEN_CSUM)) {
-			all &= ~NETIF_F_ALL_CSUM;
-			all |= one & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
-		}
+	if (all & (NETIF_F_ALL_CSUM & ~NETIF_F_NO_CSUM))
+		all &= ~NETIF_F_NO_CSUM;
 
-		/* If one device supports hw checksumming, set for all. */
-		if (one & NETIF_F_GEN_CSUM && !(all & NETIF_F_GEN_CSUM)) {
-			all &= ~NETIF_F_ALL_CSUM;
-			all |= NETIF_F_HW_CSUM;
-		}
-	}
-
-	/* If device can't no cache copy, don't do for all */
-	if (!(one & NETIF_F_NOCACHE_COPY))
-		all &= ~NETIF_F_NOCACHE_COPY;
-
-	one |= NETIF_F_ALL_CSUM;
-
-	one |= all & NETIF_F_ONE_FOR_ALL;
-	all &= one | NETIF_F_LLTX | NETIF_F_GSO | NETIF_F_UFO;
-	all |= one & mask & NETIF_F_ONE_FOR_ALL;
+	/* If one device supports hw checksumming, set for all. */
+	if (all & NETIF_F_GEN_CSUM)
+		all &= ~(NETIF_F_ALL_CSUM & ~NETIF_F_GEN_CSUM);
 
 	return all;
 }
-- 
1.7.2.5

