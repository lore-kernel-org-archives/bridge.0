Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54DF2A1D8
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668434; cv=none; b=W+04bmN/C84rZ3gUaY0kso2MeLLZCb34wopshZcwFYubBvU7wf5egriSSv9rN6T4OObwFmMZjG1Ul9ab7oRPG6aWy/RPOPK9Bnj9m769o7+aYlHTia1HxL756jB4r8ZX2ylTOmS8/OmXJk35apwM5h91SNR0FPc/hD9w7N+ojIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668434; c=relaxed/simple;
	bh=IrVbLqhqH3twTY5qucWo/uTjBcTFCluy+Rmf6ZijdGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RV0RuVEttfuy7yYDqZCm+1SegAuw5zJ3QvgrOP9Ut9rUVAOdLP4jnPgm+OqWxeUYasYnwF+lJqdmM/8BB967Gp1U0Y3nO0h/rhm2nggUSaL09ozXXXZpPp5+QxGJEBnSp1qt7+COkEYv/ia8G+SZq+DGVehK8PBi/YuaDdsRM3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A3D8407A0
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 08:47:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.2
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 93H8yr6wLKMf for <bridge@lists.linux-foundation.org>;
 Mon, 23 Jun 2025 08:47:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=fpf@pengutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 859F64079B
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 859F64079B
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 859F64079B
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 08:47:10 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTcpV-0001Nz-Tu; Mon, 23 Jun 2025 10:47:05 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTcpU-004ux3-1A;
	Mon, 23 Jun 2025 10:47:04 +0200
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTcpU-004dsa-0y;
	Mon, 23 Jun 2025 10:47:04 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	idosch@nvidia.com,
	bridge@lists.linux-foundation.org,
	entwicklung@pengutronix.de,
	razor@blackwall.org,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH iproute2-next v4 0/3] bridge: dump mcast querier state per vlan
Date: Mon, 23 Jun 2025 10:45:16 +0200
Message-Id: <20250623084518.1101527-1-f.pfitzner@pengutronix.de>
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

Fabian Pfitzner (3):
  bridge: move mcast querier dumping code into a shared function
  bridge: dump mcast querier per vlan
  bridge: refactor bridge mcast querier function

 bridge/vlan.c      |  4 ++++
 include/bridge.h   |  3 +++
 ip/iplink_bridge.c | 58 ++--------------------------------------------
 lib/bridge.c       | 56 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 56 deletions(-)

--
2.39.5

