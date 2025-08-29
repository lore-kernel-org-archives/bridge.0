Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B985C2C11D2
	for <bridge@lists.linux.dev>; Fri, 29 Aug 2025 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457870; cv=none; b=ZW4zJGX+SWfc3r03OaT8m42mZAmiOw5HC4/uaoxRYYLjli+uFf9CoTkQIiNO1PvQBmHj9Qe1DV2qvhj3B4AQ2ltEwffOXgEvMtwKKydz2A/QxgPkXRoHj9kIyf9V9OAUbLK1+OUD07LfvA/94tkwY/kugoeZJXyiy1PG/MHUAVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457870; c=relaxed/simple;
	bh=hIcmWdt6oCUpiVjncW8Q9KsvVg1CUjk/pioAO7KtjR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPLsY+cTyuVw5pYg/eNI1jbyKk4vMvtwoj1oWGTVTZSZCwhKH8oJa+jez/vE48NZFOvBRXkCwLTARI5CZePWiN8tjVaBmYK+43PRHajXSuogIOJGYSCnp8D30+3N5GJB3NMfG7LxvGAEg8XEgh377n+M0pX9XowQUwzthM959PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC37A54F6CA;
	Fri, 29 Aug 2025 10:57:43 +0200 (CEST)
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
Subject: [PATCH 7/9] net: bridge: mcast: active state, if snooping is enabled
Date: Fri, 29 Aug 2025 10:53:48 +0200
Message-ID: <20250829085724.24230-8-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250829085724.24230-1-linus.luessing@c0d3.blue>
References: <20250829085724.24230-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

To be able to use the upcoming SWITCHDEV_ATTR_ID_BRIDGE_MC_ACTIVE
as a potential replacement for SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED
also check and toggle the active state if multicast snooping is enabled
or disabled. So that MC_ACTIVE not only checks the querier state, but
also if multicast snooping is enabled in general.

No functional change for the fast/data path yet.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/if_link.h |  6 ++++--
 net/bridge/br_multicast.c    | 21 +++++++++++++++++++--
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index fcf2c42aa6c4..ef686ea17afe 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -746,12 +746,14 @@ enum in6_addr_gen_mode {
  * @IFLA_BR_MCAST_ACTIVE_V4
  *   Bridge IPv4 mcast active state, read only.
  *
- *   1 if an IGMP querier is present, 0 otherwise.
+ *   1 if *IFLA_BR_MCAST_SNOOPING* is enabled and an IGMP querier is present,
+ *   0 otherwise.
  *
  * @IFLA_BR_MCAST_ACTIVE_V6
  *   Bridge IPv6 mcast active state, read only.
  *
- *   1 if an MLD querier is present, 0 otherwise.
+ *   1 if *IFLA_BR_MCAST_SNOOPING* is enabled and an MLD querier is present,
+ *   0 otherwise.
  */
 enum {
 	IFLA_BR_UNSPEC,
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 54163c74b9a9..53720337a1e3 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1145,6 +1145,7 @@ static void br_ip6_multicast_update_active(struct net_bridge_mcast *brmctx,
  *
  * The multicast active state is set, per protocol family, if:
  *
+ * - multicast snooping is enabled
  * - an IGMP/MLD querier is present
  * - for own IPv6 MLD querier: an IPv6 address is configured on the bridge
  *
@@ -1159,6 +1160,13 @@ static void br_multicast_update_active(struct net_bridge_mcast *brmctx)
 
 	lockdep_assert_held_once(&brmctx->br->multicast_lock);
 
+	if (!br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED))
+		force_inactive = true;
+
+	if (br_opt_get(brmctx->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
+	    br_multicast_ctx_vlan_disabled(brmctx))
+		force_inactive = true;
+
 	br_ip4_multicast_update_active(brmctx, force_inactive);
 	br_ip6_multicast_update_active(brmctx, force_inactive);
 }
@@ -1371,6 +1379,12 @@ static struct sk_buff *br_multicast_alloc_query(struct net_bridge_mcast *brmctx,
 	return NULL;
 }
 
+static void br_multicast_toggle_enabled(struct net_bridge *br, bool on)
+{
+	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, on);
+	br_multicast_update_active(&br->multicast_ctx);
+}
+
 struct net_bridge_mdb_entry *br_multicast_new_group(struct net_bridge *br,
 						    struct br_ip *group)
 {
@@ -1384,7 +1398,7 @@ struct net_bridge_mdb_entry *br_multicast_new_group(struct net_bridge *br,
 	if (atomic_read(&br->mdb_hash_tbl.nelems) >= br->hash_max) {
 		trace_br_mdb_full(br->dev, group);
 		br_mc_disabled_update(br->dev, false, NULL);
-		br_opt_toggle(br, BROPT_MULTICAST_ENABLED, false);
+		br_multicast_toggle_enabled(br, false);
 		return ERR_PTR(-E2BIG);
 	}
 
@@ -4452,6 +4466,7 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 
 		spin_lock_bh(&br->multicast_lock);
 		vlan->priv_flags ^= BR_VLFLAG_MCAST_ENABLED;
+		br_multicast_update_active(&vlan->br_mcast_ctx);
 		spin_unlock_bh(&br->multicast_lock);
 
 		if (on)
@@ -4472,6 +4487,7 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 			__br_multicast_enable_port_ctx(&vlan->port_mcast_ctx);
 		else
 			__br_multicast_disable_port_ctx(&vlan->port_mcast_ctx);
+		br_multicast_update_active(brmctx);
 		spin_unlock_bh(&br->multicast_lock);
 	}
 }
@@ -4792,7 +4808,8 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val,
 	if (err)
 		goto unlock;
 
-	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, !!val);
+	br_multicast_toggle_enabled(br, !!val);
+
 	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED)) {
 		change_snoopers = true;
 		goto unlock;
-- 
2.50.1

