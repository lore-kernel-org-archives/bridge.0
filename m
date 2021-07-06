Return-Path: <sashal@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625570156;
 bh=UIZQa9iSQhxcVaXMJJxbl1bvgrn5SEdBhZXIr0j9owk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Jtw9A6YhntZ9/WUFChD6fbVNxkJM5XymcKkRDFbIuOMGNfxbepMHhmzriv87GZC1Y
 JTauwuVaMO4BZnlezQrsfgJbj6j49TSkero6BQNN4Jst568HdkEzqc4c55SULQd4tU
 fJPSVogcU3GwMq7+7Y5Po5USVVo0RzDfzOWnoLeByrdFroimZZY210ECo62cHvDopR
 JpEEDHlR/qw7E048bwUturxUepoAO8mJf20s/ILskQcy3tYQrJ5mxaXwFc0GY4423u
 Au3/d3hTS8Ka35hBMZvntUDxCgqji6/F+4NvVZCc474MmEHtxqLP2CN12W626Q+8/2
 iyPxpzCjfF9Pg==
From: Sasha Levin <sashal@kernel.org>
Date: Tue,  6 Jul 2021 07:12:18 -0400
Message-Id: <20210706111409.2058071-78-sashal@kernel.org>
In-Reply-To: <20210706111409.2058071-1-sashal@kernel.org>
References: <20210706111409.2058071-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH AUTOSEL 5.13 078/189] net: bridge: mrp: Update ring
	transitions.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Horatiu Vultur <horatiu.vultur@microchip.com>, "David S . Miller" <davem@davemloft.net>

From: Horatiu Vultur <horatiu.vultur@microchip.com>

[ Upstream commit fcb34635854a5a5814227628867ea914a9805384 ]

According to the standard IEC 62439-2, the number of transitions needs
to be counted for each transition 'between' ring state open and ring
state closed and not from open state to closed state.

Therefore fix this for both ring and interconnect ring.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_mrp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index cd2b1e424e54..f7012b7d7ce4 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -627,8 +627,7 @@ int br_mrp_set_ring_state(struct net_bridge *br,
 	if (!mrp)
 		return -EINVAL;
 
-	if (mrp->ring_state == BR_MRP_RING_STATE_CLOSED &&
-	    state->ring_state != BR_MRP_RING_STATE_CLOSED)
+	if (mrp->ring_state != state->ring_state)
 		mrp->ring_transitions++;
 
 	mrp->ring_state = state->ring_state;
@@ -715,8 +714,7 @@ int br_mrp_set_in_state(struct net_bridge *br, struct br_mrp_in_state *state)
 	if (!mrp)
 		return -EINVAL;
 
-	if (mrp->in_state == BR_MRP_IN_STATE_CLOSED &&
-	    state->in_state != BR_MRP_IN_STATE_CLOSED)
+	if (mrp->in_state != state->in_state)
 		mrp->in_transitions++;
 
 	mrp->in_state = state->in_state;
-- 
2.30.2

