Return-Path: <lucien.xin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=qcnwfVdLNpdeZuVltPaWSE3zfo2Bg3qikH4nnxhsKWI=;
	b=eePA22AoxzBzK7GKzWuZsxqQ7GfTW7kLt08KtT38iyO046trTK1d0b/rZiHz2hQneW
	htEiU0+s0g5FkrnWATVOVRCaQmlDr975qe+r7nNngPfI9C3/IEW3eA5o8/ihYJTOa/60
	7E3EkXtxse46Eg0+qGELD5D6T7hg+/vFkGnHgy+WvGgxh+jel+N0GmE1oaNma/K8wuwB
	ZHVLRwNujmuqXPB36r1VPCepquXqKNNxSeYo7FHBUy3gD+omAz51y70hfqcdvY+BgSXY
	m/c0qzExHo6BRhz/Afm+DvVdRZOVqvIjhTTSiztRRR+y1QMBX7KAHSsFlZnbluQVjjFY
	0OTA==
From: Xin Long <lucien.xin@gmail.com>
Date: Tue,  5 Apr 2016 11:32:36 +0800
Message-Id: <6e2cf6821542a253904dfc7d8ec431d6bbda2b4e.1459827115.git.lucien.xin@gmail.com>
In-Reply-To: <cover.1459827115.git.lucien.xin@gmail.com>
References: <cover.1459827115.git.lucien.xin@gmail.com>
In-Reply-To: <cover.1459827115.git.lucien.xin@gmail.com>
References: <cover.1459827115.git.lucien.xin@gmail.com>
Subject: [Bridge] [PATCHv2 net-next 1/6] bridge: simplify the flush_store by
	calling store_bridge_parm
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: network dev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org
Cc: nikolay@cumulusnetworks.com, davem@davemloft.net

There are some repetitive codes in flush_store, we can remove
them by calling store_bridge_parm, also, it would send rtnl notification
after we add it in store_bridge_parm in the following patches.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/bridge/br_sysfs_br.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 6b80914..c48f6b0 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -336,17 +336,17 @@ static ssize_t group_addr_store(struct device *d,
 
 static DEVICE_ATTR_RW(group_addr);
 
+static int set_flush(struct net_bridge *br, unsigned long val)
+{
+	br_fdb_flush(br);
+	return 0;
+}
+
 static ssize_t flush_store(struct device *d,
 			   struct device_attribute *attr,
 			   const char *buf, size_t len)
 {
-	struct net_bridge *br = to_bridge(d);
-
-	if (!ns_capable(dev_net(br->dev)->user_ns, CAP_NET_ADMIN))
-		return -EPERM;
-
-	br_fdb_flush(br);
-	return len;
+	return store_bridge_parm(d, buf, len, set_flush);
 }
 static DEVICE_ATTR_WO(flush);
 
-- 
2.1.0

