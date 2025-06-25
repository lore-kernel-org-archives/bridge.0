Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A220C488
	for <bridge@lists.linux-foundation.org>; Wed, 25 Jun 2025 08:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750840762; cv=none; b=OS1B8eD0vQpHrZVBPWCcEMeiKVrBwXjl1Tmh6+Lm0y8Qt1RzBjUVxpam3a759PUFrpyp0v3VFksz1BizQ/GEJWufJur78/cuyf77TH++SFgl9qfj9eUWu8SX5z0bmAqaeXyxHuIrheRweW/sy5d9/Y57Cp3JOKOrQ1YdFCxW7Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750840762; c=relaxed/simple;
	bh=2LwpDPhSmqsE6ynvcMtU9/l1N8p0wByRkxH7oogvnJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n3lUfvIC9hkBgBiCjiAeYQaJta5uQ26yqq6xpTltMX6z47wyrUtsL09uVV4MJXdsSuwARVOFjFcT/bVgjrZk1e41fQDACUphbSQ8MTGaW6F1cB3maDc2pHO4bUs7zYq51VoB0/qFCzeulQgUixRyVvJFvBHiLP7jweHIhEHRcBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C37D860EC4
	for <bridge@lists.linux-foundation.org>; Wed, 25 Jun 2025 08:39:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.2
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3blB0eiR80NU for <bridge@lists.linux-foundation.org>;
 Wed, 25 Jun 2025 08:39:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=f.pfitzner@pengutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AC37F60DFD
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC37F60DFD
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AC37F60DFD
	for <bridge@lists.linux-foundation.org>; Wed, 25 Jun 2025 08:39:15 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uULez-0006WK-Iv; Wed, 25 Jun 2025 10:39:13 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uULey-005Fdo-1g;
	Wed, 25 Jun 2025 10:39:12 +0200
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uULey-00FT0E-1R;
	Wed, 25 Jun 2025 10:39:12 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Date: Wed, 25 Jun 2025 10:39:15 +0200
Subject: [PATCH iproute2-next v6 3/3] bridge: refactor bridge mcast querier
 function
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-mcast-querier-vlan-lib-v6-3-03659be44d48@pengutronix.de>
References: <20250625-mcast-querier-vlan-lib-v6-0-03659be44d48@pengutronix.de>
In-Reply-To: <20250625-mcast-querier-vlan-lib-v6-0-03659be44d48@pengutronix.de>
To: netdev@vger.kernel.org
Cc: entwicklung@pengutronix.de, razor@blackwall.org, 
 bridge@lists.linux-foundation.org, dsahern@gmail.com, idosch@nvidia.com, 
 Fabian Pfitzner <f.pfitzner@pengutronix.de>
X-Mailer: b4 0.12.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: f.pfitzner@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bridge@lists.linux-foundation.org

Make code more readable and consistent with other functions.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
---
 lib/bridge.c | 73 ++++++++++++++++++++++++++++--------------------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/lib/bridge.c b/lib/bridge.c
index 480693c9..5386aa01 100644
--- a/lib/bridge.c
+++ b/lib/bridge.c
@@ -49,60 +49,55 @@ void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats)
 void bridge_print_mcast_querier_state(const struct rtattr *vtb)
 {
 	struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
-
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

