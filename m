Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0279113D503
	for <bridge@lists.linux.dev>; Thu, 14 Aug 2025 04:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755145406; cv=none; b=cdj5KXzVN3LSh/YIguJvkAzkDr3URfTfbCv+z5OqwlKR5BRusnbSLEtReRdUXD+Qt2eIFo5+EdYkf8fYcLddrizjuvo70P3+Hna0nJFcazxCBmWXwS9CvwT6kOHIiYStcOI2QWptLG2pZ/pWPVWlicu6KBJfTQ5Y4NQB92z3Oig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755145406; c=relaxed/simple;
	bh=OU/17fUqQ2Vxs2ejvWaFCB390X2jIlbgKXMJALgspmk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YpsoeGgDI4ALYyXcbZ48WpirJPmB3x15Gk0f3fp2lCP2GkzVx8vvsAZv7JigczxKEaeEiMriG9CFOP4Fk7EfipJUmXBonDTzrNc5kaipa4ftY14T+e7heJDOW1C1ttrc62y3f2s4z7brM8H1EenVprP8cPRKMj345S5EAtJWHeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c2XBy1qjnztTC8;
	Thu, 14 Aug 2025 12:22:18 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BF051800B2;
	Thu, 14 Aug 2025 12:23:18 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 12:23:17 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <razor@blackwall.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
CC: <bridge@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <wangliang74@huawei.com>
Subject: [PATCH net-next] net: bridge: remove unused argument of br_multicast_query_expired()
Date: Thu, 14 Aug 2025 12:23:55 +0800
Message-ID: <20250814042355.1720755-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500016.china.huawei.com (7.185.36.197)

Since commit 67b746f94ff3 ("net: bridge: mcast: make sure querier
port/address updates are consistent"), the argument 'querier' is unused,
just get rid of it.

Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/bridge/br_multicast.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 1377f31b719c..4dc62d01e2d3 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4049,8 +4049,7 @@ int br_multicast_rcv(struct net_bridge_mcast **brmctx,
 }
 
 static void br_multicast_query_expired(struct net_bridge_mcast *brmctx,
-				       struct bridge_mcast_own_query *query,
-				       struct bridge_mcast_querier *querier)
+				       struct bridge_mcast_own_query *query)
 {
 	spin_lock(&brmctx->br->multicast_lock);
 	if (br_multicast_ctx_vlan_disabled(brmctx))
@@ -4069,8 +4068,7 @@ static void br_ip4_multicast_query_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
 							     ip4_own_query.timer);
 
-	br_multicast_query_expired(brmctx, &brmctx->ip4_own_query,
-				   &brmctx->ip4_querier);
+	br_multicast_query_expired(brmctx, &brmctx->ip4_own_query);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -4079,8 +4077,7 @@ static void br_ip6_multicast_query_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
 							     ip6_own_query.timer);
 
-	br_multicast_query_expired(brmctx, &brmctx->ip6_own_query,
-				   &brmctx->ip6_querier);
+	br_multicast_query_expired(brmctx, &brmctx->ip6_own_query);
 }
 #endif
 
-- 
2.33.0

