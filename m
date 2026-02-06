Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD892D0C79
	for <bridge@lists.linux.dev>; Fri,  6 Feb 2026 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346905; cv=none; b=IJ/WQgxXsQdUGlLuKDqXsanBq9BePZ4Ccg/UNJrVq3nOG7ehes0Nj8RLEKWpLYaSDn/OFBZuHZ/pxjL/VebU7O55+35fQKfaeZno66A6N4FP/HT8LdTlV8L7uzDV425QGOWyxplZ8hoEMb5eved2n01apuDS1j7c/VOurSlRgHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346905; c=relaxed/simple;
	bh=wUKn8n14dinrn3FJum6dCEkusLQhrS5JLcrSjifh004=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqOrYRNVp4K7aZ0Wo1OYnEvig80fK5G3epyctBLoR1xqYGzeqAn+RVHNpYFR41rEqanBU0lXZGliPI6tzFE7uH1s9405h4EjXtxNIZ9ZCnN5Lyfm8R5+HF5T9/R1tbi7M/Jo7IHuKQ9KmZZskO4LHxuF2KLR2A1Cy1HumgS7How=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D17D54CCE1;
	Fri,  6 Feb 2026 04:01:42 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next v2 06/14] net: bridge: mcast: track active state, IPv6 address availability
Date: Fri,  6 Feb 2026 03:52:12 +0100
Message-ID: <20260206030123.5430-7-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206030123.5430-1-linus.luessing@c0d3.blue>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

If we are the only potential MLD querier but don't have an IPv6
link-local address configured on our bridge interface then we can't
create a valid MLD query and in turn can't reliably receive MLD reports
and can't build a complete MDB. Hence disable the new multicast active
state variable then. Or reenable it if an IPv6 link-local address
became available.

No functional change for the fast/data path yet.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 0fc29875db9c..a1cde2ba2a3e 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1125,6 +1125,7 @@ static void br_multicast_notify_active(struct net_bridge_mcast *brmctx,
  * The multicast active state is set, per protocol family, if:
  *
  * - an IGMP/MLD querier is present
+ * - for own IPv6 MLD querier: an IPv6 address is configured on the bridge
  *
  * And is unset otherwise.
  *
@@ -1222,10 +1223,12 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
 			       &ip6h->daddr, 0, &ip6h->saddr)) {
 		kfree_skb(skb);
 		br_opt_toggle(brmctx->br, BROPT_HAS_IPV6_ADDR, false);
+		br_multicast_update_active(brmctx);
 		return NULL;
 	}
 
 	br_opt_toggle(brmctx->br, BROPT_HAS_IPV6_ADDR, true);
+	br_multicast_update_active(brmctx);
 	ipv6_eth_mc_map(&ip6h->daddr, eth->h_dest);
 
 	hopopt = (u8 *)(ip6h + 1);
-- 
2.51.0

