Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1622803083; x=1654339083;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4sXc9RFUGLKrPBrTE/aA0NwwQbDYVun7rUmFq44v2zA=;
 b=KZmv+fk030p1ROt1V3Mb0BeYbAb9YOJmx0mZuNGvEFSzTngDIaoW+GKF
 NixSCOP7VvGa3IpLKpHDVha3ym9Wg/jR0q32rk9Mdp79ihgdDjm7OKvzG
 S+OX8Oheyl9zFMN2fnUpsMeaVOqqAepXBzEh5rOoZf1hjtiGPLLuetuUu
 7o9Y+/WbyoYcSkfpLEw3t+6s8tnEeXPDMQWLYhptrpnkeLNhFYTJhFcsq
 ppHWY/lZ/D6rJLP120jjFhEuvCZ2iz1FnwzvkOEueeFKHp00nLKFqdnj3
 6rqmQpzN5IuVcEQ4lFaPv+eSWHNkBJgUgFZUFGbHSv6Non0LL4lRH3lKH w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Fri, 4 Jun 2021 12:37:47 +0200
Message-ID: <20210604103747.3824212-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next] net: bridge: mrp: Update ring transitions.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@nvidia.com, nikolay@nvidia.com, davem@davemloft.net, kuba@kernel.org, UNGLinuxDriver@microchip.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Horatiu Vultur <horatiu.vultur@microchip.com>

According to the standard IEC 62439-2, the number of transitions needs
to be counted for each transition 'between' ring state open and ring
state closed and not from open state to closed state.

Therefore fix this for both ring and interconnect ring.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
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
2.31.1

