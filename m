Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mtj5BWUVGyinNX7wvC73dcZuNmbbOVj5imGPpnqwC7s=;
 b=DYp8SwaR2RtLl8bAH4YtgflR2ni8IhDhhdGRpD50QqlucoswbUPkbngw/FOuoWA5u6
 klQB+ECYE54zTCpHLMNmnfv7vTigPUKItG3YEZNenCaHNCu/4x3HYaTkFyVpCmkfroJD
 JIoCb+UGy6A5aUy+bsiwt58xiyK+daw7J+eJ4=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 24 Jan 2020 13:40:19 +0200
Message-Id: <20200124114022.10883-2-nikolay@cumulusnetworks.com>
In-Reply-To: <20200124114022.10883-1-nikolay@cumulusnetworks.com>
References: <20200124114022.10883-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 1/4] net: bridge: check port state
	before br_allowed_egress
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

If we make sure that br_allowed_egress is called only when we have
BR_STATE_FORWARDING state then we can avoid a test later when we add
per-vlan state.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_forward.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 86637000f275..7629b63f6f30 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -25,7 +25,7 @@ static inline int should_deliver(const struct net_bridge_port *p,
 
 	vg = nbp_vlan_group_rcu(p);
 	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&
-		br_allowed_egress(vg, skb) && p->state == BR_STATE_FORWARDING &&
+		p->state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
 		nbp_switchdev_allowed_egress(p, skb) &&
 		!br_skb_isolated(p, skb);
 }
-- 
2.21.0

