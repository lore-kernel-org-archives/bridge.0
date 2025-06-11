Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CAF2E610F
	for <bridge@lists.linux-foundation.org>; Wed, 11 Jun 2025 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644006; cv=none; b=RKZOCJP4ChMamgtHB5vITjyqUOVbTq+N1bsUdovVT1TLWS7RUtCa+h/dstjwTF3v/uwpywzhrPM3rQiyo6f7Yltu3V1nhj9JsGS3iMSUA38BDAwGQ521rQFB61dWruY3kSKMqhhZV+WO6UUfgyoX3IvJISlBhWi/5NdMrDJ9Ook=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644006; c=relaxed/simple;
	bh=sPM052dHaSMGLKDwax5eRx1wwGJo4Wnmy6GY6SYUQiU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VoAxadnx4VYOHkjQvFivfvX32t3Q4AvVQUlF4w42ClpkPqkVFGlZAktXNe8Zb/y0JpJ4A0Lw3+5gGBQlhvn65JlyKMM+I3HmTF1R+jIeFyDlyExkUgyTRUFraCG1LPMXazzJ2yJXOBuh2/YKDrP8VksyEVdSfaIeD6l+iS6AExc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A16CC60A46
	for <bridge@lists.linux-foundation.org>; Wed, 11 Jun 2025 12:13:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.2
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nrPDrYj5V6I0 for <bridge@lists.linux-foundation.org>;
 Wed, 11 Jun 2025 12:13:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=fpf@pengutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3E4C060908
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E4C060908
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3E4C060908
	for <bridge@lists.linux-foundation.org>; Wed, 11 Jun 2025 12:13:22 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1uPKKU-0003bJ-9w; Wed, 11 Jun 2025 14:13:18 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uPKKU-002wUH-05;
	Wed, 11 Jun 2025 14:13:18 +0200
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uPKKT-006yvY-35;
	Wed, 11 Jun 2025 14:13:17 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	idosch@nvidia.com,
	bridge@lists.linux-foundation.org,
	entwicklung@pengutronix.de,
	razor@blackwall.org,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH v2] bridge: dump mcast querier state per vlan
Date: Wed, 11 Jun 2025 14:11:52 +0200
Message-Id: <20250611121151.1660231-1-f.pfitzner@pengutronix.de>
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

 bridge/vlan.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/bridge/vlan.c b/bridge/vlan.c
index ea4aff93..2afdc7c7 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -892,6 +892,61 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
 		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
 			   rta_getattr_u8(vattr));
 	}
+	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
+		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
+		const char *querier_ip;
+		SPRINT_BUF(other_time);
+		__u64 tval;
+
+		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX,
+				    vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]);
+		memset(other_time, 0, sizeof(other_time));
+
+		open_json_object("mcast_querier_state_ipv4");
+		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
+			querier_ip = format_host_rta(AF_INET,
+						     bqtb[BRIDGE_QUERIER_IP_ADDRESS]);
+			print_string(PRINT_FP, NULL, "%s ",
+				     "mcast_querier_ipv4_addr");
+			print_color_string(PRINT_ANY, COLOR_INET,
+					   "mcast_querier_ipv4_addr", "%s ",
+					   querier_ip);
+		}
+		if (bqtb[BRIDGE_QUERIER_IP_PORT])
+			print_uint(PRINT_ANY, "mcast_querier_ipv4_port",
+				   "mcast_querier_ipv4_port %u ",
+				   rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
+		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]) {
+			tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]);
+			print_string(PRINT_ANY,
+				     "mcast_querier_ipv4_other_timer",
+				     "mcast_querier_ipv4_other_timer %s ",
+				     sprint_time64(tval, other_time));
+		}
+		close_json_object();
+		open_json_object("mcast_querier_state_ipv6");
+		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
+			querier_ip = format_host_rta(AF_INET6,
+						     bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]);
+			print_string(PRINT_FP, NULL, "%s ",
+				     "mcast_querier_ipv6_addr");
+			print_color_string(PRINT_ANY, COLOR_INET6,
+					   "mcast_querier_ipv6_addr", "%s ",
+					   querier_ip);
+		}
+		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
+			print_uint(PRINT_ANY, "mcast_querier_ipv6_port",
+				   "mcast_querier_ipv6_port %u ",
+				   rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
+		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]) {
+			tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]);
+			print_string(PRINT_ANY,
+				     "mcast_querier_ipv6_other_timer",
+				     "mcast_querier_ipv6_other_timer %s ",
+				     sprint_time64(tval, other_time));
+		}
+		close_json_object();
+	}
 	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
 		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
 		print_uint(PRINT_ANY, "mcast_igmp_version",
--
2.39.5

