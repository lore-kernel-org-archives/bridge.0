Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DFF15820C
	for <bridge@lists.linux-foundation.org>; Fri,  1 Nov 2024 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462010; cv=none; b=cm3N1zlhx3xXLnl0FDZwPy+uqG+poxlXDSgSZhiOWsloPROKHDnxrflhgDhag4hN4ojDbmGDVKT+LzAYJj4tO4CaofB233ZjE0mdVK+EFD5cx9xbemtXiz6K9331k1Krs5D9sfellFQUZhhY+zMTpBu34kxkW1w2V+N5KVFfIKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462010; c=relaxed/simple;
	bh=5WpOuEix74X7yKM6WtxCZXsnuVlB/PdCVvCIoID6/jY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qdp7ZnLfIOgDgYv1FYIokgBwitoKVYPwx8IJsFWxxEdbA3/Hz2J6SLeFeb2IBZmiWh0WYRpUBXlWsFt0cwqtmLDb0AWV3r3w6dhW8at/e5IwMOU9SwhyWNiU6gtzKfPGEs4x/lQLf2AA2i/nilcJ+SLIlcsvNGef7ITFavEeaVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0C41B40286
	for <bridge@lists.linux-foundation.org>; Fri,  1 Nov 2024 11:53:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.2
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KtAxHUEXYpso for <bridge@lists.linux-foundation.org>;
 Fri,  1 Nov 2024 11:53:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=fpf@pengutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4F5C240173
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4F5C240173
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4F5C240173
	for <bridge@lists.linux-foundation.org>; Fri,  1 Nov 2024 11:53:23 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1t6qDO-0006Ep-ED; Fri, 01 Nov 2024 12:53:18 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1t6qDM-001VL6-1p;
	Fri, 01 Nov 2024 12:53:16 +0100
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1t6qDM-00AveW-1e;
	Fri, 01 Nov 2024 12:53:16 +0100
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	entwicklung@pengutronix.de,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux-foundation.org,
	stephen@networkplumber.org,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH v3 iproute] bridge: dump mcast querier state
Date: Fri,  1 Nov 2024 12:50:40 +0100
Message-Id: <20241101115039.2604631-1-f.pfitzner@pengutronix.de>
X-Mailer: git-send-email 2.39.5
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

Kernel support for dumping the multicast querier state was added in this
commit [1]. As some people might be interested to get this information
from userspace, this commit implements the necessary changes to show it
via

ip -d link show [dev]

The querier state shows the following information for IPv4 and IPv6
respectively:

1) The ip address of the current querier in the network. This could be
   ourselves or an external querier.
2) The port on which the querier was seen
3) Querier timeout in seconds

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7fa1d9b1fb179375e889ff076a1566ecc997bfc

Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
---

v1->v2
	- refactor code
	- link to v1: https://lore.kernel.org/netdev/20241025142836.19946-1-f.pfitzner@pengutronix.de/
v2->v3
	- use print_color_string for addresses
	- link to v2: https://lore.kernel.org/netdev/20241030222136.3395120-1-f.pfitzner@pengutronix.de/

 ip/iplink_bridge.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index f01ffe15..9c01154b 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -661,6 +661,66 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			   "mcast_querier %u ",
 			   rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));
 
+	if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
+		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
+
+		SPRINT_BUF(other_time);
+
+		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER_STATE]);
+		memset(other_time, 0, sizeof(other_time));
+
+		open_json_object("mcast_querier_state_ipv4");
+		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
+			print_string(PRINT_FP,
+				NULL,
+				"%s ",
+				"mcast_querier_ipv4_addr");
+			print_color_string(PRINT_ANY,
+				COLOR_INET,
+				"mcast_querier_ipv4_addr",
+				"%s ",
+				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
+		}
+		if (bqtb[BRIDGE_QUERIER_IP_PORT])
+			print_uint(PRINT_ANY,
+				"mcast_querier_ipv4_port",
+				"mcast_querier_ipv4_port %u ",
+				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
+		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
+			print_string(PRINT_ANY,
+				"mcast_querier_ipv4_other_timer",
+				"mcast_querier_ipv4_other_timer %s ",
+				sprint_time64(
+					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
+									other_time));
+		close_json_object();
+		open_json_object("mcast_querier_state_ipv6");
+		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
+			print_string(PRINT_FP,
+				NULL,
+				"%s ",
+				"mcast_querier_ipv6_addr");
+			print_color_string(PRINT_ANY,
+				COLOR_INET6,
+				"mcast_querier_ipv6_addr",
+				"%s ",
+				format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
+		}
+		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
+			print_uint(PRINT_ANY,
+				"mcast_querier_ipv6_port",
+				"mcast_querier_ipv6_port %u ",
+				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
+		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
+			print_string(PRINT_ANY,
+				"mcast_querier_ipv6_other_timer",
+				"mcast_querier_ipv6_other_timer %s ",
+				sprint_time64(
+					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
+									other_time));
+		close_json_object();
+	}
+
 	if (tb[IFLA_BR_MCAST_HASH_ELASTICITY])
 		print_uint(PRINT_ANY,
 			   "mcast_hash_elasticity",
-- 
2.39.5

