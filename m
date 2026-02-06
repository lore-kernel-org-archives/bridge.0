Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C01829B20D
	for <bridge@lists.linux.dev>; Fri,  6 Feb 2026 03:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346909; cv=none; b=M3WA/+9BiDNczGo/dT1kEYq3F03+uC+DKGeMHmSm/qDN7zIfj9Yuxvo9varuR36AJlTGXH0BehVWomeoc0SvHRq8sj7z8nJEQI7PW00ATigXIIlq+J7eb6PYpJuy09IlXZwjxlb5vmXCU+loXkzaaN+gh0U13qzD93vG8OinzCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346909; c=relaxed/simple;
	bh=Zr2wUGGxgg6vS/lNV+TUD6L8XZl3ijC1cFwiZ/BlnWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jq53+dfjSS9uTwx46/4RRhTqQdJHi0GygqtAx5smcXqD8QGUO4VKMKJ5tTsfIHhWpxTdj9oiuknO4n0COliRRCg9RbNueX/PTKHiK5riRPFs+7Z+NLGmfdsYlK+fICF5MjIGiAm6TK6ir3QBKMke6F5ebe10MCzO7ApmKAfMZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9EDE154C9F3;
	Fri,  6 Feb 2026 04:01:45 +0100 (CET)
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
Subject: [PATCH net-next v2 09/14] net: bridge: mcast: track active state, VLAN snooping
Date: Fri,  6 Feb 2026 03:52:15 +0100
Message-ID: <20260206030123.5430-10-linus.luessing@c0d3.blue>
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

If VLAN aware multicast snooping is enabled then we need to perform a
few extra checks to figure out if multicast snooping is actually enabled
for a specific VLAN, as there is then an additional per VLAN multicast
snooping toggle.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 4bdc3838c3dc..2a2f54009e0f 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1143,6 +1143,26 @@ static void br_multicast_update_active(struct net_bridge_mcast *brmctx)
 	if (!br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED))
 		force_inactive = true;
 
+	if (br_opt_get(brmctx->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
+		/* with per-vlan snooping enabled there is an extra per-vlan
+		 * toggle to enable/disable snooping which we must check
+		 */
+		if (br_multicast_ctx_vlan_global_disabled(brmctx))
+			force_inactive = true;
+
+		/* with per-vlan snooping enabled the non-vlan multicast
+		 * snooping context is inactive
+		 */
+		if (!br_multicast_ctx_is_vlan(brmctx))
+			force_inactive = true;
+	} else {
+		/* with per-vlan snooping disabled a vlan multicast
+		 * snooping context is inactive
+		 */
+		if (br_multicast_ctx_is_vlan(brmctx))
+			force_inactive = true;
+	}
+
 	br_ip4_multicast_update_active(brmctx, force_inactive);
 	br_ip6_multicast_update_active(brmctx, force_inactive);
 
-- 
2.51.0

