Return-Path: <jmaxwell37@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=Kxx/F5I4sUf+A88knP4oliNe1NWBRQvTxNuOIgbUQiU=;
	b=gfvtS5dIIWj0R/wIzlUUpcbJE2m7saWeV7VZJty8KmOqpmGlFFUiWzyFSH8WC1QwOV
	BaAXd/sB186WV+i8avTUaer4Crl/927Fj8yUkbBTlE9EwltDBfvRhS2wNk2Ub6a7K83x
	YMCSpj+7z+WHIEmEPHDfRHcqTAYrzG0Hg8cDjxi5PBM0wMPZ8KyZ/a0SIzzyWSKWhh6X
	LOcnKWYY7PC1XWmplIHs7VIi6FU33MuGfkohZOrCJTmhmg0/vro6As6e6EdwCMc1v15g
	MBfJYPVk8huzmiqoE/CYyyoNo6hRAQcdKvSht0jBqKOC6HOPrpniA++lx9HxWL3ZQNzh
	h8Qw==
From: Jon Maxwell <jmaxwell37@gmail.com>
Message-Id: <1399967708-7283-1-git-send-email-jmaxwell@redhat.com>
Subject: [Bridge] [PATCH net] bridge: notify user space of fdb port change
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Tue, 13 May 2014 07:55:48 -0000
To: stephen@networkplumber.org
Cc: vyasevic@redhat.com, jpirko@redhat.com, netdev@vger.kernel.org, jmaxwell@redhat.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jmaxwell37@gmail.com, davem@davemloft.net

From: Jon Maxwell <jmaxwell37@gmail.com>

There has been a number incidents recently where customers running KVM have 
reported that VM hosts on different Hypervisors are unreachable. Based on 
pcap traces we found that the bridge was broadcasting the ARP request out 
onto the network. However some NICs have an inbuilt switch which on occasions 
were broadcasting the VMs ARP request back through the physical NIC on the 
Hypervisor. This resulted in the bridge changing ports and incorrectly learning
that the VMs mac address was external. As a result the ARP reply was directed 
back onto the external network and VM never updated it's ARP cache. This patch 
will notify the bridge command to identify such port toggling.

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
---
 net/bridge/br_fdb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 9203d5a..37742e2 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -507,6 +507,8 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 					source->dev->name);
 		} else {
 			/* fastpath: update of existing entry */
+			if (source->port_no != fdb->dst->port_no)
+				fdb_notify(br, fdb, RTM_NEWNEIGH);
 			fdb->dst = source;
 			fdb->updated = jiffies;
 			if (unlikely(added_by_user))
-- 
1.8.3.1

