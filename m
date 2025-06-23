Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569781FBEBD
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671283; cv=none; b=TOraxpcss/2s9e8Xsh5wgBMNlHrt83T1cLz0xzRM330AcqmYGT8UmU3z9FqyzADYJycCQomBmi58NAR9yaoPrW6v8EIi1LjIUfoNr1Zl3pS6/bs0W/fX3Yi5B/diKxwPV7IKTViSBWJc/lpSzGqCuGQhx8Hhv+qN9EMh5p3LXpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671283; c=relaxed/simple;
	bh=rik6Cc5LOXAKz5qAkrBxOXpf/Gz/uC8c3KA9evuRGDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gY2VpglYuiZvtUgNFE3NRVndvIVvMCa/6AInuBGP/zVI/tU3t0RnozKz20b5ziKA34aVzaRWVhTzavA5goyCACt92YtfMMSnKbb3Fu9kySTVCzYsNBPXPjRQrTk6mY/9cgtvJonOaU6DHZbQI9WKowFVkWvqXO+kK/NvMJTWstQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8D32407DA
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 09:34:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.2
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FmOsk-YccCwd for <bridge@lists.linux-foundation.org>;
 Mon, 23 Jun 2025 09:34:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=fpf@pengutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 39D39407CD
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 39D39407CD
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 39D39407CD
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 09:34:41 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTdZT-0007re-Rm; Mon, 23 Jun 2025 11:34:35 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTdZT-004vQV-1m;
	Mon, 23 Jun 2025 11:34:35 +0200
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTdZT-0056jF-1a;
	Mon, 23 Jun 2025 11:34:35 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	idosch@nvidia.com,
	bridge@lists.linux-foundation.org,
	entwicklung@pengutronix.de,
	razor@blackwall.org,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH iproute2-next v5 1/3] bridge: move mcast querier dumping code into a shared function
Date: Mon, 23 Jun 2025 11:33:16 +0200
Message-Id: <20250623093316.1215970-2-f.pfitzner@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250623093316.1215970-1-f.pfitzner@pengutronix.de>
References: <20250623093316.1215970-1-f.pfitzner@pengutronix.de>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: fpf@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bridge@lists.linux-foundation.org

Put mcast querier dumping code into a shared function. This function
will be called from the bridge utility in a later patch.

Adapt the code such that the vtb parameter is used
instead of tb[IFLA_BR_MCAST_QUERIER_STATE].

Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
---

I decided to not only move the code into a separate function, but also
to adapt it to fit into the function. If I split it into a pure refactoring
and an adapting commit, the former will not compile preventing git bisects.

---
 include/bridge.h   |  3 +++
 ip/iplink_bridge.c | 59 +++-----------------------------------------
 lib/bridge.c       | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 56 deletions(-)

diff --git a/include/bridge.h b/include/bridge.h
index 8bcd1e38..8b0942b5 100644
--- a/include/bridge.h
+++ b/include/bridge.h
@@ -3,9 +3,12 @@
 #define __BRIDGE_H__ 1

 #include <linux/if_bridge.h>
+#include <linux/rtnetlink.h>

 void bridge_print_vlan_flags(__u16 flags);
 void bridge_print_vlan_stats_only(const struct bridge_vlan_xstats *vstats);
 void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats);

+void bridge_print_mcast_querier_state(const struct rtattr *vtb);
+
 #endif /* __BRIDGE_H__ */
diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 31e7cb5e..76e69086 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -682,62 +682,9 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			   rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));

 	if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
-		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
-		SPRINT_BUF(other_time);
-
-		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER_STATE]);
-		memset(other_time, 0, sizeof(other_time));
-
-		open_json_object("mcast_querier_state_ipv4");
-		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
-			print_string(PRINT_FP,
-				NULL,
-				"%s ",
-				"mcast_querier_ipv4_addr");
-			print_color_string(PRINT_ANY,
-				COLOR_INET,
-				"mcast_querier_ipv4_addr",
-				"%s ",
-				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
-		}
-		if (bqtb[BRIDGE_QUERIER_IP_PORT])
-			print_uint(PRINT_ANY,
-				"mcast_querier_ipv4_port",
-				"mcast_querier_ipv4_port %u ",
-				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
-		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
-			print_string(PRINT_ANY,
-				"mcast_querier_ipv4_other_timer",
-				"mcast_querier_ipv4_other_timer %s ",
-				sprint_time64(
-					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
-									other_time));
-		close_json_object();
-		open_json_object("mcast_querier_state_ipv6");
-		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
-			print_string(PRINT_FP,
-				NULL,
-				"%s ",
-				"mcast_querier_ipv6_addr");
-			print_color_string(PRINT_ANY,
-				COLOR_INET6,
-				"mcast_querier_ipv6_addr",
-				"%s ",
-				format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
-		}
-		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
-			print_uint(PRINT_ANY,
-				"mcast_querier_ipv6_port",
-				"mcast_querier_ipv6_port %u ",
-				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
-		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
-			print_string(PRINT_ANY,
-				"mcast_querier_ipv6_other_timer",
-				"mcast_querier_ipv6_other_timer %s ",
-				sprint_time64(
-					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
-									other_time));
-		close_json_object();
+		struct rtattr *vtb = tb[IFLA_BR_MCAST_QUERIER_STATE];
+
+		bridge_print_mcast_querier_state(vtb);
 	}

 	if (tb[IFLA_BR_MCAST_HASH_ELASTICITY])
diff --git a/lib/bridge.c b/lib/bridge.c
index a888a20e..480693c9 100644
--- a/lib/bridge.c
+++ b/lib/bridge.c
@@ -45,3 +45,64 @@ void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats)

 	close_json_object();
 }
+
+void bridge_print_mcast_querier_state(const struct rtattr *vtb)
+{
+	struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
+
+	SPRINT_BUF(other_time);
+
+	parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, vtb);
+	memset(other_time, 0, sizeof(other_time));
+
+	open_json_object("mcast_querier_state_ipv4");
+	if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
+		print_string(PRINT_FP,
+			NULL,
+			"%s ",
+			"mcast_querier_ipv4_addr");
+		print_color_string(PRINT_ANY,
+			COLOR_INET,
+			"mcast_querier_ipv4_addr",
+			"%s ",
+			format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
+	}
+	if (bqtb[BRIDGE_QUERIER_IP_PORT])
+		print_uint(PRINT_ANY,
+			"mcast_querier_ipv4_port",
+			"mcast_querier_ipv4_port %u ",
+			rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
+	if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
+		print_string(PRINT_ANY,
+			"mcast_querier_ipv4_other_timer",
+			"mcast_querier_ipv4_other_timer %s ",
+			sprint_time64(
+				rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
+								other_time));
+	close_json_object();
+	open_json_object("mcast_querier_state_ipv6");
+	if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
+		print_string(PRINT_FP,
+			NULL,
+			"%s ",
+			"mcast_querier_ipv6_addr");
+		print_color_string(PRINT_ANY,
+			COLOR_INET6,
+			"mcast_querier_ipv6_addr",
+			"%s ",
+			format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
+	}
+	if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
+		print_uint(PRINT_ANY,
+			"mcast_querier_ipv6_port",
+			"mcast_querier_ipv6_port %u ",
+			rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
+	if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
+		print_string(PRINT_ANY,
+			"mcast_querier_ipv6_other_timer",
+			"mcast_querier_ipv6_other_timer %s ",
+			sprint_time64(
+				rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
+								other_time));
+	close_json_object();
+}
--
2.39.5

