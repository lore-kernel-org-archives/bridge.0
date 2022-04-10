Return-Path: <arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649598159; 
 s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
 bh=nUJ6HOSqvkRRMt2eDoWZ7kiFdlMq4tupafRJGJ7omfg=;
 b=BwBdWBIb4azU/DtAQvAmqrw2QOtt2sTm+PeRjZzT/UtnKAEivHFAR3NWchR39fVA
 gk4LRFqoUi0SUXHTKPD1Qq+q3kd7KCmve6SRArDsoDjXKUu1ZRJLqsr6GyrUgNAVAcR
 +r72pq3gf4KLtziMTJYPRZcjnHNTzAqzKVWSQ25A=
From: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Date: Sun, 10 Apr 2022 16:42:27 +0300
Message-Id: <20220410134227.18810-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] net: bridge: offload BR_HAIRPIN_MODE,
	BR_ISOLATED, BR_MULTICAST_TO_UNICAST
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>

Add BR_HAIRPIN_MODE, BR_ISOLATED and BR_MULTICAST_TO_UNICAST port flags to
BR_PORT_FLAGS_HW_OFFLOAD so that switchdev drivers which have an offloaded
data plane have a chance to reject these bridge port flags if they don't
support them yet.

It makes the code path go through the
SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS driver handlers, which return
-EINVAL for everything they don't recognize.

For drivers that don't catch SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS at
all, switchdev will return -EOPNOTSUPP for those which is then ignored, but
those are in the minority.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Let me know if this is netdev/net material instead.

Commit log is heavily quoted from Vladimir Oltean <olteanv@gmail.com>.

Arınç
---
 net/bridge/br_switchdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 8cc44c367231..81400e0b26ac 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -72,7 +72,8 @@ bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
 
 /* Flags that can be offloaded to hardware */
 #define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | \
-				  BR_MCAST_FLOOD | BR_BCAST_FLOOD | BR_PORT_LOCKED)
+				  BR_MCAST_FLOOD | BR_BCAST_FLOOD | BR_PORT_LOCKED | \
+				  BR_HAIRPIN_MODE | BR_ISOLATED | BR_MULTICAST_TO_UNICAST)
 
 int br_switchdev_set_port_flag(struct net_bridge_port *p,
 			       unsigned long flags,
-- 
2.25.1

