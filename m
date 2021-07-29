Return-Path: <yajun.deng@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1627544832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XXimOoQI1d0O8kEjg5QeSeqgs9ahW1SYrIjYJUFIUFk=;
 b=ZxU028pHpwvCtyCHblNHopevwPhNISY8scbRLab5RO12ZB79ThzDFEUOMpoitqLZcEhufp
 MJ54uK4qZoUJk7QEp6rYStFMQ0B1Ub76M1kpRxuJ5cFk3knShr9ucpjgEh5Q7sc/GbEd7f
 EuIcMCBQb5gpowr3KfbDZ5/moNDpICM=
From: Yajun Deng <yajun.deng@linux.dev>
Date: Thu, 29 Jul 2021 15:46:58 +0800
Message-Id: <20210729074658.8538-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v2] netfilter: nf_conntrack_bridge: Fix memory leak
	when error
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, coreteam@netfilter.org, Yajun Deng <yajun.deng@linux.dev>, netfilter-devel@vger.kernel.org

It should be added kfree_skb_list() when err is not equal to zero
in nf_br_ip_fragment().

v2: keep this aligned with IPv6.

Fixes: 3c171f496ef5 ("netfilter: bridge: add connection tracking system")
Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 8d033a75a766..3cf5457919c6 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -88,6 +88,11 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 
 			skb = ip_fraglist_next(&iter);
 		}
+
+		if (!err)
+			return 0;
+
+		kfree_skb_list(iter.frag_list);
 		return err;
 	}
 slow_path:
-- 
2.32.0

