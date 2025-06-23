Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CD8233722
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671307; cv=none; b=GUj4Phqxpg+3pOU03P4ujgRDa+y1xBOQOw5mc+QV/kJSGsFiMTS/zfx3T9KtuZxBBW0hvnb6CiDXyuqXRK8u0WKY48OHLCnO8GGa16jt3p1T8Lp64Wc2PzbnWAckZ+o/IGu6dBEoOYWFfqVHNdSn2TpFktvCgHwDqNB8agDuOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671307; c=relaxed/simple;
	bh=VTLFo8NznJtXEUmXnh24qPz8D69unH/Cx67mKU6O2ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cTqabsMwKN6qhuVaRpW5sh9WBsV/HFUsSVme0QxPBxuICKCC48e6TFbPIB3s9lfdOt31sw6Ic1us0t6V65jkBWXTEqxhzOyDMu3l/vK6hH6VNr/qEJ7z+i1D1fcsk/gl5jHdmrfCPpb5xZKH3Igj7o9JmNYerw1JSVev9VMQML0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC83240377
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 09:35:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.2
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CvzljYT7Hmu3 for <bridge@lists.linux-foundation.org>;
 Mon, 23 Jun 2025 09:35:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=fpf@pengutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 10C504035F
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 10C504035F
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 10C504035F
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 09:35:04 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTdZs-0008Nx-0o; Mon, 23 Jun 2025 11:35:00 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTdZr-004vQd-2Y;
	Mon, 23 Jun 2025 11:34:59 +0200
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTdZr-0056tT-2M;
	Mon, 23 Jun 2025 11:34:59 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	idosch@nvidia.com,
	bridge@lists.linux-foundation.org,
	entwicklung@pengutronix.de,
	razor@blackwall.org,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH iproute2-next v5 3/3] bridge: refactor bridge mcast querier function
Date: Mon, 23 Jun 2025 11:33:20 +0200
Message-Id: <20250623093316.1215970-4-f.pfitzner@pengutronix.de>
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

Make code more readable and consistent with other functions.

Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
---
 lib/bridge.c | 72 +++++++++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/lib/bridge.c b/lib/bridge.c
index 480693c9..23a102c4 100644
--- a/lib/bridge.c
+++ b/lib/bridge.c
@@ -49,60 +49,56 @@ void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats)
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

