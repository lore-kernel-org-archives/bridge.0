Return-Path: <jmaxwell37@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=sp7H8vuzYpe9xUZVlnNqNXLk3i66qC9wNZWP7Sn1Uwc=;
	b=PGAaN3HqEhWUycZ9sICZKh2FaFKmIFD2mDSDRFGH6D54piEkI0UY5HyIbQXi4Lq+/g
	udV01hVqbFCYC64qeQfxrR3oFU7k5lTuyzOIjSUSoowqcpWx8Ip9uf3qzKeh5yVHobW/
	nVNomamgPkMtimUjgEMNREUrNlPhhYpEnHoP6elNuAw7Y2OuFhvFe2tJ3q5UKhT7ZoxK
	AWczum7yt5J/FcqK8LtLdpyg2wEpRluayMPrJc3eQ6EJGIIsz0/DL40oWwiM01xw8NyK
	KaFtwl2G7+4JCkkcbTDwb5u+sRzxHn4Dm0wZtr9OhHSxbvPjIm34zFIq5DvLhDefdsk2
	GL3g==
From: Jon Maxwell <jmaxwell37@gmail.com>
Message-Id: <1399238974-6210-1-git-send-email-jmaxwell@redhat.com>
Subject: [Bridge] [PATCH net] bridge: Add port flap detection
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Sun, 04 May 2014 21:29:50 -0000
To: netdev@vger.kernel.org
Cc: vyasevic@redhat.com, jmaxwell@redhat.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, stephen@networkplumber.org, pirko@redhat.com, davem@davemloft.net

There has been a number incidents recently where customers running KVM have reported that VM hosts on different Hypervisors are unreachable. Based on pcap traces we found that the bridge was broadcasting the ARP request out onto the network. However some NICs have an inbuilt switch which on occasions were broadcasting the VMs ARP request back through the physical NIC on the Hypervisor. This resulted in the bridge flapping ports and incorrectly learning that the VMs mac address was external. As a result the ARP reply was directed back onto the external network and VM never updated it's ARP cache. This patch will detect port flapping and log a message so that this condition can be detected earlier.

Signed-off-by: Jon Maxwell <jmaxwell@redhat.com>
---
 net/bridge/br_fdb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 9203d5a..c08607b 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -507,6 +507,13 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 					source->dev->name);
 		} else {
 			/* fastpath: update of existing entry */
+			if (source->port_no != fdb->dst->port_no &&
+				net_ratelimit())
+				br_warn(br, "Port flapping detected source entry dev = %s mac = %pM, port_no = %d\n existing entry dev = %s mac = %pM, port_no = %d\n",
+					source->dev->name,
+					addr, source->port_no,
+					fdb->dst->dev->name, addr,
+					fdb->dst->port_no);
 			fdb->dst = source;
 			fdb->updated = jiffies;
 			if (unlikely(added_by_user))
-- 
1.8.3.1

