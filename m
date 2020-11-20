Return-Path: <gustavoars@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605897473;
 bh=Zo92PHYB4DYGUeyh+eE6MjbS6uPNuituCK2u+6HGrOQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HxI/8nMy8C6+NR7K+xYFtohO6pM7q1XS9CuB3b3oAK2pv+uQ8NTmh9zt1o0SkB7hp
 dtgiHvaGHkKxiD7vP/m/7QNFcPSBEOtCpkDJfgZCiS8WJ9V8u6mVQat3rFC/1vbNC/
 VMXrfRGWj7O+1m++EWnWSuT7FeYM3EiXXEBjGTAg=
Date: Fri, 20 Nov 2020 12:37:59 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Message-ID: <44b2e50d345f1319071a53fb191ac0a0cf3fcf37.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
Subject: [Bridge] [PATCH 106/141] net: bridge: Fix fall-through warnings for
	Clang
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/bridge/br_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 59a318b9f646..8db219d979c5 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -148,6 +148,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		break;
 	case BR_PKT_UNICAST:
 		dst = br_fdb_find_rcu(br, eth_hdr(skb)->h_dest, vid);
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

