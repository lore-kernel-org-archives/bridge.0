Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F84033E37A
	for <bridge@lists.linux.dev>; Sat,  7 Mar 2026 04:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772858776; cv=none; b=pi/ytZ8UYc+3+NiSzRemjSiFvwMpohE9cFqIW/KVnHQmWSQCu5Ck5wR9JBi+7LgLDcabB1hzT4NAd6jdYTMGPVI5uAZCk3dqBSOxBkbs9Z6/IPec/ullw908ZuNmnig4kUaqBO4NgN+8YqpGtPaZnWAmV7NCnYLOKUm1Dnegxhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772858776; c=relaxed/simple;
	bh=d7YT/fenrAZV23uVHfcOmBXe4qPxQQj4VvB7mBZMEcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhmDvSsMDXEdTwVyk9v4j9T120DZBcM4LCX1eQ6/QRiqnu1dLHCk4mvmjF/IUYTC6DTMKtTpP7cmev0WLrDAlFw3lVT/rJ0K8LY9ZDgXEWCVvmABJkj5byQgfc9kQzviFd+k91fyvfn6bgoLIQ3k9/ePOldymsWaCJJnGmuy5p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B378A54CEA2;
	Sat,  7 Mar 2026 05:46:11 +0100 (CET)
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
Subject: [PATCH net-next v4 08/14] net: bridge: mcast: track active state, if snooping is enabled
Date: Sat,  7 Mar 2026 05:45:42 +0100
Message-ID: <20260307044548.5230-9-linus.luessing@c0d3.blue>
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

To be able to use the upcoming SWITCHDEV_ATTR_ID_BRIDGE_MC_ACTIVE
as a potential replacement for SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED
also check and toggle the active state if multicast snooping is enabled
or disabled. So that MC_ACTIVE not only checks the querier state, but
also if multicast snooping is enabled in general.

No functional change for the fast/data path yet.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/if_link.h |  6 ++++--
 net/bridge/br_multicast.c    | 15 +++++++++++++--
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 66c59953d301..d963be8679b5 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -748,12 +748,14 @@ enum in6_addr_gen_mode {
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
index f37a18f3713c..cdc921b97243 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1124,6 +1124,7 @@ static void br_multicast_notify_active(struct net_bridge_mcast *brmctx,
  *
  * The multicast active state is set, per protocol family, if:
  *
+ * - multicast snooping is enabled
  * - an IGMP/MLD querier is present
  * - for own IPv6 MLD querier: an IPv6 link-local address is configured on the
  *   bridge
@@ -1141,6 +1142,9 @@ static void br_multicast_update_active(struct net_bridge_mcast *brmctx)
 
 	lockdep_assert_held_once(&brmctx->br->multicast_lock);
 
+	if (!br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED))
+		force_inactive = true;
+
 	br_ip4_multicast_update_active(brmctx, force_inactive);
 	br_ip6_multicast_update_active(brmctx, force_inactive);
 
@@ -1355,6 +1359,12 @@ static struct sk_buff *br_multicast_alloc_query(struct net_bridge_mcast *brmctx,
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
@@ -1368,7 +1378,7 @@ struct net_bridge_mdb_entry *br_multicast_new_group(struct net_bridge *br,
 	if (atomic_read(&br->mdb_hash_tbl.nelems) >= br->hash_max) {
 		trace_br_mdb_full(br->dev, group);
 		br_mc_disabled_update(br->dev, false, NULL);
-		br_opt_toggle(br, BROPT_MULTICAST_ENABLED, false);
+		br_multicast_toggle_enabled(br, false);
 		return ERR_PTR(-E2BIG);
 	}
 
@@ -4853,7 +4863,8 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val,
 	if (err)
 		goto unlock;
 
-	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, !!val);
+	br_multicast_toggle_enabled(br, !!val);
+
 	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED)) {
 		change_snoopers = true;
 		br_multicast_del_grps(br);
-- 
2.53.0

