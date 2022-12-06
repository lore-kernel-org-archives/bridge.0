Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 69A8D40915
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B3598408F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXyHyrMzVsh1denck4pjX6bxuHTnUid3ejMf09nWG38=;
 b=K4LsxDdyCWdlPYIcKmKVo7mjkGScr7asZIiqSa6ZpaBrGYLje8ElYdIwSdQWEKU9xLSf/mLtq/PCUzxoxIuMMXwMLMTiro2aeMo4LG+cAVaEnuL5i4NQHLlCVQEmqFuNvjgQr0/splfPuSiKWCGDTtfWhnlSXOM1poOpjlZdJwv6Y/I0ZE+Kxw9ly3CTOCKZBYKiSuk0RP6mA27C7PUQLEIMFkxuwPQDpq0LKFYq0UrYgcSL26aiXv5apOCLlsxS+FZyf/IlY//j23IWxymRXzTVBzhHgwMW7WKIPBc7XcFrXPmurGnPjsN6PhCfzWTxaJL/1wU5oWVt5cF9NiTScw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue,  6 Dec 2022 12:58:09 +0200
Message-Id: <20221206105809.363767-10-idosch@nvidia.com>
In-Reply-To: <20221206105809.363767-1-idosch@nvidia.com>
References: <20221206105809.363767-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 9/9] bridge: mcast: Constify 'group'
	argument in br_multicast_new_port_group()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

The 'group' argument is not modified, so mark it as 'const'. It will
allow us to constify arguments of the callers of this function in future
patches.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    * New patch.

 net/bridge/br_multicast.c | 2 +-
 net/bridge/br_private.h   | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 5e988f0ed2c0..db4c3900ae95 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1273,7 +1273,7 @@ br_multicast_new_group_src(struct net_bridge_port_group *pg, struct br_ip *src_i
 
 struct net_bridge_port_group *br_multicast_new_port_group(
 			struct net_bridge_port *port,
-			struct br_ip *group,
+			const struct br_ip *group,
 			struct net_bridge_port_group __rcu *next,
 			unsigned char flags,
 			const unsigned char *src,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 0a09f10966dc..3997e16c15fc 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -941,7 +941,8 @@ br_mdb_ip_get(struct net_bridge *br, struct br_ip *dst);
 struct net_bridge_mdb_entry *
 br_multicast_new_group(struct net_bridge *br, struct br_ip *group);
 struct net_bridge_port_group *
-br_multicast_new_port_group(struct net_bridge_port *port, struct br_ip *group,
+br_multicast_new_port_group(struct net_bridge_port *port,
+			    const struct br_ip *group,
 			    struct net_bridge_port_group __rcu *next,
 			    unsigned char flags, const unsigned char *src,
 			    u8 filter_mode, u8 rt_protocol);
-- 
2.37.3

