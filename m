Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=c9WOOXaljgWkUz7GKIj1bERwrld5Mm5ktuTMXSqIFb4=;
 b=BwFg/RhK8pd6whM6m4oSg1lq+EeRNAviO+SgvZhFXQPCabtNQj9jmAEuVepKXkAEPZ
 UQlDxjx2rJQZdbWMtO2wpXgVsYhx/Ne5QRigmvZklC3yUfKvatqVwHBsYFwQ8el1NnLU
 KXO84ZvEP/RR/XpOmhN5EI6YT340d5nz0+Z6xRd/8ExVpiSDly8wJ23ktXYPa4vUWpum
 mBnJvdAltVr5eFEv93bblL6yWWdeHbE7AYoWqJP3AHZMsFFk62fpws99BRnclIj3+EAf
 9Cn/HNuqeyL86jBFG+mGSQTkDfY9mRcVyQKRNoWLObHRxMRmgOlbkpzZOkiZmxGxpSGs
 VqhQ==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Sun,  7 Feb 2021 21:47:33 +0200
Message-Id: <20210207194733.1811529-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] net: bridge: use switchdev for port flags set
	through sysfs too
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Looking through patchwork I don't see that there was any consensus to
use switchdev notifiers only in case of netlink provided port flags but
not sysfs (as a sort of deprecation, punishment or anything like that),
so we should probably keep the user interface consistent in terms of
functionality.

http://patchwork.ozlabs.org/project/netdev/patch/20170605092043.3523-3-jiri@resnulli.us/
http://patchwork.ozlabs.org/project/netdev/patch/20170608064428.4785-3-jiri@resnulli.us/

Fixes: 3922285d96e7 ("net: bridge: Add support for offloading port attributes")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/bridge/br_sysfs_if.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 96ff63cde1be..5aea9427ffe1 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -59,9 +59,8 @@ static BRPORT_ATTR(_name, 0644,					\
 static int store_flag(struct net_bridge_port *p, unsigned long v,
 		      unsigned long mask)
 {
-	unsigned long flags;
-
-	flags = p->flags;
+	unsigned long flags = p->flags;
+	int err;
 
 	if (v)
 		flags |= mask;
@@ -69,6 +68,10 @@ static int store_flag(struct net_bridge_port *p, unsigned long v,
 		flags &= ~mask;
 
 	if (flags != p->flags) {
+		err = br_switchdev_set_port_flag(p, flags, mask);
+		if (err)
+			return err;
+
 		p->flags = flags;
 		br_port_flags_change(p, mask);
 	}
-- 
2.25.1

