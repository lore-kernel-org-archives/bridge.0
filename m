Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A9226CF0
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668509; cv=none; b=KkmjDIugX6lYV2ehA3PhJB8CV1FiPUkC53T6SABrRdr3mHs0juP8T8sVMHTaZ45v9+E7QQyMMF5MEGHxF7EqEWvGCIgsFQs9X347P5Nd6LT8t1di3PB6TlH2lNhOmWREDHfr4UwiSbGYPOWmkNUYyJBSgnPI7tET7tnJf5p3a8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668509; c=relaxed/simple;
	bh=aYdJuyCU85OcDHYQ2lRXBVfTia6qUszL+TKkbQTh9ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PpDKbglzlB8t7GkLG3QVJliCOrYoiNGFEeYXTLAR7ZiNQk6/Tuu/R37c0xhfHl+gg+4ipn6c9vs95s721yv/xo4jjcdXIjJtJ242uN7VLeLmpip+f6PE4k7GKWSx8yvBSkcRDKag0Uc+NgIoxdOejkcVb+fehvdxsu9BCLZs08k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1D6E60A3F
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 08:48:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.2
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bhkq34kaayiU for <bridge@lists.linux-foundation.org>;
 Mon, 23 Jun 2025 08:48:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=fpf@pengutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1C44960906
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C44960906
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1C44960906
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 08:48:26 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTcqk-0002sc-BQ; Mon, 23 Jun 2025 10:48:22 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTcqk-004uxi-0H;
	Mon, 23 Jun 2025 10:48:22 +0200
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTcqk-004eHH-06;
	Mon, 23 Jun 2025 10:48:22 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	idosch@nvidia.com,
	bridge@lists.linux-foundation.org,
	entwicklung@pengutronix.de,
	razor@blackwall.org,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH iproute2-next v4 3/3] bridge: refactor bridge mcast querier function
Date: Mon, 23 Jun 2025 10:45:22 +0200
Message-Id: <20250623084518.1101527-4-f.pfitzner@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250623084518.1101527-1-f.pfitzner@pengutronix.de>
References: <20250623084518.1101527-1-f.pfitzner@pengutronix.de>
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

Make code more readable and consistent with other functions.

Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
---
 lib/bridge.c | 72 +++++++++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/lib/bridge.c b/lib/bridge.c
index 35cc409a..5386aa01 100644
--- a/lib/bridge.c
+++ b/lib/bridge.c
@@ -49,59 +49,55 @@ void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats)
 void bridge_print_mcast_querier_state(const struct rtattr *vtb)
 {
 	struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
+	const char *querier_ip;
 	SPRINT_BUF(other_time);
+	__u64 tval;

 	parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, vtb);
 	memset(other_time, 0, sizeof(other_time));

 	open_json_object("mcast_querier_state_ipv4");
 	if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
-		print_string(PRINT_FP,
-			NULL,
-			"%s ",
-			"mcast_querier_ipv4_addr");
-		print_color_string(PRINT_ANY,
-			COLOR_INET,
-			"mcast_querier_ipv4_addr",
-			"%s ",
-			format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
+		querier_ip = format_host_rta(AF_INET,
+					     bqtb[BRIDGE_QUERIER_IP_ADDRESS]);
+		print_string(PRINT_FP, NULL, "%s ",
+			     "mcast_querier_ipv4_addr");
+		print_color_string(PRINT_ANY, COLOR_INET,
+				   "mcast_querier_ipv4_addr", "%s ",
+				   querier_ip);
 	}
 	if (bqtb[BRIDGE_QUERIER_IP_PORT])
-		print_uint(PRINT_ANY,
-			"mcast_querier_ipv4_port",
-			"mcast_querier_ipv4_port %u ",
-			rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
-	if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
+		print_uint(PRINT_ANY, "mcast_querier_ipv4_port",
+			   "mcast_querier_ipv4_port %u ",
+			   rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
+	if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]) {
+		tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]);
 		print_string(PRINT_ANY,
-			"mcast_querier_ipv4_other_timer",
-			"mcast_querier_ipv4_other_timer %s ",
-			sprint_time64(
-				rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
-								other_time));
+			     "mcast_querier_ipv4_other_timer",
+			     "mcast_querier_ipv4_other_timer %s ",
+			     sprint_time64(tval, other_time));
+	}
 	close_json_object();
 	open_json_object("mcast_querier_state_ipv6");
 	if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
-		print_string(PRINT_FP,
-			NULL,
-			"%s ",
-			"mcast_querier_ipv6_addr");
-		print_color_string(PRINT_ANY,
-			COLOR_INET6,
-			"mcast_querier_ipv6_addr",
-			"%s ",
-			format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
+		querier_ip = format_host_rta(AF_INET6,
+					     bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]);
+		print_string(PRINT_FP, NULL, "%s ",
+			     "mcast_querier_ipv6_addr");
+		print_color_string(PRINT_ANY, COLOR_INET6,
+				   "mcast_querier_ipv6_addr", "%s ",
+				   querier_ip);
 	}
 	if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
-		print_uint(PRINT_ANY,
-			"mcast_querier_ipv6_port",
-			"mcast_querier_ipv6_port %u ",
-			rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
-	if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
+		print_uint(PRINT_ANY, "mcast_querier_ipv6_port",
+			   "mcast_querier_ipv6_port %u ",
+			   rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
+	if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]) {
+		tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]);
 		print_string(PRINT_ANY,
-			"mcast_querier_ipv6_other_timer",
-			"mcast_querier_ipv6_other_timer %s ",
-			sprint_time64(
-				rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
-								other_time));
+			     "mcast_querier_ipv6_other_timer",
+			     "mcast_querier_ipv6_other_timer %s ",
+			     sprint_time64(tval, other_time));
+	}
 	close_json_object();
 }
--
2.39.5

