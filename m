Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCCB317159
	for <bridge@lists.linux.dev>; Mon,  2 Mar 2026 05:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772430054; cv=none; b=B17YYC7AW10gmEao9+akZEqfwOsXIEA9XnFSmTj+C4mY4CsWILpwrjm5S99/KsCKFSBlMtgx84HaOzpHqALaSV/W2TZb1nUPQ8xSbKlr1HMMINjeV1XyfTTZF3a3xGLL4slJqEmBPtf0M66cXRDRuyFRHtbelPoLQYI1jBw4yKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772430054; c=relaxed/simple;
	bh=mxtKwzhqyehoPNgZs5UxSR6JsnKb6vAGvUm2j0rpxbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvO2dSiEboFknE0ZhNdA1JR1xgQz0AXuLFQDY4k61yLPJeqy73MYF8TvPGdAhDtWZ+NNlKVpnWN5aoMm6GrYjbgRteQgt1rErXsO+bOO1fZZ0YHQm+wpir9wuSM2iapt6EGxpkU6Esg3oUP+b1208EpUUH5LyJXJWz8cSBIVhYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB25554CC65;
	Mon,  2 Mar 2026 06:40:48 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
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
	shuah@kernel.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next v3 06/14] net: bridge: mcast: track active state, IPv6 address availability
Date: Mon,  2 Mar 2026 06:40:00 +0100
Message-ID: <20260302054008.21638-7-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302054008.21638-1-linus.luessing@c0d3.blue>
References: <20260302054008.21638-1-linus.luessing@c0d3.blue>
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
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_multicast.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index b05f00b4d832..12be40a1d0a2 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1123,6 +1123,7 @@ static void br_multicast_notify_active(struct net_bridge_mcast *brmctx,
  * The multicast active state is set, per protocol family, if:
  *
  * - an IGMP/MLD querier is present
+ * - for own IPv6 MLD querier: an IPv6 link-local address is configured on the bridge
  *
  * And is unset otherwise.
  *
@@ -1220,10 +1221,12 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
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

