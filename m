Return-Path: <jmaxwell37@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=MDvPqR7ajMGcsISrgX6SFZjKA70n7V4q6Ym2JkJh8KE=;
	b=Cm4kw5oa0sCg/AxxR4pUKB2OmSiPIzLcOXd7No28tC2J0NDF2H7GbkYDM8Y6NxWB/i
	m9jUwiZvP86hk/OXdN+XhKisUfbgHP6UhvlNIxTO6dQihUHKoWq8/kuIYTk65CpOyR17
	DZrDyrdpu4t/GlOslHFGApd21XV4OvHTgck87QftfHvjtMAu8Muu2AZrMURni3d78tbn
	vqp/EYpz2r5pdMB4CDx7MH3ndpU+r47ODHDUHRTLAtsao6/gyXWM+fltZoRhmPokoSU+
	AlB+osHSnxa8wNUOBWgcqL6/TSVm7nktYhU8t+4WCvQAXh0Lud+zxP12+PtmZFGNRPaF
	hz/g==
From: Jon Maxwell <jmaxwell37@gmail.com>
Date: Fri, 16 May 2014 18:08:39 +1000
Message-Id: <1400227719-18403-1-git-send-email-jmaxwell@redhat.com>
Subject: [Bridge] [PATCH net] bridge: notify user space of fdb port change
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org
Cc: vyasevic@redhat.com, jpirko@redhat.com, netdev@vger.kernel.org, jmaxwell@redhat.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jon Maxwell <jmaxwell37@gmail.com>, davem@davemloft.net

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
index 9203d5a..67480c2 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -511,6 +511,8 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 			fdb->updated = jiffies;
 			if (unlikely(added_by_user))
 				fdb->added_by_user = 1;
+			if (unlikely(source->port_no != fdb->dst->port_no))
+				fdb_notify(br, fdb, RTM_NEWNEIGH);
 		}
 	} else {
 		spin_lock(&br->hash_lock);
-- 
1.8.3.1

