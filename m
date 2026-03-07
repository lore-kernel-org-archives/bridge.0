Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E5235A38B
	for <bridge@lists.linux.dev>; Sat,  7 Mar 2026 04:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772858781; cv=none; b=Yp9qWC3KdQJxtl1C7ivfVpGqgABU0pVlktkVRsUcXxHYnGvf76hERbI19c8Q3CREd8MQfyCxZ/AuFxYO+Rw/y9G7URqidXHVV0bIhAbI89OMijjemxtLTyqhKrtx5SzmkVpRh3ry4aTDKw0yrKGlqTi97vKg29i1ISzzvnZFv8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772858781; c=relaxed/simple;
	bh=GmThW4QYajkqIjKYnPrIQN/OrxYNIx6aoBVIkWHo+Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5LEBWhhEQaDpqbr0IYgQjXjsNAma5Zq6ClAPZ8fa4Ip2YH5cwMoShOH9/bjrKiDATBw4X9nIPRJ0i9tDiT4jC4vAWM/Vv9A+pLht/Np1lnsE6shLimKFaduS4RrjyYtY6Gs74+wfwpjc1PqF/jQRmjmhk3DWHB5Fz0avbnVtWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7769454CE9A;
	Sat,  7 Mar 2026 05:46:17 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
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
	shuah@kernel.org,
	petrm@nvidia.com,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next v4 12/14] net: bridge: mcast: use combined active state in netlink
Date: Sat,  7 Mar 2026 05:45:46 +0100
Message-ID: <20260307044548.5230-13-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260307044548.5230-1-linus.luessing@c0d3.blue>
References: <20260307044548.5230-1-linus.luessing@c0d3.blue>
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
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_netlink.c      | 14 ++------------
 net/bridge/br_private.h      |  2 +-
 net/bridge/br_vlan_options.c | 23 +++++------------------
 3 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 7fff59c3bf76..e79fddf747f8 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1643,8 +1643,6 @@ static size_t br_get_size(const struct net_device *brdev)
 
 static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 {
-	struct ethhdr eth6 __maybe_unused = { .h_proto = htons(ETH_P_IPV6) };
-	struct ethhdr eth4 __maybe_unused = { .h_proto = htons(ETH_P_IP) };
 	struct net_bridge *br = netdev_priv(brdev);
 	u32 forward_delay = jiffies_to_clock_t(br->forward_delay);
 	u32 hello_time = jiffies_to_clock_t(br->hello_time);
@@ -1724,11 +1722,7 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	    nla_put_u8(skb, IFLA_BR_MCAST_IGMP_VERSION,
 		       br->multicast_ctx.multicast_igmp_version) ||
 	    nla_put_u8(skb, IFLA_BR_MCAST_ACTIVE_V4,
-		       netif_running(brdev) &&
-		       br_opt_get(br, BROPT_MULTICAST_ENABLED) &&
-		       !br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
-		       br_multicast_querier_exists(&br->multicast_ctx, &eth4,
-						   NULL)) ||
+		       READ_ONCE(br->multicast_ctx.ip4_active)) ||
 	    br_multicast_dump_querier_state(skb, &br->multicast_ctx,
 					    IFLA_BR_MCAST_QUERIER_STATE))
 		return -EMSGSIZE;
@@ -1736,11 +1730,7 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	if (nla_put_u8(skb, IFLA_BR_MCAST_MLD_VERSION,
 		       br->multicast_ctx.multicast_mld_version) ||
 	    nla_put_u8(skb, IFLA_BR_MCAST_ACTIVE_V6,
-		       netif_running(brdev) &&
-		       br_opt_get(br, BROPT_MULTICAST_ENABLED) &&
-		       !br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
-		       br_multicast_querier_exists(&br->multicast_ctx, &eth6,
-						   NULL)))
+		       READ_ONCE(br->multicast_ctx.ip6_active)))
 		return -EMSGSIZE;
 #endif
 	clockval = jiffies_to_clock_t(br->multicast_ctx.multicast_last_member_interval);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 8d1c869eb522..2bdfc93499fc 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1909,7 +1909,7 @@ int br_vlan_rtm_process_global_options(struct net_device *dev,
 bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
 					 const struct net_bridge_vlan *r_end);
 bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
-			      struct net_bridge_vlan *v_opts);
+			      const struct net_bridge_vlan *v_opts);
 
 /* vlan state manipulation helpers using *_ONCE to annotate lock-free access,
  * while br_vlan_set_state() may access data protected by multicast_lock.
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index 06045d68a2d1..47ad35583a3f 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -367,13 +367,10 @@ bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
 }
 
 bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
-			      struct net_bridge_vlan *v_opts)
+			      const struct net_bridge_vlan *v_opts)
 {
-	struct ethhdr eth6 __maybe_unused = { .h_proto = htons(ETH_P_IPV6) };
-	struct ethhdr eth4 __maybe_unused = { .h_proto = htons(ETH_P_IP) };
 	struct nlattr *nest2 __maybe_unused;
 	u64 clockval __maybe_unused;
-	bool mcact __maybe_unused;
 	struct nlattr *nest;
 
 	nest = nla_nest_start(skb, BRIDGE_VLANDB_GLOBAL_OPTIONS);
@@ -388,17 +385,12 @@ bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 		goto out_err;
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
-	mcact = netif_running(v_opts->br->dev) &&
-		br_opt_get(v_opts->br, BROPT_MULTICAST_ENABLED) &&
-		br_opt_get(v_opts->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
-		!br_multicast_ctx_vlan_global_disabled(&v_opts->br_mcast_ctx) &&
-		br_multicast_querier_exists(&v_opts->br_mcast_ctx, &eth4, NULL);
-
 	if (nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_SNOOPING,
 		       !!(v_opts->priv_flags & BR_VLFLAG_GLOBAL_MCAST_ENABLED)) ||
 	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION,
 		       v_opts->br_mcast_ctx.multicast_igmp_version) ||
-	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V4, mcact) ||
+	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V4,
+		       READ_ONCE(v_opts->br_mcast_ctx.ip4_active)) ||
 	    nla_put_u32(skb, BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_CNT,
 			v_opts->br_mcast_ctx.multicast_last_member_count) ||
 	    nla_put_u32(skb, BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT,
@@ -452,15 +444,10 @@ bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 	}
 
 #if IS_ENABLED(CONFIG_IPV6)
-	mcact = netif_running(v_opts->br->dev) &&
-		br_opt_get(v_opts->br, BROPT_MULTICAST_ENABLED) &&
-		br_opt_get(v_opts->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
-		!br_multicast_ctx_vlan_global_disabled(&v_opts->br_mcast_ctx) &&
-		br_multicast_querier_exists(&v_opts->br_mcast_ctx, &eth6, NULL);
-
 	if (nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION,
 		       v_opts->br_mcast_ctx.multicast_mld_version) ||
-	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V6, mcact))
+	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V6,
+		       READ_ONCE(v_opts->br_mcast_ctx.ip6_active)))
 		goto out_err;
 #endif
 #endif
-- 
2.53.0

