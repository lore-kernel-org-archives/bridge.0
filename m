Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F6D3254A3
	for <bridge@lists.linux.dev>; Mon,  2 Mar 2026 05:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772430055; cv=none; b=XL+8fV9B7XZeQ8PGna8z5bpMc2Zu4VBucyxJLhT+3IwTPdTZLZnX4GDrN0uNnCJfPH2qJ5L7Gs1Cgsnyg1bpMUw89m4DuQ1H9kyrL0N+DwcadKbB6dpe6AABbXv/nFgxLtSUqEtUzL55LP3PqWHZAlfN0wtwCECp+HVOWB8XGno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772430055; c=relaxed/simple;
	bh=69GiURr/LTY5cK+XpvRYlU7l/pOvKG8gtu+iPoUISBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ys3bLwfUgAs1eZjRiWcANw+EwIIcNSoNedwpP8ob4fx7PKWMHJ5fXK8LrHn+joYdVl52LRE5s4yupbSJV/AjMF9y2KLenV3FZI55hieWYMY+GAmVUnIsRh9XUiDla7OPG9f9oeLPFtWnztsAmzx3GzP9x24WOxVFli9J32eNOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 97F3254CC69;
	Mon,  2 Mar 2026 06:40:51 +0100 (CET)
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
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next v3 08/14] net: bridge: mcast: track active state, if snooping is enabled
Date: Mon,  2 Mar 2026 06:40:02 +0100
Message-ID: <20260302054008.21638-9-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302054008.21638-1-linus.luessing@c0d3.blue>
References: <20260302054008.21638-1-linus.luessing@c0d3.blue>
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
index 6c4b239c70eb..7887ed9af53a 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1122,6 +1122,7 @@ static void br_multicast_notify_active(struct net_bridge_mcast *brmctx,
  *
  * The multicast active state is set, per protocol family, if:
  *
+ * - multicast snooping is enabled
  * - an IGMP/MLD querier is present
  * - for own IPv6 MLD querier: an IPv6 link-local address is configured on the bridge
  *
@@ -1137,6 +1138,9 @@ static void br_multicast_update_active(struct net_bridge_mcast *brmctx)
 
 	lockdep_assert_held_once(&brmctx->br->multicast_lock);
 
+	if (!br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED))
+		force_inactive = true;
+
 	br_ip4_multicast_update_active(brmctx, force_inactive);
 	br_ip6_multicast_update_active(brmctx, force_inactive);
 
@@ -1351,6 +1355,12 @@ static struct sk_buff *br_multicast_alloc_query(struct net_bridge_mcast *brmctx,
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
@@ -1364,7 +1374,7 @@ struct net_bridge_mdb_entry *br_multicast_new_group(struct net_bridge *br,
 	if (atomic_read(&br->mdb_hash_tbl.nelems) >= br->hash_max) {
 		trace_br_mdb_full(br->dev, group);
 		br_mc_disabled_update(br->dev, false, NULL);
-		br_opt_toggle(br, BROPT_MULTICAST_ENABLED, false);
+		br_multicast_toggle_enabled(br, false);
 		return ERR_PTR(-E2BIG);
 	}
 
@@ -4827,7 +4837,8 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val,
 	if (err)
 		goto unlock;
 
-	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, !!val);
+	br_multicast_toggle_enabled(br, !!val);
+
 	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED)) {
 		change_snoopers = true;
 		br_multicast_del_grps(br);
-- 
2.51.0

