Return-Path: <BATV+fac86bbf8fd344557627+6172+infradead.org+hch@casper.srs.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=ke6IxwSs5p7KD2PfPxkYUwJA5rYh272J6EZhbIQy4kY=; b=MxaBf8IdG4oPd47UVm2tZXLlpY
 Lj0kUlQbB1ZRjYfxYtQJbE06uDcQv69Ai/DLwk1bpkRfuf/Jq2/MAFkOdGdxJ7JwVqrTQ6cHzbbES
 UpuJYyT7FeWfdFe32t9OAbw443Y8bublO9rfbU+CPORFb/g2qc+AjGx3JIwnE+HGZpVuzkFNCu/TT
 BWIKQP4tO2HncJuy0u9oLDaTS42Z+rtg9RxsA4/Po+C8o5jRFn7lUt0oFhBTgcPr6Le1Bsj9sY6G9
 kTZ7bSAsM4ou68NnoUCrRR1I/mOtGV8h6aLpoiA3nDRrdKTCaI6dqv7MW45Lkr00tnDxSDW82t9zb
 q7aZii2Q==;
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 17 Jul 2020 08:23:22 +0200
Message-Id: <20200717062331.691152-14-hch@lst.de>
In-Reply-To: <20200717062331.691152-1-hch@lst.de>
References: <20200717062331.691152-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 13/22] netfilter: split nf_sockopt
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, dccp@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, Alexei Starovoitov <ast@kernel.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, linux-bluetooth@vger.kernel.org, linux-sctp@vger.kernel.org, netfilter-devel@vger.kernel.org, mptcp@lists.01.org, Chas Williams <3chas3@gmail.com>, netdev@vger.kernel.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, bpf@vger.kernel.org, linux-can@vger.kernel.org, linux-wpan@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>

Split nf_sockopt into a getsockopt and setsockopt side as they share
very little code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/netfilter/nf_sockopt.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/net/netfilter/nf_sockopt.c b/net/netfilter/nf_sockopt.c
index 02870993d335c9..90469b1f628a8e 100644
--- a/net/netfilter/nf_sockopt.c
+++ b/net/netfilter/nf_sockopt.c
@@ -89,36 +89,32 @@ static struct nf_sockopt_ops *nf_sockopt_find(struct sock *sk, u_int8_t pf,
 	return ops;
 }
 
-/* Call get/setsockopt() */
-static int nf_sockopt(struct sock *sk, u_int8_t pf, int val,
-		      char __user *opt, int *len, int get)
+int nf_setsockopt(struct sock *sk, u_int8_t pf, int val, char __user *opt,
+		  unsigned int len)
 {
 	struct nf_sockopt_ops *ops;
 	int ret;
 
-	ops = nf_sockopt_find(sk, pf, val, get);
+	ops = nf_sockopt_find(sk, pf, val, 0);
 	if (IS_ERR(ops))
 		return PTR_ERR(ops);
-
-	if (get)
-		ret = ops->get(sk, val, opt, len);
-	else
-		ret = ops->set(sk, val, opt, *len);
-
+	ret = ops->set(sk, val, opt, len);
 	module_put(ops->owner);
 	return ret;
 }
-
-int nf_setsockopt(struct sock *sk, u_int8_t pf, int val, char __user *opt,
-		  unsigned int len)
-{
-	return nf_sockopt(sk, pf, val, opt, &len, 0);
-}
 EXPORT_SYMBOL(nf_setsockopt);
 
 int nf_getsockopt(struct sock *sk, u_int8_t pf, int val, char __user *opt,
 		  int *len)
 {
-	return nf_sockopt(sk, pf, val, opt, len, 1);
+	struct nf_sockopt_ops *ops;
+	int ret;
+
+	ops = nf_sockopt_find(sk, pf, val, 1);
+	if (IS_ERR(ops))
+		return PTR_ERR(ops);
+	ret = ops->get(sk, val, opt, len);
+	module_put(ops->owner);
+	return ret;
 }
 EXPORT_SYMBOL(nf_getsockopt);
-- 
2.27.0

