Return-Path: <andriy.shevchenko@linux.intel.com>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 30 Aug 2018 13:33:18 +0300
Message-Id: <20180830103318.60804-1-andriy.shevchenko@linux.intel.com>
Subject: [Bridge] [PATCH v1] bridge: Switch to bitmap_zalloc()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Switch to bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 net/bridge/br_if.c   | 5 ++---
 net/bridge/br_vlan.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 0363f1bdc401..3bb66508f07d 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -394,8 +394,7 @@ static int find_portno(struct net_bridge *br)
 	struct net_bridge_port *p;
 	unsigned long *inuse;
 
-	inuse = kcalloc(BITS_TO_LONGS(BR_MAX_PORTS), sizeof(unsigned long),
-			GFP_KERNEL);
+	inuse = bitmap_zalloc(BR_MAX_PORTS, GFP_KERNEL);
 	if (!inuse)
 		return -ENOMEM;
 
@@ -404,7 +403,7 @@ static int find_portno(struct net_bridge *br)
 		set_bit(p->port_no, inuse);
 	}
 	index = find_first_zero_bit(inuse, BR_MAX_PORTS);
-	kfree(inuse);
+	bitmap_free(inuse);
 
 	return (index >= BR_MAX_PORTS) ? -EXFULL : index;
 }
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 7df269092103..bb6ba794864f 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -877,8 +877,7 @@ int __br_vlan_set_default_pvid(struct net_bridge *br, u16 pvid)
 		return 0;
 	}
 
-	changed = kcalloc(BITS_TO_LONGS(BR_MAX_PORTS), sizeof(unsigned long),
-			  GFP_KERNEL);
+	changed = bitmap_zalloc(BR_MAX_PORTS, GFP_KERNEL);
 	if (!changed)
 		return -ENOMEM;
 
@@ -925,7 +924,7 @@ int __br_vlan_set_default_pvid(struct net_bridge *br, u16 pvid)
 	br->default_pvid = pvid;
 
 out:
-	kfree(changed);
+	bitmap_free(changed);
 	return err;
 
 err_port:
-- 
2.18.0

