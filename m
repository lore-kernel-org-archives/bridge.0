Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5952BE048
	for <bridge@lists.linux.dev>; Fri,  6 Feb 2026 03:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346905; cv=none; b=dHGIk6ZEOZGruVL7eJCEgBmH1ANpxjMLcRq8s1eT+CjpWlZB6boEgT/2+fIQEPeVw4lAEdYJLvyu+BuqRzoNGyO6jwm8WsdLRMhln3fVVUcpfXfB6npprWy7Jd3/YIiISsZiShAt4Ot+IwPx6sqJzXiEt3+rzx55kMSGWl/15KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346905; c=relaxed/simple;
	bh=qyLVb14+eW9VYQJVB33MvWCyVz0vC8NExEj1C4MBTTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OmMPWW56MnS8+fuX90InbALmN1sKSNdgwBRoauMnqSXgj4m1/tUwhlBkUB+QLPD3bnkBLouVZy40aqPUQVZ5j1eCf8SaUqH1K18Caq8ar8CeZWSPf1E+dxfXj1TThHKlxc2ZRdJa/Ya8TooBDOmYN/nb8gqgtYnO54E4N+rphe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57B3354CD2B;
	Fri,  6 Feb 2026 04:01:43 +0100 (CET)
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
Subject: [PATCH net-next v2 07/14] net: bridge: mcast: track active state, own MLD querier disappearance
Date: Fri,  6 Feb 2026 03:52:13 +0100
Message-ID: <20260206030123.5430-8-linus.luessing@c0d3.blue>
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

This change ensures that the new multicast active state variable is
immediately unset if our internal IGMP/MLD querier was elected and
now disabled.

If no IGMP/MLD querier exists on the link then we can't reliably receive
IGMP/MLD reports and in turn can't ensure the completeness of our MDB
anymore either.

No functional change for the fast/data path yet. This is the last
necessary check before using the new multicast active state variable
in the fast/data path, too.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index a1cde2ba2a3e..2710c21daef5 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4914,6 +4914,7 @@ int br_multicast_set_querier(struct net_bridge_mcast *brmctx, unsigned long val)
 #endif
 
 unlock:
+	br_multicast_update_active(brmctx);
 	spin_unlock_bh(&brmctx->br->multicast_lock);
 
 	return 0;
-- 
2.51.0

