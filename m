Return-Path: <bhumirks@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=z98SltI4O4JZgJXEO5rJeprg6BuI6jlvxOPbToXar1I=;
	b=Erlk1JV+VqImmqyGadXgoUZayRfRs+9gn50XUMCUjmlkyKoTJa8ovoQxHpkaMPxF6Z
	f9Kh8BvrTuaOkwFHqWbxPfy+KoFTzpoVFtIbAQoDDIP/uEUxGLY6i5FkytYjpeKtc2wr
	YlHpk4C3U+8wYpe80R8mClWTLT5sovP9+vSx102+h8hwf90ImhdGWfqsoKja47ijCI8a
	1+Hu8vQ5eCkQa5nciu5YhyVXADVPBzrT/lOYwPE6cR85jk4h/QJUDw2e8kamkzN+X/fP
	WGQm1TGlu2hbJA7j/zhe9qgxjGdciHQaqYQVEt8OckVI0ktVlmtjxAxlwPI+km5Iz8ws
	jCng==
From: Bhumika Goyal <bhumirks@gmail.com>
Message-Id: <1503670907-23221-4-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
References: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
Subject: [Bridge] [PATCH 3/7] ieee802154: 6lowpan: make header_ops const
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 25 Aug 2017 14:23:36 -0000
To: julia.lawall@lip6.fr, marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, davem@davemloft.net, pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de, stephen@networkplumber.org, alex.aring@gmail.com, stefan@osg.samsung.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, santosh.shilimkar@oracle.com, trond.myklebust@primarydata.com, anna.schumaker@netapp.com, bfields@fieldses.org, jlayton@poochiereds.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux-foundation.org, linux-wpan@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, linux-nfs@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make this const as it is only stored as a reference in a const field of
a net_device structure.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 net/ieee802154/6lowpan/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index de2661c..974765b 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -54,7 +54,7 @@
 
 static int open_count;
 
-static struct header_ops lowpan_header_ops = {
+static const struct header_ops lowpan_header_ops = {
 	.create	= lowpan_header_create,
 };
 
-- 
1.9.1

