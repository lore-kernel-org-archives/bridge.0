Return-Path: <bhumirks@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Zs2SnW09Z4ozLDiJHkE06CKMRyQ28EQTa29CVJIcd5Q=;
	b=SMv7OkfKIx3SxDzbcuz/yx+dParNM78l8uaQRj+ic/ljRkIhqvoqK7DAPBa+68ACGa
	75GxiqcgD2FW3mvhJ0s6LQrxRv1oIFMpjQ/OkGYE41D7c9kmC5ZMJhOYDOyshpyUe8bi
	jFhqtqiQWsuf0M8ixbvT+nZ3sEsDnjsgAhXVFf9r9URtqVjJ6T2UrSyirKDbwAgTT7Wl
	PZzft+iobWMR8ebOrcfOQF5BTkcoTL6umk0UfxS4dl4uKWZJneSWW7Qdl4XLSTUIrmVB
	/sxThRwk/RXlaChGV8BGZ17Km3/KpTli1Tbj8kKL2mEyQ3dyWTkw/Xqb1MpNOFgb5iAp
	Y/dA==
From: Bhumika Goyal <bhumirks@gmail.com>
Message-Id: <1503670907-23221-7-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
References: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
Subject: [Bridge] [PATCH 6/7] netfilter: nat: make rhashtable_params const
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 25 Aug 2017 14:24:29 -0000
To: julia.lawall@lip6.fr, marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, davem@davemloft.net, pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de, stephen@networkplumber.org, alex.aring@gmail.com, stefan@osg.samsung.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, santosh.shilimkar@oracle.com, trond.myklebust@primarydata.com, anna.schumaker@netapp.com, bfields@fieldses.org, jlayton@poochiereds.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux-foundation.org, linux-wpan@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, linux-nfs@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make this const as it is either used during a copy operation or passed
to a const argument of the function rhltable_init.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 net/netfilter/nf_nat_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index b1d3740..df983ea 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -198,7 +198,7 @@ static int nf_nat_bysource_cmp(struct rhashtable_compare_arg *arg,
 	return 0;
 }
 
-static struct rhashtable_params nf_nat_bysource_params = {
+static const struct rhashtable_params nf_nat_bysource_params = {
 	.head_offset = offsetof(struct nf_conn, nat_bysource),
 	.obj_hashfn = nf_nat_bysource_hash,
 	.obj_cmpfn = nf_nat_bysource_cmp,
-- 
1.9.1

