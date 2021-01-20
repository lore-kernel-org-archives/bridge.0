Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p5jQkPW1oWI+QtE/SUX8LB8Nxke3Xa1Ja5TR15s8XBM=;
 b=VSto+BBrYtccrmzfvgYqjDw9lTCwY0paFkZ1TEzTvkPzpIYFTGfGGX5zTXZUuApSg4
 yaEdm+2EOjXox5cfKTbZH8v6dCmVtBeKFcwjNHnerEdXmCWOfSMd/t6jNo/g67fJ3MSI
 L0J1xJVOPZX5qrQ3YPCq8aTGyfoMdSj/6WwbFm0kPbq7hKm3VqOamo5R7GN9fQX/GGCX
 qYyoM7cD1zWlkZvnClNbT32r1mv7eG+UOBjsKtLAtuozUl6+RAor8tGMFYqLFRs9DnnR
 DzRPjBH0sZqVwUN7soCQfZORcd4ga/h7G4ZXabOM47ExgHKiI7lBVKq+xd9jiI2kV8Zh
 OGyA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 20 Jan 2021 16:52:01 +0200
Message-Id: <20210120145203.1109140-13-razor@blackwall.org>
In-Reply-To: <20210120145203.1109140-1-razor@blackwall.org>
References: <20210120145203.1109140-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 12/14] net: bridge: multicast: add EHT
	host filter_mode handling
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

We should be able to handle host filter mode changing. For exclude mode
we must create a zero-src entry so the group will be kept even without
any S,G entries (non-zero source sets). That entry doesn't count to the
entry limit and can always be created, its timer is refreshed on new
exclude reports and if we change the host filter mode to include then it
gets removed and we rely only on the non-zero source sets.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast_eht.c | 42 +++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_multicast_eht.c b/net/bridge/br_multicast_eht.c
index fee3060d0495..64ccbd4ae9d9 100644
--- a/net/bridge/br_multicast_eht.c
+++ b/net/bridge/br_multicast_eht.c
@@ -381,6 +381,30 @@ static void br_multicast_ip_src_to_eht_addr(const struct br_ip *src,
 	}
 }
 
+static void br_eht_convert_host_filter_mode(struct net_bridge_port_group *pg,
+					    union net_bridge_eht_addr *h_addr,
+					    int filter_mode)
+{
+	struct net_bridge_group_eht_host *eht_host;
+	union net_bridge_eht_addr zero_addr;
+
+	eht_host = br_multicast_eht_host_lookup(pg, h_addr);
+	if (eht_host)
+		eht_host->filter_mode = filter_mode;
+
+	memset(&zero_addr, 0, sizeof(zero_addr));
+	switch (filter_mode) {
+	case MCAST_INCLUDE:
+		br_multicast_del_eht_set_entry(pg, &zero_addr, h_addr);
+		break;
+	case MCAST_EXCLUDE:
+		br_multicast_create_eht_set_entry(pg, &zero_addr, h_addr,
+						  MCAST_EXCLUDE,
+						  true);
+		break;
+	}
+}
+
 static void br_multicast_create_eht_set_entry(struct net_bridge_port_group *pg,
 					      union net_bridge_eht_addr *src_addr,
 					      union net_bridge_eht_addr *h_addr,
@@ -701,8 +725,13 @@ static bool br_multicast_eht_inc(struct net_bridge_port_group *pg,
 				 size_t addr_size,
 				 bool to_report)
 {
-	return __eht_inc_exc(pg, h_addr, srcs, nsrcs, addr_size, MCAST_INCLUDE,
-			     to_report);
+	bool changed;
+
+	changed = __eht_inc_exc(pg, h_addr, srcs, nsrcs, addr_size,
+				MCAST_INCLUDE, to_report);
+	br_eht_convert_host_filter_mode(pg, h_addr, MCAST_INCLUDE);
+
+	return changed;
 }
 
 static bool br_multicast_eht_exc(struct net_bridge_port_group *pg,
@@ -712,8 +741,13 @@ static bool br_multicast_eht_exc(struct net_bridge_port_group *pg,
 				 size_t addr_size,
 				 bool to_report)
 {
-	return __eht_inc_exc(pg, h_addr, srcs, nsrcs, addr_size, MCAST_EXCLUDE,
-			     to_report);
+	bool changed;
+
+	changed = __eht_inc_exc(pg, h_addr, srcs, nsrcs, addr_size,
+				MCAST_EXCLUDE, to_report);
+	br_eht_convert_host_filter_mode(pg, h_addr, MCAST_EXCLUDE);
+
+	return changed;
 }
 
 static bool __eht_ip4_handle(struct net_bridge_port_group *pg,
-- 
2.29.2

