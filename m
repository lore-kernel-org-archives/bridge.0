Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655823A9BB
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671262; cv=none; b=Dmiz5dIBEJL5iyTnYzyJBza/4tYqoLQfJGiy3zYuQY9UyZKIXum7lVG+SgRxQUqMrtrIm+SXvlr2/1GUN8y1wdnmuVwiz1kXTn7aFhmb/FAeLTrxQergjCih1TiODBV01BwqFyYVSHpzuCW6PVYKYrpW1x7AKQnGBQCjjoWnQwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671262; c=relaxed/simple;
	bh=u0IFeyGygwMjAfJsefRhNXRGve/t2QArFaHVh+uHLAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=axod2Jq2wcX4InmrdIQtpGfta0RQnhvNUplpP34KNc4/foMLzOyTOHPmjRKTlI8SrVkveTvlj+ahUlQMkAE+6JbpEEu1Rz/SMMfoFPZ1ylDbO4iFl30P+I2QHZNiJcARxKkxdtEa9F3b9k6/dmXnkbV3o8RgQJ6B62Ggr0RCAQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B339D81F64
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 09:34:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.2
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wX0DbpPqXzdL for <bridge@lists.linux-foundation.org>;
 Mon, 23 Jun 2025 09:34:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=fpf@pengutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DA37A81E7E
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA37A81E7E
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DA37A81E7E
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 09:34:19 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTdZ9-0007Qa-Ad; Mon, 23 Jun 2025 11:34:15 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTdZ9-004vM1-0F;
	Mon, 23 Jun 2025 11:34:15 +0200
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTdZ9-0056d6-04;
	Mon, 23 Jun 2025 11:34:15 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	idosch@nvidia.com,
	bridge@lists.linux-foundation.org,
	entwicklung@pengutronix.de,
	razor@blackwall.org,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH iproute2-next v5 0/3] bridge: dump mcast querier state per vlan
Date: Mon, 23 Jun 2025 11:33:14 +0200
Message-Id: <20250623093316.1215970-1-f.pfitzner@pengutronix.de>
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

v1->v2
	- refactor code
	- link to v1: https://lore.kernel.org/netdev/20250604105322.1185872-1-f.pfitzner@pengutronix.de/

v2->v3
	- move code into a shared function
	- use shared function in bridge and ip utility
	- link to v2: https://lore.kernel.org/netdev/20250611121151.1660231-1-f.pfitzner@pengutronix.de/
v3->v4
	- refactor code
	- split patch into three patches
	- link to v3: https://lore.kernel.org/netdev/20250620121620.2827020-1-f.pfitzner@pengutronix.de/
v4->v5
	- run checkpatch
	- link to v4: https://lore.kernel.org/netdev/20250623084518.1101527-1-f.pfitzner@pengutronix.de/

Fabian Pfitzner (3):
  bridge: move mcast querier dumping code into a shared function
  bridge: dump mcast querier per vlan
  bridge: refactor bridge mcast querier function

 bridge/vlan.c      |  5 ++++
 include/bridge.h   |  3 +++
 ip/iplink_bridge.c | 59 +++-------------------------------------------
 lib/bridge.c       | 57 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 56 deletions(-)

--
2.39.5

