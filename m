Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40572C1594
	for <bridge@lists.linux.dev>; Fri,  6 Feb 2026 03:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346903; cv=none; b=YqDMH4WcqfHvcR5BvkBy/heIfFwdrj8IdRKnlBAIrCJxgo/RPmS7jDyJ9Uof1pS82w+Uc617/b2ULZdxIdyngybTqOQHRl+oChfGBuBjzdk0XcQ1GdMDdG5LiD0pjah9g2tNTXOgAww58ixJiOXr8VUYxkIGY1Me6aROnBsB0z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346903; c=relaxed/simple;
	bh=Vg1m8IVb3oIFf6NpWyEKT41GdiiGv/AuMj3dW4xUSvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5+AdYeuc0lFWyE5bTwDccDpU9gqkTduAl1AliuQ9qnJXx2jvoucbRCh88v38vcXXnbAXLkvzl3EkQ3P7r75oew5NhY0LtzOiRfOaybglCp5KWIy3v+kKlVlYebqeh2m1GBwFvDkTA6xuwlQQuW4801IXW2Q+oVTecrAJnCPY7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E13454C9F3;
	Fri,  6 Feb 2026 04:01:41 +0100 (CET)
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
Subject: [PATCH net-next v2 05/14] net: bridge: mcast: track active state, foreign IGMP/MLD querier disappearance
Date: Fri,  6 Feb 2026 03:52:11 +0100
Message-ID: <20260206030123.5430-6-linus.luessing@c0d3.blue>
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

This change ensures that the new multicast active state variable is unset
again after a foreign IGMP/MLD querier has disappeared (default: 255
seconds). If no new, other IGMP/MLD querier took over then we can't
reliably receive IGMP/MLD reports anymore and in turn can't ensure the
completeness of our MDB anymore either.

No functional change for the fast/data path yet.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index d5c623dce7eb..0fc29875db9c 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1826,6 +1826,10 @@ static void br_multicast_querier_expired(struct net_bridge_mcast *brmctx,
 	br_multicast_start_querier(brmctx, query);
 
 out:
+	/* another IGMP/MLD querier disappeared, set multicast state to inactive
+	 * if our own querier is disabled, too
+	 */
+	br_multicast_update_active(brmctx);
 	spin_unlock(&brmctx->br->multicast_lock);
 }
 
-- 
2.51.0

