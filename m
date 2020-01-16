Return-Path: <sashal@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579193718;
 bh=tLL5fviRXm3vOMtOlR4+W3b4zIYYTZ6aRnxayKQc6YI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BcE7/LchsWqt5Bxvn/v2+9sc+Uz7v+N1E4gkrkgttTWqnRM8hj7q0dAtOMzpfFN+C
 chFF52cqA/74pEohJtUxITetl2GYKNwY6aJnSCpW0Mvj1MBOhC0MBS2E2OXTQcrRJx
 /Ktd+BDYUaEiZJ2uVM7kR4OwYUyfSEXODocgxRDI=
From: Sasha Levin <sashal@kernel.org>
Date: Thu, 16 Jan 2020 11:44:04 -0500
Message-Id: <20200116165502.8838-13-sashal@kernel.org>
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH AUTOSEL 4.19 013/671] bridge: br_arp_nd_proxy: set
	icmp6_router if neigh has NTF_ROUTER
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>

From: Roopa Prabhu <roopa@cumulusnetworks.com>

[ Upstream commit 7aca011f88eb57be1b17b0216247f4e32ac54e29 ]

Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_arp_nd_proxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 2cf7716254be..d42e3904b498 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -311,7 +311,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 	/* Neighbor Advertisement */
 	memset(na, 0, sizeof(*na) + na_olen);
 	na->icmph.icmp6_type = NDISC_NEIGHBOUR_ADVERTISEMENT;
-	na->icmph.icmp6_router = 0; /* XXX: should be 1 ? */
+	na->icmph.icmp6_router = (n->flags & NTF_ROUTER) ? 1 : 0;
 	na->icmph.icmp6_override = 1;
 	na->icmph.icmp6_solicited = 1;
 	na->target = ns->target;
-- 
2.20.1

