Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16851E0E03
	for <bridge@lists.linux-foundation.org>; Wed, 30 Oct 2024 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730279192; cv=none; b=i7vss0Bx7snIgAlRYf54iUUlAm5bpRMSZxsBMuRuXUO3/JeFDmpRM2dhouvvQdHdB3bTr7VFTQgMQVuZYoCJv9b3y/9M609gan8Thm+RbmNks5H3R9VElMLjc7oeFBtQ228LEoKWcZwXHSPGNV06diEY+1Obe8PHTsyOHt0WEMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730279192; c=relaxed/simple;
	bh=7X+BkPWVY3jrDds8UbTE1K7ELbI+fgW1NyOMDM+42sI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FSOjv5PE8ILmUPqz/e1N/d7d3DfBQ2M4nCpCfaRZ1YBNXeK+TeEtOpk8TKGS1JCUugD8j/i/hJ/u7JcVWaxu3JkK1cHvopq54bpR9jwz29sODJnhRavR7G+YoC8A8DymjuQqk9AH9gVRSUSqljUjGo5K9cwqZljc5Yp0bSCWrqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E7186070D
	for <bridge@lists.linux-foundation.org>; Wed, 30 Oct 2024 09:06:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.2
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C-LdcIOaCuNN for <bridge@lists.linux-foundation.org>;
 Wed, 30 Oct 2024 09:06:29 +0000 (UTC)
X-Greylist: delayed 1096 seconds by postgrey-1.37 at util1.osuosl.org; Wed, 30 Oct 2024 09:06:28 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D9A1360707
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D9A1360707
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=fpf@pengutronix.de; receiver=<UNKNOWN> 
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D9A1360707
	for <bridge@lists.linux-foundation.org>; Wed, 30 Oct 2024 09:06:28 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1t64N8-0001WQ-6Z; Wed, 30 Oct 2024 09:48:10 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1t64N7-001AO7-35;
	Wed, 30 Oct 2024 09:48:09 +0100
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1t64N7-000ZWZ-2u;
	Wed, 30 Oct 2024 09:48:09 +0100
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: netdev@vger.kernel.org
Cc: entwicklung@pengutronix.de,
	bridge@lists.linux-foundation.org,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH v2 iproute] bridge: dump mcast querier state
Date: Wed, 30 Oct 2024 09:46:23 +0100
Message-Id: <20241030084622.4141001-1-f.pfitzner@pengutronix.de>
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

v1->v2: refactor code

 ip/iplink_bridge.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index f01ffe15..f74436d3 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -661,6 +661,53 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			   "mcast_querier %u ",
 			   rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));
 
+	if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
+		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
+		SPRINT_BUF(other_time);
+
+		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER_STATE]);
+		memset(other_time, 0, sizeof(other_time));
+
+		open_json_object("mcast_querier_state_ipv4");
+		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS])
+			print_string(PRINT_ANY,
+				"mcast_querier_ipv4_addr",
+				"mcast_querier_ipv4_addr %s ",
+				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
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
+		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS])
+			print_string(PRINT_ANY,
+				"mcast_querier_ipv6_addr",
+				"mcast_querier_ipv6_addr %s ",
+				format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
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

