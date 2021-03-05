Return-Path: <gustavoars@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614930041;
 bh=TMB+VspMfpQaDgELNuFuzkz3wGytJH9MpU0ojKUhGRA=;
 h=Date:From:To:Cc:Subject:From;
 b=FX7kxcoCvRHixXWJCJ1unVen3UYt+5Ruvv+O4A6SbEbJVfo2f8eaSlKGjpUnzldtF
 /4NDv9HiMNdDwY1zfUfUfGqJeXsk0l9wK5aaV64IM2eAV5pTjLXXNkBj3/6m3D6rM0
 R0X1sNGSwS0pvHRVk/jxTv4XxGBkMZesB+O5aFazEbC9xG7h5lLJFcMk+y48pug4kH
 utTF86JxH6WK/N1/60TsXJra+OAHPb+QP4yZIWDlP9Fv7qhalkXpB5CIJgvTV0sr/D
 AVoacwLB136wKYqkyno53ZLntkReXxgzGysn8mwIcYsUBcU4rHmDJr9Sg7w5LH5hP5
 c1zOXEA/rHV/Q==
Date: Fri, 5 Mar 2021 01:40:38 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Message-ID: <20210305074038.GA122888@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [PATCH][next] net: bridge: Fix fall-through warnings for
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
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/bridge/br_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 222285d9dae2..8875e953ac53 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -144,6 +144,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		break;
 	case BR_PKT_UNICAST:
 		dst = br_fdb_find_rcu(br, eth_hdr(skb)->h_dest, vid);
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

