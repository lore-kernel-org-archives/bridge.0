Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD532DCC1C
	for <bridge@lists.linux.dev>; Fri,  6 Feb 2026 03:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346913; cv=none; b=IdEwfno29IjnbYe/c2kKRlQHqE94IJ7Wwg4U58A70ybkqGt+/mzXlLo34Tq/zeywv23guy7tcJM/1Rgw0gIAr7blVnKWApvN+ugJq+3DPHcDWQhVsxGtXnEURzThqbGQRaapED4W9E4aDObSYMMWW8TzDDSHQkN6pknhLGhLjUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346913; c=relaxed/simple;
	bh=e7gYPxwjXSvowlpp+bHbVcMmnV+svvWXurup9/rR6Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GObjjS1/aChGefq54u40jPMEEDRztA4bFivYei5WFhb/7keNOL2GXjZBgUmJW+YDry0HexbtuGys4DoesIMrZGAHEFiscNk8p5oI/ZeIkHjxrbQbGw9iKVAx3hmUK55tsRuLhQE01YSeYrJNBE2YbwmoD+L+sGYsFb5PCTTFLno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4FBE754CD34;
	Fri,  6 Feb 2026 04:01:49 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next v2 12/14] net: bridge: mcast: use combined active state in netlink
Date: Fri,  6 Feb 2026 03:52:18 +0100
Message-ID: <20260206030123.5430-13-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206030123.5430-1-linus.luessing@c0d3.blue>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Use the new multicast ip{4,6}_active variables for the netlink output.
The result for the user should be the same. But this allows us to check
that from userspace tests, to ensure that ip{4,6}_active behave as intended
for the upcoming fast/data path changes.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_netlink.c      | 10 ++--------
 net/bridge/br_private.h      |  2 +-
 net/bridge/br_vlan_options.c | 16 +++-------------
 3 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 1b5ab1fb4558..e79fddf747f8 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1650,8 +1650,6 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	u32 ageing_time = jiffies_to_clock_t(br->ageing_time);
 	u32 stp_enabled = br->stp_enabled;
 	u16 priority = (br->bridge_id.prio[0] << 8) | br->bridge_id.prio[1];
-	struct ethhdr eth6 = { .h_proto = htons(ETH_P_IPV6) };
-	struct ethhdr eth4 = { .h_proto = htons(ETH_P_IP) };
 	u8 vlan_enabled = br_vlan_enabled(br->dev);
 	struct br_boolopt_multi bm;
 	u64 clockval;
@@ -1724,9 +1722,7 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	    nla_put_u8(skb, IFLA_BR_MCAST_IGMP_VERSION,
 		       br->multicast_ctx.multicast_igmp_version) ||
 	    nla_put_u8(skb, IFLA_BR_MCAST_ACTIVE_V4,
-		       netif_running(brdev) && br_opt_get(br, BROPT_MULTICAST_ENABLED) &&
-		       !br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
-		       br_multicast_querier_exists(&br->multicast_ctx, &eth4, NULL)) ||
+		       READ_ONCE(br->multicast_ctx.ip4_active)) ||
 	    br_multicast_dump_querier_state(skb, &br->multicast_ctx,
 					    IFLA_BR_MCAST_QUERIER_STATE))
 		return -EMSGSIZE;
@@ -1734,9 +1730,7 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	if (nla_put_u8(skb, IFLA_BR_MCAST_MLD_VERSION,
 		       br->multicast_ctx.multicast_mld_version) ||
 	    nla_put_u8(skb, IFLA_BR_MCAST_ACTIVE_V6,
-		       netif_running(brdev) && br_opt_get(br, BROPT_MULTICAST_ENABLED) &&
-		       !br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
-		       br_multicast_querier_exists(&br->multicast_ctx, &eth6, NULL)))
+		       READ_ONCE(br->multicast_ctx.ip6_active)))
 		return -EMSGSIZE;
 #endif
 	clockval = jiffies_to_clock_t(br->multicast_ctx.multicast_last_member_interval);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 4cc59abdb8e1..8150ecc2c919 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1899,7 +1899,7 @@ int br_vlan_rtm_process_global_options(struct net_device *dev,
 bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
 					 const struct net_bridge_vlan *r_end);
 bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
-			      struct net_bridge_vlan *v_opts);
+			      const struct net_bridge_vlan *v_opts);
 
 /* vlan state manipulation helpers using *_ONCE to annotate lock-free access,
  * while br_vlan_set_state() may access data protected by multicast_lock.
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index 6425fa509b95..dcb214b5507d 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -347,10 +347,8 @@ bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
 }
 
 bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
-			      struct net_bridge_vlan *v_opts)
+			      const struct net_bridge_vlan *v_opts)
 {
-	struct ethhdr eth6 = { .h_proto = htons(ETH_P_IPV6) };
-	struct ethhdr eth4 = { .h_proto = htons(ETH_P_IP) };
 	struct nlattr *nest2 __maybe_unused;
 	u64 clockval __maybe_unused;
 	struct nlattr *nest;
@@ -372,11 +370,7 @@ bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION,
 		       v_opts->br_mcast_ctx.multicast_igmp_version) ||
 	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V4,
-		       netif_running(v_opts->br->dev) &&
-		       br_opt_get(v_opts->br, BROPT_MULTICAST_ENABLED) &&
-		       br_opt_get(v_opts->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
-		       !br_multicast_ctx_vlan_global_disabled(&v_opts->br_mcast_ctx) &&
-		       br_multicast_querier_exists(&v_opts->br_mcast_ctx, &eth4, NULL)) ||
+		       READ_ONCE(v_opts->br_mcast_ctx.ip4_active)) ||
 	    nla_put_u32(skb, BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_CNT,
 			v_opts->br_mcast_ctx.multicast_last_member_count) ||
 	    nla_put_u32(skb, BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT,
@@ -433,11 +427,7 @@ bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 	if (nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION,
 		       v_opts->br_mcast_ctx.multicast_mld_version) ||
 	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V6,
-		       netif_running(v_opts->br->dev) &&
-		       br_opt_get(v_opts->br, BROPT_MULTICAST_ENABLED) &&
-		       br_opt_get(v_opts->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
-		       !br_multicast_ctx_vlan_global_disabled(&v_opts->br_mcast_ctx) &&
-		       br_multicast_querier_exists(&v_opts->br_mcast_ctx, &eth6, NULL)))
+		       READ_ONCE(v_opts->br_mcast_ctx.ip6_active)))
 		goto out_err;
 #endif
 #endif
-- 
2.51.0

