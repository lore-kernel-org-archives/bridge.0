From: Vitaly Demyanec <vitas@nppfactor.kiev.ua>
Date: Wed, 27 May 2009 21:36:37 +0300
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200905272136.37913.vitas@nppfactor.kiev.ua>
Subject: [Bridge] (revived) use the maximum hard_header_len of ports for
	bridging device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I want to get back to the (not so) old discussion about this patch:
http://www.mail-archive.com/bridge@lists.linux-foundation.org/msg00895.html

At the end of the discussion David Miller rejected this Li's patch with such 
arguments:
http://www.mail-archive.com/bridge@lists.linux-foundation.org/msg00907.html
DM>Because as Stephen showed it didn't handle all cases.
DM>Look at the patch I posted, that's the way to go.

David's patch can be viewed here:
http://www.mail-archive.com/bridge@lists.linux-foundation.org/msg00902.html

I want to revive the discussion with such objections:
1) Yes, the Li's patch doesn't handle all cases, but it handle the obvious 
case of locally generated packets. Why should bridge-master interface reserve 
less space then needed by one of its ports? As for me it is naturally for 
bridge-master reserve the maximum required headroom to match requirements of 
all its ports. This patch was not intended to handle all cases, only 
the "locally generated packets" one... 
2) The David's patch dynamically computes the needed space for bridged (not 
locally generated) packets. So, these two patches are not mutually exclusive. 
I'd rather say, they complement each other.

So, I vote for the Li's patch to be reviewed again.
I should say that I encountered similar case where bridged port's driver needs 
more headroom than ETH_HLEN, and this patch saves me cpu cycles from 
unnecessary skb reallocation (in most cases).

Signed-off-by: Li Yang <leoli at freescale.com>
---
Use the maximum hard_header_len of ports for bridging device

diff -ur a/net/bridge/br_if.c b/net/bridge/br_if.c
--- a/net/bridge/br_if.c	2009-05-27 21:15:49.000000000 +0300
+++ b/net/bridge/br_if.c	2009-05-27 21:15:32.000000000 +0300
@@ -344,12 +344,16 @@
 {
 	struct net_bridge_port *p;
 	unsigned long features;
+	unsigned short max_hard_header_len = ETH_HLEN;
 
 	features = br->feature_mask;
 
 	list_for_each_entry(p, &br->port_list, list) {
 		features = netdev_compute_features(features, p->dev->features);
+		if (p->dev->hard_header_len > max_hard_header_len)
+			max_hard_header_len = p->dev->hard_header_len;
 	}
+	br->dev->hard_header_len = max_hard_header_len;
 
 	br->dev->features = features;
 }

-- 
With Best Regards,
Vitaly Demyanec
