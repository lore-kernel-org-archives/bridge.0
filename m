Received: from spam.asrmicro.com (asrmicro.com [210.13.118.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC21E3DFA
	for <bridge@lists.linux.dev>; Thu, 10 Apr 2025 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.13.118.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271905; cv=none; b=DEwxooSnhRveHUg646JXydgJTin/uMqzRLFqHEoSJWImCtp4d6/8/OjRvbLZRYDk3J4rhN/HJZt1YNFMDUTjtAvfd4cmh7ZxrVpXkI0ZEgk5ABXl17tnUAxry2b/XetMX/CDbTepIFbNacQVxdlQpNzbS8K3A+Tmd10ax2LSa8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271905; c=relaxed/simple;
	bh=OFuTvLaGjzuQogsFcUndCTKTSWSWkE6Q1DC0VMEZAXI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eOCqLc/waPjjXoftpXV88EGPQrkwyD35VYsdhQy47pVEHVuUjsSH3u90oDVCjg4MJRr4Xup9qiTE14Q/Y/S0QOd+XurLK6j71d6KZ/I8sPiNfdxj/y0Ol1VS/y4oykIYVbaMUQy17efLIF9WdI0BAZyzqv7z+1xt2CG6n9zp3AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com; spf=pass smtp.mailfrom=asrmicro.com; arc=none smtp.client-ip=210.13.118.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asrmicro.com
Received: from exch03.asrmicro.com (exch03.asrmicro.com [10.1.24.118])
	by spam.asrmicro.com with ESMTPS id 53A7vUw7082119
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Thu, 10 Apr 2025 15:57:30 +0800 (GMT-8)
	(envelope-from huajianyang@asrmicro.com)
Received: from localhost (10.26.128.141) by exch03.asrmicro.com (10.1.24.118)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Thu, 10 Apr 2025 15:57:32
 +0800
From: Huajian Yang <huajianyang@asrmicro.com>
To: <pablo@netfilter.org>, <fw@strlen.de>
CC: <kadlec@netfilter.org>, <razor@blackwall.org>, <idosch@nvidia.com>,
        <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
        <bridge@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Huajian Yang <huajianyang@asrmicro.com>
Subject: [PATCH] net: Move specific fragmented packet to slow_path instead of dropping it
Date: Thu, 10 Apr 2025 15:57:26 +0800
Message-ID: <20250410075726.8599-1-huajianyang@asrmicro.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exch01.asrmicro.com (10.1.24.121) To exch03.asrmicro.com
 (10.1.24.118)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:spam.asrmicro.com 53A7vUw7082119

The config NF_CONNTRACK_BRIDGE will change the way fragments are processed.

Bridge does not know that it is a fragmented packet and forwards it
directly, after NF_CONNTRACK_BRIDGE is enabled, function nf_br_ip_fragment
and br_ip6_fragment will check and fraglist this packet.

This change makes layer 2 fragmented packet forwarding more similar to
ip_do_fragment, these specific packets previously dropped will go to
slow_path for further processing.

Signed-off-by: Huajian Yang <huajianyang@asrmicro.com>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 12 ++++--------
 net/ipv6/netfilter.c                       | 13 ++++---------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 816bb0fde718..beac62c5d257 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -61,18 +61,14 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 		struct sk_buff *frag;
 
 		if (first_len - hlen > mtu ||
-		    skb_headroom(skb) < ll_rs)
-			goto blackhole;
-
-		if (skb_cloned(skb))
+		    (skb_headroom(skb) < ll_rs) ||
+		    skb_cloned(skb))
 			goto slow_path;
 
 		skb_walk_frags(skb, frag) {
 			if (frag->len > mtu ||
-			    skb_headroom(frag) < hlen + ll_rs)
-				goto blackhole;
-
-			if (skb_shared(frag))
+			    (skb_headroom(frag) < hlen + ll_rs) ||
+			    skb_shared(frag))
 				goto slow_path;
 		}
 
diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index 581ce055bf52..29778e014560 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -165,19 +165,14 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		struct sk_buff *frag2;
 
 		if (first_len - hlen > mtu ||
-		    skb_headroom(skb) < (hroom + sizeof(struct frag_hdr)))
-			goto blackhole;
-
-		if (skb_cloned(skb))
+		    skb_headroom(skb) < (hroom + sizeof(struct frag_hdr)) ||
+		    skb_cloned(skb))
 			goto slow_path;
 
 		skb_walk_frags(skb, frag2) {
 			if (frag2->len > mtu ||
-			    skb_headroom(frag2) < (hlen + hroom + sizeof(struct frag_hdr)))
-				goto blackhole;
-
-			/* Partially cloned skb? */
-			if (skb_shared(frag2))
+			    skb_headroom(frag2) < (hlen + hroom + sizeof(struct frag_hdr)) ||
+			    skb_shared(frag2))
 				goto slow_path;
 		}
 
-- 
2.48.1

