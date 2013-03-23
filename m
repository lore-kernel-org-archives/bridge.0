Return-Path: <honkiko@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer;
	bh=5Gy1wLJMVFTeytBSomiGKNCUtOzxhH9bO7+oqldfh6U=;
	b=Pz7TOSgsJK11TTUPw5zacihldcaLBoCFkNNET8CUERKfYynTozQ76rtLVBrkrrF9vQ
	GGB9Q3H1cNAlM5pzayRnNmy7D8+k4mHNhfHIcnyWVpK1psF/dbL9SMrYfrC+SwptyYsG
	bYWlnlKLEaVtrA7bHveA8Ph8juXS1GX/ZpSBLSKkKUCjsWUsWlGZv/WJ/gGVHjUvSVs0
	YWLndWrFWz6jhrwLgdYdZqdfEZD5dC4tjXLLubX4KCsbajK5U3me14CkJvlQ2dvbA0Wi
	VHpMvAPFhz6/WIirvAZLXilbcEZ7E1qpqUbUtqVzAQhu/Bpc+dYxwkrJkl/znaqGlzWq
	buhw==
From: Hong Zhiguo <honkiko@gmail.com>
Date: Sat, 23 Mar 2013 20:27:50 +0800
Message-Id: <1364041670-3408-1-git-send-email-honkiko@gmail.com>
Subject: [Bridge] [PATCH] bridge: fix crash when set mac address of br
	interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, zhiguo.hong@emc.com, Hong Zhiguo <honkiko@gmail.com>, stephen@networkplumber.org, herbert@gondor.hengli.com.au, davem@davemloft.net

When I tried to set mac address of a bridge interface to a mac
address which already learned on this bridge, I got system hang.

The cause is straight forward: function br_fdb_change_mac_address
calls fdb_insert with NULL source nbp. Then an fdb lookup is
performed. If an fdb entry is found and it's local, it's OK. But
if it's not local, source is dereferenced for printk without NULL
check.

Signed-off-by: Hong Zhiguo <honkiko@gmail.com>
---
 net/bridge/br_fdb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 10b47d4..c581f12 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -421,7 +421,7 @@ static int fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
 			return 0;
 		br_warn(br, "adding interface %s with same address "
 		       "as a received packet\n",
-		       source->dev->name);
+		       source ? source->dev->name : br->dev->name);
 		fdb_delete(br, fdb);
 	}
 
-- 
1.7.10.4

