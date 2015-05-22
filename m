Return-Path: <cascardo@redhat.com>
From: Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
Date: Fri, 22 May 2015 12:18:59 -0300
Message-Id: <1432307939-19640-1-git-send-email-cascardo@redhat.com>
Subject: [Bridge] [PATCH] bridge: fix parsing of MLDv2 reports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@redhat.com>, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Rik.Theys@esat.kuleuven.be, davem@davemloft.net

When more than a multicast address is present in a MLDv2 report, all but
the first address is ignored, because the code breaks out of the loop if
there has not been an error adding that address.

This has caused failures when two guests connected through the bridge
tried to communicate using IPv6. Neighbor discoveries would not be
transmitted to the other guest when both used a link-local address and a
static address.

This only happens when there is a MLDv2 querier in the network.

The fix will only break out of the loop when there is a failure adding a
multicast address.

The mdb before the patch:

dev ovirtmgmt port vnet0 grp ff02::1:ff7d:6603 temp
dev ovirtmgmt port vnet1 grp ff02::1:ff7d:6604 temp
dev ovirtmgmt port bond0.86 grp ff02::2 temp

After the patch:

dev ovirtmgmt port vnet0 grp ff02::1:ff7d:6603 temp
dev ovirtmgmt port vnet1 grp ff02::1:ff7d:6604 temp
dev ovirtmgmt port bond0.86 grp ff02::fb temp
dev ovirtmgmt port bond0.86 grp ff02::2 temp
dev ovirtmgmt port bond0.86 grp ff02::d temp
dev ovirtmgmt port vnet0 grp ff02::1:ff00:76 temp
dev ovirtmgmt port bond0.86 grp ff02::16 temp
dev ovirtmgmt port vnet1 grp ff02::1:ff00:77 temp
dev ovirtmgmt port bond0.86 grp ff02::1:ff00:def temp
dev ovirtmgmt port bond0.86 grp ff02::1:ffa1:40bf temp

Reported-by: Rik Theys <Rik.Theys@esat.kuleuven.be>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
Tested-by: Rik Theys <Rik.Theys@esat.kuleuven.be>
---
 net/bridge/br_multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 4b6722f..a3abe6e 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1072,7 +1072,7 @@ static int br_ip6_multicast_mld2_report(struct net_bridge *br,
 
 		err = br_ip6_multicast_add_group(br, port, &grec->grec_mca,
 						 vid);
-		if (!err)
+		if (err)
 			break;
 	}
 
-- 
2.4.1

