Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l5JzLPMeSD4caZ4wHfPPZr4JygseWiJe8yzApZMnhOA=;
 b=IO/2p5RcCNDAhlli9hKfGjfbtZuFnkT8KgLMs3Zi0sBS+7izwyFFKIaVLhXo2jDavO
 aoEEYw2QyNqWDGe/x7OPnD/9QBJfvvPFiXxf15E+zuXwDFWJwE4lrtDVWOkguhbDLiUd
 BuRkNDq2SCnQME1WJ59jlFoFsljjh3mNyRkNr5g5GduGropZaZJgTC56+NQgLt/8mnw8
 RohYNHKi6oyrwG3iTpwxSDTnd3gE9+zyyHWqIKjkp1ihPvqglXAxQgvTziuzRVW56YRf
 JsDt3q5DNNijbMoCDXAGy5/W/cwfA7Hyhw9R2zXd/rkefuyZ/BHP3vIN8yCXBNqixoiF
 OEbA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 21 Sep 2020 13:55:19 +0300
Message-Id: <20200921105526.1056983-10-razor@blackwall.org>
In-Reply-To: <20200921105526.1056983-1-razor@blackwall.org>
References: <20200921105526.1056983-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 09/16] net: bridge: mcast: when
	igmpv3/mldv2 are enabled lookup (S, G) first, then (*, G)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

If (S,G) entries are enabled (igmpv3/mldv2) then look them up first. If
there isn't a present (S,G) entry then try to find (*,G).

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index e1fb822b9ddb..4fd690bc848f 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -127,10 +127,28 @@ struct net_bridge_mdb_entry *br_mdb_get(struct net_bridge *br,
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		ip.dst.ip4 = ip_hdr(skb)->daddr;
+		if (br->multicast_igmp_version == 3) {
+			struct net_bridge_mdb_entry *mdb;
+
+			ip.src.ip4 = ip_hdr(skb)->saddr;
+			mdb = br_mdb_ip_get_rcu(br, &ip);
+			if (mdb)
+				return mdb;
+			ip.src.ip4 = 0;
+		}
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case htons(ETH_P_IPV6):
 		ip.dst.ip6 = ipv6_hdr(skb)->daddr;
+		if (br->multicast_mld_version == 2) {
+			struct net_bridge_mdb_entry *mdb;
+
+			ip.src.ip6 = ipv6_hdr(skb)->saddr;
+			mdb = br_mdb_ip_get_rcu(br, &ip);
+			if (mdb)
+				return mdb;
+			memset(&ip.src.ip6, 0, sizeof(ip.src.ip6));
+		}
 		break;
 #endif
 	default:
-- 
2.25.4

