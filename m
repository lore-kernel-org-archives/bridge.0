Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE82882A8
	for <bridge@lists.linux-foundation.org>; Fri, 20 Jun 2025 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421857; cv=none; b=LPC21we/98UqTskuvgeD0t7DKE9SO8tp8581PWNiS0NW8pRCgnLWb+2n8My0Skj/UwyyoXS8t2OuLlVumt319cG2Y+R3LXVqDMq1XKQsiAZW0+oFsVUymyk3mTv1J22w9CoPIFnMX3HT/Ujgb12OiGaoCLHwu86dL70hWi+Ieic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421857; c=relaxed/simple;
	bh=lqe5RvMP7ahQXgCuxUwNLpKDagJO2i6s9IvNhZhl7dU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bPbbBZOkTmqNNllrS2Bo1IDq68/sQyWFGwO4BS8x+kt/hrodq/gFVYsTbutWLVW9pULeVbmi6xndQje2dRA61EcyhOoRUnwXmDLtnNRrRMm3OB6jR8M9pmz/0OGkVbTaT5yC2bmGnupzsdX+eAzQdHE4aAbs5qnK4rM/5pV44kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A27540DD1
	for <bridge@lists.linux-foundation.org>; Fri, 20 Jun 2025 12:17:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.2
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xjw8Q8WO9JJ6 for <bridge@lists.linux-foundation.org>;
 Fri, 20 Jun 2025 12:17:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=fpf@pengutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C0AFE40D7D
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0AFE40D7D
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C0AFE40D7D
	for <bridge@lists.linux-foundation.org>; Fri, 20 Jun 2025 12:17:32 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1uSagR-000852-AF; Fri, 20 Jun 2025 14:17:27 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uSagP-004SXj-29;
	Fri, 20 Jun 2025 14:17:25 +0200
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uSagP-00BrYE-1w;
	Fri, 20 Jun 2025 14:17:25 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	idosch@nvidia.com,
	bridge@lists.linux-foundation.org,
	entwicklung@pengutronix.de,
	razor@blackwall.org,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH v3] bridge: dump mcast querier state per vlan
Date: Fri, 20 Jun 2025 14:16:21 +0200
Message-Id: <20250620121620.2827020-1-f.pfitzner@pengutronix.de>
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

Dump the multicast querier state per vlan.
This commit is almost identical to [1].

The querier state can be seen with:

bridge -d vlan global

The options for vlan filtering and vlan mcast snooping have to be enabled
in order to see the output:

ip link set [dev] type bridge mcast_vlan_snooping 1 vlan_filtering 1

The querier state shows the following information for IPv4 and IPv6
respectively:

1) The ip address of the current querier in the network. This could be
   ourselves or an external querier.
2) The port on which the querier was seen
3) Querier timeout in seconds

[1] https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=16aa4494d7fc6543e5e92beb2ce01648b79f8fa2

Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
---

v1->v2
	- refactor code
	- link to v1: https://lore.kernel.org/netdev/20250604105322.1185872-1-f.pfitzner@pengutronix.de/

v2->v3
	- move code into a shared function
	- use shared function in bridge and ip utility
	- link to v2: https://lore.kernel.org/netdev/20250611121151.1660231-1-f.pfitzner@pengutronix.de/
---
 bridge/vlan.c      |  3 +++
 include/bridge.h   |  3 +++
 ip/iplink_bridge.c | 57 +---------------------------------------------
 lib/bridge.c       | 56 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 56 deletions(-)

diff --git a/bridge/vlan.c b/bridge/vlan.c
index 14b8475d..0233eaf6 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -852,6 +852,9 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
 		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
 			   rta_getattr_u8(vattr));
 	}
+	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
+		dump_mcast_querier_state(vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]);
+	}
 	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
 		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
 		print_uint(PRINT_ANY, "mcast_igmp_version",
diff --git a/include/bridge.h b/include/bridge.h
index 8bcd1e38..9e9447c6 100644
--- a/include/bridge.h
+++ b/include/bridge.h
@@ -3,9 +3,12 @@
 #define __BRIDGE_H__ 1

 #include <linux/if_bridge.h>
+#include <linux/rtnetlink.h>

 void bridge_print_vlan_flags(__u16 flags);
 void bridge_print_vlan_stats_only(const struct bridge_vlan_xstats *vstats);
 void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats);

+void dump_mcast_querier_state(const struct rtattr* vtb);
+
 #endif /* __BRIDGE_H__ */
diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 31e7cb5e..68a277ef 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -682,62 +682,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
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
+		dump_mcast_querier_state(tb[IFLA_BR_MCAST_QUERIER_STATE]);
 	}

 	if (tb[IFLA_BR_MCAST_HASH_ELASTICITY])
diff --git a/lib/bridge.c b/lib/bridge.c
index a888a20e..13b0d633 100644
--- a/lib/bridge.c
+++ b/lib/bridge.c
@@ -45,3 +45,59 @@ void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats)

 	close_json_object();
 }
+
+void dump_mcast_querier_state(const struct rtattr *vtb)
+{
+	struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
+	const char *querier_ip;
+	SPRINT_BUF(other_time);
+	__u64 tval;
+
+	parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, vtb);
+	memset(other_time, 0, sizeof(other_time));
+
+	open_json_object("mcast_querier_state_ipv4");
+	if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
+		querier_ip = format_host_rta(AF_INET,
+						bqtb[BRIDGE_QUERIER_IP_ADDRESS]);
+		print_string(PRINT_FP, NULL, "%s ",
+				"mcast_querier_ipv4_addr");
+		print_color_string(PRINT_ANY, COLOR_INET,
+					"mcast_querier_ipv4_addr", "%s ",
+					querier_ip);
+	}
+	if (bqtb[BRIDGE_QUERIER_IP_PORT])
+		print_uint(PRINT_ANY, "mcast_querier_ipv4_port",
+				"mcast_querier_ipv4_port %u ",
+				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
+	if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]) {
+		tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]);
+		print_string(PRINT_ANY,
+				"mcast_querier_ipv4_other_timer",
+				"mcast_querier_ipv4_other_timer %s ",
+				sprint_time64(tval, other_time));
+	}
+	close_json_object();
+	open_json_object("mcast_querier_state_ipv6");
+	if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
+		querier_ip = format_host_rta(AF_INET6,
+						bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]);
+		print_string(PRINT_FP, NULL, "%s ",
+				"mcast_querier_ipv6_addr");
+		print_color_string(PRINT_ANY, COLOR_INET6,
+					"mcast_querier_ipv6_addr", "%s ",
+					querier_ip);
+	}
+	if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
+		print_uint(PRINT_ANY, "mcast_querier_ipv6_port",
+				"mcast_querier_ipv6_port %u ",
+				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
+	if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]) {
+		tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]);
+		print_string(PRINT_ANY,
+				"mcast_querier_ipv6_other_timer",
+				"mcast_querier_ipv6_other_timer %s ",
+				sprint_time64(tval, other_time));
+	}
+	close_json_object();
+}
--
2.39.5

