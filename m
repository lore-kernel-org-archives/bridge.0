Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A931AF3B
	for <bridge@lists.linux.dev>; Mon,  2 Mar 2026 05:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772430056; cv=none; b=EvkIGuHv9tyEnXDADPQKxDv+vp7mSTYJoROd5K2TqQEOb3zXuUczLesfXABJyRbcYIHeX1ElBd7QQmzwz2i6pfH+w5oJ6w15UfKUHn9HT+faJ054OiFU66HuXBmA2X7PnzKcGy04grIU5x23c00JKkdFTAE0c2iUCt3vXfCXFhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772430056; c=relaxed/simple;
	bh=k5Gk/DugD0TKb8YNcg1MHItBqPkD1zzJOL6JuP0Wamo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwIDdRwPOf8eoDeWjXCYbK22IJU5JUNV3Fb/zLeBDEDwNG8knxbcEln/jcyDgY1UyD7NVTUsfomr1VLsYACAKo4a75n+snN6CDNSnIV9jPLpjiGmTJVkPPeeaRjjPlu867ojA6hqpvCPILkNxhIKRgm3cQgBvq2hJNd6+NpKhwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C6B654CC6A;
	Mon,  2 Mar 2026 06:40:53 +0100 (CET)
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
Subject: [PATCH net-next v3 09/14] net: bridge: mcast: track active state, VLAN snooping
Date: Mon,  2 Mar 2026 06:40:03 +0100
Message-ID: <20260302054008.21638-10-linus.luessing@c0d3.blue>
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

If VLAN aware multicast snooping is enabled then we need to perform a
few extra checks to figure out if multicast snooping is actually enabled
for a specific VLAN, as there is then an additional per VLAN multicast
snooping toggle.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 7887ed9af53a..02981bcbc389 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1138,9 +1138,31 @@ static void br_multicast_update_active(struct net_bridge_mcast *brmctx)
 
 	lockdep_assert_held_once(&brmctx->br->multicast_lock);
 
-	if (!br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED))
+	if (!br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED)) {
 		force_inactive = true;
+		goto update;
+	}
 
+	if (br_opt_get(brmctx->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
+		/* with per-vlan snooping enabled there is an extra per-vlan
+		 * toggle to enable/disable snooping which we must check
+		 */
+		if (br_multicast_ctx_vlan_global_disabled(brmctx))
+			force_inactive = true;
+		/* with per-vlan snooping enabled the non-vlan multicast
+		 * snooping context is inactive
+		 */
+		else if (!br_multicast_ctx_is_vlan(brmctx))
+			force_inactive = true;
+	} else {
+		/* with per-vlan snooping disabled a vlan multicast
+		 * snooping context is inactive
+		 */
+		if (br_multicast_ctx_is_vlan(brmctx))
+			force_inactive = true;
+	}
+
+update:
 	br_ip4_multicast_update_active(brmctx, force_inactive);
 	br_ip6_multicast_update_active(brmctx, force_inactive);
 
@@ -4479,6 +4501,7 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 
 		spin_lock_bh(&br->multicast_lock);
 		vlan->priv_flags ^= BR_VLFLAG_MCAST_ENABLED;
+		br_multicast_update_active(&vlan->br_mcast_ctx);
 
 		if (on)
 			__br_multicast_open(&vlan->br_mcast_ctx);
-- 
2.51.0

