Return-Path: <baijiaju1990@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=TFmmV9TVaaNUuaMbsO9KBOUJCI3DKPpFnOVgzqi7U6w=;
 b=apZSNVUIOKcBJTA2nDNXj8M/+Sm/J1CDcmtn4dh+G1TtfBQLVB1fCOy/VOwWVfJJrx
 tj1oL1/oE1PiHygPm2ldmo2IsMxeMsAG8V/NzrxRlUoyv3vPYKPr1tb9GcYsHYaaOMW5
 kvYBaAioNG8NEV+jhuDPtTLY7V134eJXP3WxpoD4bLvWgTf4XK0c4ozJakbj4ep0eOKX
 /saUXnACQ+gITn188nVyPqs0DkKYA5jQ9BN+Mn7hiOt3ilzyxNrFYGGP7w78PtFEDxRz
 n/bIng9BhhBr1aVYWUP2oWXotxybmvmNjN5JPPRI+4ouq3/h9wujb/+3xfKEeGEO4CPK
 nUGg==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Mon,  8 Mar 2021 18:28:54 -0800
Message-Id: <20210309022854.17904-1-baijiaju1990@gmail.com>
Subject: [Bridge] [PATCH] net: bridge: fix error return code of
	do_update_counters()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, roopa@nvidia.com, nikolay@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>, netfilter-devel@vger.kernel.org

When find_table_lock() returns NULL to t, no error return code of
do_update_counters() is assigned.
To fix this bug, ret is assigned with -ENOENT in this case.

Fixes: 49facff9f925 ("netfilter: ebtables: split update_counters into two functions")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 net/bridge/netfilter/ebtables.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index ebe33b60efd6..66c9e4077985 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1256,8 +1256,10 @@ static int do_update_counters(struct net *net, const char *name,
 		return -ENOMEM;
 
 	t = find_table_lock(net, name, &ret, &ebt_mutex);
-	if (!t)
+	if (!t) {
+		ret = -ENOENT;
 		goto free_tmp;
+	}
 
 	if (num_counters != t->private->nentries) {
 		ret = -EINVAL;
-- 
2.17.1

