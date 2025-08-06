Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1402AD2F
	for <bridge@lists.linux.dev>; Wed,  6 Aug 2025 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754472537; cv=none; b=PNY6JWQcUz4QUK784bKPipFsnEaO/7oyGRAAEw8TxrouEe5ni5HfWM7TBRTtNtbSe19tOlKlkoY4mSECrNXJxLeD8VnIcw/RBsl3nE5GbgArHw4frsoeQ0SuV8qVhG3miGXxMLuZYPyh/49YlETe87nKZkt615vLM8kPZnGQiPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754472537; c=relaxed/simple;
	bh=bhJ5WP3HwvnnIMpMD69DY2iqOt3OMJucp0B8rJ3Cx/w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XFwoCvywCGxNTejLlw3szeCLiqY9W2tRg57KZg0RaNM1qAuP4ph5rAfT0UvJHXmJFEdgjtFIGXrIutS74q0PKuIs6VAXvc97Wlc37dDgWUxGQaTL2X/6AxMx7+SbGiFNjnefcXmYwITvZT3PrTeLVA9gN1txYnT7dZvTO5slDCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bxlM55DfVztScj;
	Wed,  6 Aug 2025 17:27:45 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 362C7140156;
	Wed,  6 Aug 2025 17:28:47 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 6 Aug
 2025 17:28:46 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <razor@blackwall.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
CC: <bridge@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <wangliang74@huawei.com>
Subject: [PATCH net] net: bridge: fix soft lockup in br_multicast_query_expired()
Date: Wed, 6 Aug 2025 17:49:41 +0800
Message-ID: <20250806094941.1285944-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500016.china.huawei.com (7.185.36.197)

When set multicast_query_interval to a large value, the local variable
'time' in br_multicast_send_query() may overflow. If the time is smaller
than jiffies, the timer will expire immediately, and then call mod_timer()
again, which creates a loop and may trigger the following soft lockup
issue:

  watchdog: BUG: soft lockup - CPU#1 stuck for 221s! [rb_consumer:66]
  CPU: 1 UID: 0 PID: 66 Comm: rb_consumer Not tainted 6.16.0+ #259 PREEMPT(none)
  Call Trace:
   <IRQ>
   __netdev_alloc_skb+0x2e/0x3a0
   br_ip6_multicast_alloc_query+0x212/0x1b70
   __br_multicast_send_query+0x376/0xac0
   br_multicast_send_query+0x299/0x510
   br_multicast_query_expired.constprop.0+0x16d/0x1b0
   call_timer_fn+0x3b/0x2a0
   __run_timers+0x619/0x950
   run_timer_softirq+0x11c/0x220
   handle_softirqs+0x18e/0x560
   __irq_exit_rcu+0x158/0x1a0
   sysvec_apic_timer_interrupt+0x76/0x90
   </IRQ>

This issue can be reproduced with:
  ip link add br0 type bridge
  echo 1 > /sys/class/net/br0/bridge/multicast_querier
  echo 0xffffffffffffffff >
  	/sys/class/net/br0/bridge/multicast_query_interval
  ip link set dev br0 up

Fix this by comparing expire time with jiffies, to avoid the timer loop.

Fixes: 7e4df51eb35d ("bridge: netlink: add support for igmp's intervals")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/bridge/br_multicast.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 1377f31b719c..631ae3b4c45d 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1892,7 +1892,8 @@ static void br_multicast_send_query(struct net_bridge_mcast *brmctx,
 	time += own_query->startup_sent < brmctx->multicast_startup_query_count ?
 		brmctx->multicast_startup_query_interval :
 		brmctx->multicast_query_interval;
-	mod_timer(&own_query->timer, time);
+	if (time_is_after_jiffies(time))
+		mod_timer(&own_query->timer, time);
 }
 
 static void
-- 
2.34.1

