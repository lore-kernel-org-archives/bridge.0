Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xs9gPZTNfwtouWL9L4Nwr/WiYcl05VUqiVfBi+fW7JY=;
 b=G2//UHT/o2c5Z0+ywqgYEJtbnhHs25pOiB5Hi603BHS9wXvsRRDCgkJiKUxbQ0KJDO
 e1Yndcf9jirckWBmIvpPn0gHoyqQB22I4w1kw1kZuePA9nf2fbkR+Ktb0FVFdfLnhunp
 nZmMBKaFi7SwtLDb3fPiIISvtcC1deEyhBZvO9LDTqJhPmQRyugqN6QNg1KRHRhZWegI
 lM3JM3qOesjLASCsNv8loWGV81f8X3jD7lS1lKDPmfvx97Y8lEpIMJ4a/oYOVHqm5SPT
 PqLYo01xDXT1OIuY0lwjOpGVWTYcvho3K2apPsSHaEnG+/fBQNZt9q+qUcmw0XOE2vgv
 Ba5Q==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 20 Jan 2021 16:51:57 +0200
Message-Id: <20210120145203.1109140-9-razor@blackwall.org>
In-Reply-To: <20210120145203.1109140-1-razor@blackwall.org>
References: <20210120145203.1109140-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 08/14] net: bridge: multicast: add EHT
	host delete function
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

Now that we can delete set entries, we can use that to remove EHT hosts.
Since the group's host set entries exist only when there are related
source set entries we just have to flush all source set entries
joined by the host set entry and it will be automatically removed.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast_eht.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/bridge/br_multicast_eht.c b/net/bridge/br_multicast_eht.c
index f4bbf2dc9fc8..409fced7eae2 100644
--- a/net/bridge/br_multicast_eht.c
+++ b/net/bridge/br_multicast_eht.c
@@ -434,3 +434,20 @@ static bool br_multicast_del_eht_set_entry(struct net_bridge_port_group *pg,
 out:
 	return set_deleted;
 }
+
+static void br_multicast_del_eht_host(struct net_bridge_port_group *pg,
+				      union net_bridge_eht_addr *h_addr)
+{
+	struct net_bridge_group_eht_set_entry *set_h;
+	struct net_bridge_group_eht_host *eht_host;
+	struct hlist_node *tmp;
+
+	eht_host = br_multicast_eht_host_lookup(pg, h_addr);
+	if (!eht_host)
+		return;
+
+	hlist_for_each_entry_safe(set_h, tmp, &eht_host->set_entries, host_list)
+		br_multicast_del_eht_set_entry(set_h->eht_set->pg,
+					       &set_h->eht_set->src_addr,
+					       &set_h->h_addr);
+}
-- 
2.29.2

