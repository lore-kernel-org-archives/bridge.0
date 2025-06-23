Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC01219A91
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668496; cv=none; b=okQIcbTwJdHJ/b1MZAWS63qOTUAbVaRJfZybxr4FO4ur1P+pOcuH6JV29+aLxiN9ABqr6LNz5vu53OEw63bHcgpOEHXCBF08ohRZmKzYcqs2Bxf6EC/MDZipGaaJxr3pN7AuDab18dzV4BQnvBRvbJgs5OUEChVQKRAvOCR8n/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668496; c=relaxed/simple;
	bh=qdCNAIukvetacEnzH582AOFjHGWS81JfZDBaR94wtDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A17ICq6skETNFZXY7Zk5ShYWuOIcS6iuii3hYvLYQmUsJ8he7+POGitZTBCl9IMEgYHSiW6Pdx9S2OpeXrjE2INzUCH8BmsBS8mPGxCah7IR+yEMQaIo4S8RGKAs8AFikVxhqrRpPU4e0ZYX6jQ9IwHnp87kjKMS0J7u6Y62Rpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8089D407A2
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 08:48:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.2
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3DBrbDyDezVi for <bridge@lists.linux-foundation.org>;
 Mon, 23 Jun 2025 08:48:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=fpf@pengutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org ADBD9407A0
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ADBD9407A0
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ADBD9407A0
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 08:48:14 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTcqX-0002an-Ef; Mon, 23 Jun 2025 10:48:09 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTcqX-004uxT-0U;
	Mon, 23 Jun 2025 10:48:09 +0200
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTcqX-004eCa-0H;
	Mon, 23 Jun 2025 10:48:09 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	idosch@nvidia.com,
	bridge@lists.linux-foundation.org,
	entwicklung@pengutronix.de,
	razor@blackwall.org,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH iproute2-next v4 2/3] bridge: dump mcast querier per vlan
Date: Mon, 23 Jun 2025 10:45:20 +0200
Message-Id: <20250623084518.1101527-3-f.pfitzner@pengutronix.de>
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
 bridge/vlan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bridge/vlan.c b/bridge/vlan.c
index 14b8475d..d2770eff 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -852,6 +852,10 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
 		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
 			   rta_getattr_u8(vattr));
 	}
+	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
+		struct rtattr *attr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE];
+		bridge_print_mcast_querier_state(attr);
+	}
 	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
 		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
 		print_uint(PRINT_ANY, "mcast_igmp_version",
--
2.39.5

