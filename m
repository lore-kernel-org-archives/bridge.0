Return-Path: <yajun.deng@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1627271839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=42/x3cunuNFrK5WXYNzv0PumgHH417h+iX4VfozjEqg=;
 b=TTEDvxwLws0uMFv8PMZ4WRAA59G66FCBFtiLFTvnsFeltMxFuQk7l7cp4tACqzT9nHNY5g
 M2zbbPyGukGSDcBtLh3VIHQ8lk+cSHfB5YjoJ9enWMDamCcWT0AnAWDS7+WhLFcSTcjQg0
 5KGfiyhcz2rKOta51MylqUExs8RZlTY=
From: Yajun Deng <yajun.deng@linux.dev>
Date: Mon, 26 Jul 2021 11:57:02 +0800
Message-Id: <20210726035702.11964-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH] netfilter: nf_conntrack_bridge: Fix not free when
	error
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, roopa@nvidia.com, nikolay@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, coreteam@netfilter.org, Yajun Deng <yajun.deng@linux.dev>, netfilter-devel@vger.kernel.org

It should be added kfree_skb_list() when err is not equal to zero
in nf_br_ip_fragment().

Fixes: 3c171f496ef5 ("netfilter: bridge: add connection tracking system")
Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 8d033a75a766..059f53903eda 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -83,12 +83,16 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 
 			skb->tstamp = tstamp;
 			err = output(net, sk, data, skb);
-			if (err || !iter.frag)
-				break;
-
+			if (err) {
+				kfree_skb_list(iter.frag);
+				return err;
+			}
+
+			if (!iter.frag)
+				return 0;
+
 			skb = ip_fraglist_next(&iter);
 		}
-		return err;
 	}
 slow_path:
 	/* This is a linearized skbuff, the original geometry is lost for us.
-- 
2.32.0

