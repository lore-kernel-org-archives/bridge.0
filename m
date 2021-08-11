Return-Path: <dqfext@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=McZHw6sQ4TwpaGC2g78JrbLUmpP0WSdIbTjyHIQHZDg=;
 b=IX2JCs+zddAvzfStvaEUhhbbYHBSt9n8HTPWZ3/t5mQ1TU3rlXnmZzyeO6NqlMVniN
 IlsOhAoy5rjlKPxKf1nDNMSRzYcCkuQXGZTaPjS9X5Df3HKv6AOb/Dq9kkRV3YhHBAYS
 Txyz8cSrY0O8FSCRMbuPV3ONHUxjWZ+MI4St8yeA8CTSDSp6AQMrrTzfAsv6k/lxX5sS
 fmR1h6LqYPgX5fuQkMpUhjvAn4EohaQqLlQD9CQpjAocSj2pjYcmzP6UOEEo+7sku4P/
 osqfp7ya4/LoEf85EZaokcXQe97Pt/WHoh49edxjQXSJgHHsPHB02IUz8atH/NyRNWjc
 7OwA==
From: DENG Qingfang <dqfext@gmail.com>
Date: Wed, 11 Aug 2021 21:52:46 +0800
Message-Id: <20210811135247.1703496-1-dqfext@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] net: bridge: switchdev: allow port
	isolation to be offloaded
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, "open list:ETHERNET BRIDGE" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>

Add BR_ISOLATED flag to BR_PORT_FLAGS_HW_OFFLOAD, to allow switchdev
drivers to offload port isolation.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: DENG Qingfang <dqfext@gmail.com>
---
 net/bridge/br_switchdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 6bf518d78f02..898257153883 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -71,7 +71,8 @@ bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
 
 /* Flags that can be offloaded to hardware */
 #define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | \
-				  BR_MCAST_FLOOD | BR_BCAST_FLOOD)
+				  BR_MCAST_FLOOD | BR_BCAST_FLOOD | \
+				  BR_ISOLATED)
 
 int br_switchdev_set_port_flag(struct net_bridge_port *p,
 			       unsigned long flags,
-- 
2.25.1

