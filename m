Return-Path: <bhumirks@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=rOjjm5Ymjtea8q9Kte6K0RixXYCnUUiyL+Mn2Jzug+8=;
	b=u94H0xal3+jXNn87W6rLz+ZBbfFXT+zsYZ83u2SvF1Lk2z0TeNZlQkPZu77yH4JOTw
	sPRdaF7mFaL65Fe10jcqOBgp8QAd6v/kVunPEXx4DbScVq4XuHjkUhln+rz4dmwxREj8
	p1qFtqgj2VmvuYeAAKSjjicCKLJr7Y+6lSGwzcAyK5NmOg0q79TmZJERuHtfdp3fYQp9
	7hEqvLIV+bD5w3vz9Yryc+JsdfeRoIt+97tjehRUfPZV6bHwUYT6O6kkxiodCyhYBsIY
	D5qErpI7GZ2f+3ceP9qm989TI/zYjVZfiUSUTQcmfkOIbWM96NBnh8wghxXFwclT1s1I
	EdNg==
From: Bhumika Goyal <bhumirks@gmail.com>
Message-Id: <1503670907-23221-3-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
References: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
Subject: [Bridge] [PATCH 2/7] bridge: make ebt_table const
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 25 Aug 2017 14:23:16 -0000
To: julia.lawall@lip6.fr, marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, davem@davemloft.net, pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de, stephen@networkplumber.org, alex.aring@gmail.com, stefan@osg.samsung.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, santosh.shilimkar@oracle.com, trond.myklebust@primarydata.com, anna.schumaker@netapp.com, bfields@fieldses.org, jlayton@poochiereds.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux-foundation.org, linux-wpan@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, linux-nfs@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make this const as it is only passed to a const argument of the function
ebt_register_table.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 net/bridge/netfilter/ebtable_nat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/ebtable_nat.c b/net/bridge/netfilter/ebtable_nat.c
index 4ecf506..57cd5bb 100644
--- a/net/bridge/netfilter/ebtable_nat.c
+++ b/net/bridge/netfilter/ebtable_nat.c
@@ -48,7 +48,7 @@ static int check(const struct ebt_table_info *info, unsigned int valid_hooks)
 	return 0;
 }
 
-static struct ebt_table frame_nat = {
+static const struct ebt_table frame_nat = {
 	.name		= "nat",
 	.table		= &initial_table,
 	.valid_hooks	= NAT_VALID_HOOKS,
-- 
1.9.1

