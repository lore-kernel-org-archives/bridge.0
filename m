Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2309341590
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60E6E41452
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwfQnYosgyTCzsOoJa7Ffb+0KyzF3LYxZylri88XmIw=;
 b=l1k7cJXO50PU/tL6BSDZ3UrfuyUiM6cnjtTNjZlJSOZgbyOuKQmv/+KtykcZ90LOtGWO+gl40iDs+y4iG5Q5UpUEuc9D6gLtFZ9mebRe12CIc222eQIkSQKChEAoGUpkwzXyo6D0ZAXgpLXLj8tdfMJgDjYTK93/wDmaUwn4ZjvHh2sVF8l6aTba4b0YCU2+bkubtMliDb43LsiFdbhPZ7ouCbEY0nQd2Bz6t+X8HTQSYgZsTiDiQxwGnxO9r1vwntEc0/nkX5fbGHRyL0TPOjb56p0/hzP4qWUm4S8jQ9yYDzr+Qgx5gGz8w2QDNdvS106YA2oJshJUcZglovO9rg==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu, 13 Apr 2023 12:58:24 +0300
Message-Id: <20230413095830.2182382-4-idosch@nvidia.com>
In-Reply-To: <20230413095830.2182382-1-idosch@nvidia.com>
References: <20230413095830.2182382-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 3/9] bridge: Add internal flags for
	per-{Port, VLAN} neighbor suppression
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Add two internal flags that will be used to enable / disable per-{Port,
VLAN} neighbor suppression:

1. 'BR_NEIGH_VLAN_SUPPRESS': A per-port flag used to indicate that
per-{Port, VLAN} neighbor suppression is enabled on the bridge port.
When set, 'BR_NEIGH_SUPPRESS' has no effect.

2. 'BR_VLFLAG_NEIGH_SUPPRESS_ENABLED': A per-VLAN flag used to indicate
that neighbor suppression is enabled on the given VLAN.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/linux/if_bridge.h | 1 +
 net/bridge/br_private.h   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 1668ac4d7adc..3ff96ae31bf6 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -60,6 +60,7 @@ struct br_ip_list {
 #define BR_TX_FWD_OFFLOAD	BIT(20)
 #define BR_PORT_LOCKED		BIT(21)
 #define BR_PORT_MAB		BIT(22)
+#define BR_NEIGH_VLAN_SUPPRESS	BIT(23)
 
 #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 1ff4d64ab584..b17fc821ecc8 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -178,6 +178,7 @@ enum {
 	BR_VLFLAG_ADDED_BY_SWITCHDEV = BIT(1),
 	BR_VLFLAG_MCAST_ENABLED = BIT(2),
 	BR_VLFLAG_GLOBAL_MCAST_ENABLED = BIT(3),
+	BR_VLFLAG_NEIGH_SUPPRESS_ENABLED = BIT(4),
 };
 
 /**
-- 
2.37.3

