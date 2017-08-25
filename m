Return-Path: <bhumirks@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=bsmfvN4spIsqpQJf7CGI5wExBPx0tH9c+Q6WXMdU9bE=;
	b=r2rVlOFr3fPV7r5CEik7hi/fQfIcHD1wMexxxmTmYqXVIi1kRiMyFv7ksTmuTFNOld
	P8hJAIx46PONb9lN505qRsuVxzfY2Xx3NMVqW9VcZ1hUwhXGvOMZ4HYAhH3BXOfaYCwE
	NSYgORbOV9n/Vr+609PKtfR2QrRiZy0JVVhZfv9+H5zcDFgxpDMGcgD6wrwKFV8Lwm75
	NcOHEzHQxQCli532LMDL132avUIOTr8uGa411do8xeOIQb4JkZ6m2OBgfPtqA3bmHz9W
	HgRuYxvqxFAjS3aKP7zPOdlqZ6HoR2lX+MpcpUcCvRZxBFrzWdPaMAKeaez4WaahH4n7
	l2Yg==
From: Bhumika Goyal <bhumirks@gmail.com>
Message-Id: <1503670907-23221-6-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
References: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
Subject: [Bridge] [PATCH 5/7] RDS: make rhashtable_params const
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 25 Aug 2017 14:24:11 -0000
To: julia.lawall@lip6.fr, marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, davem@davemloft.net, pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de, stephen@networkplumber.org, alex.aring@gmail.com, stefan@osg.samsung.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, santosh.shilimkar@oracle.com, trond.myklebust@primarydata.com, anna.schumaker@netapp.com, bfields@fieldses.org, jlayton@poochiereds.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux-foundation.org, linux-wpan@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, linux-nfs@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make this const as it is either used during a copy operation or passed
to a const argument of the function rhltable_init

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 net/rds/bind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/bind.c b/net/rds/bind.c
index 3a915be..75d43dc 100644
--- a/net/rds/bind.c
+++ b/net/rds/bind.c
@@ -40,7 +40,7 @@
 
 static struct rhashtable bind_hash_table;
 
-static struct rhashtable_params ht_parms = {
+static const struct rhashtable_params ht_parms = {
 	.nelem_hint = 768,
 	.key_len = sizeof(u64),
 	.key_offset = offsetof(struct rds_sock, rs_bound_key),
-- 
1.9.1

