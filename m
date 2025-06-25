Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D2F27E7EC
	for <bridge@lists.linux-foundation.org>; Wed, 25 Jun 2025 08:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750840764; cv=none; b=A4UkZoXIWOxCcIjPP3/NmZ3g8B9AlV0EGJl6r4aQpFNoFtsD5W4OVRfs0IaxW/Lps9DxjTKjmdkAjL0Rf4eWjdSTOxGuFmRdA/CfxyrvJZ/ZBYXXsaIenB4gLzzak7fAXXHuasS0NHnADlNuFTNgFf3aB4it+kguPWTtD6kW/5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750840764; c=relaxed/simple;
	bh=CJ7Jl6g41OU3coDm07QKPHbHDsiHkOoOneOtrD6U42M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mFsduYUCs+3zHAttRfQyTktWnvyam2xDodZ/RJ/iRJEDOhk8QOuPbrE8QmltzlI52o89YfSpVLVhR0NZuBWqImyXCPdvyCcFPtT+DyocquoDrrSfp2pgY1Ug/ZJO+xWBozpTo1XJPV/d8Ik2kYgUkHHSgbcK+FDQToP5J7kpu1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E637B60DFD
	for <bridge@lists.linux-foundation.org>; Wed, 25 Jun 2025 08:39:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.2
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GOFN_lDC2akI for <bridge@lists.linux-foundation.org>;
 Wed, 25 Jun 2025 08:39:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=f.pfitzner@pengutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AC34460D6C
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC34460D6C
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AC34460D6C
	for <bridge@lists.linux-foundation.org>; Wed, 25 Jun 2025 08:39:15 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uULez-0006WJ-Iv; Wed, 25 Jun 2025 10:39:13 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uULey-005Fdl-1b;
	Wed, 25 Jun 2025 10:39:12 +0200
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uULey-00FT0E-1O;
	Wed, 25 Jun 2025 10:39:12 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH iproute2-next v6 0/3] bridge: dump mcast querier state per
 vlan
Date: Wed, 25 Jun 2025 10:39:12 +0200
Message-Id: <20250625-mcast-querier-vlan-lib-v6-0-03659be44d48@pengutronix.de>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALC1W2gC/02NQQ6CQAxFr2K6toQZZAiuvIdxMUCBJlCwMxii4
 e6CK5fv/7y8DwRSpgDX0weUXhx4kh3c+QR176Uj5GZnsKnNU2dzHGsfIj6XQ1N8DV5w4AqdLVx
 hL5UzpoRdrnwgrNRL3R/66FmOeVZqef317sCzTkski0JrhMd+tzqNGHsl/x/N0jLLjEuMNXlZp
 GiwTeaW41tIbzNJt0SdhNekIdi2L33KFa3TAAAA
To: netdev@vger.kernel.org
Cc: entwicklung@pengutronix.de, razor@blackwall.org, 
 bridge@lists.linux-foundation.org, dsahern@gmail.com, idosch@nvidia.com, 
 Fabian Pfitzner <f.pfitzner@pengutronix.de>
X-Mailer: b4 0.12.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: f.pfitzner@pengutronix.de
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
v5->v6
	- delete empty line
	- link to v5: https://lore.kernel.org/netdev/20250623093316.1215970-1-f.pfitzner@pengutronix.de/

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

---
Fabian Pfitzner (3):
      bridge: move mcast querier dumping code into a shared function
      bridge: dump mcast querier per vlan
      bridge: refactor bridge mcast querier function

 bridge/vlan.c      |  5 +++++
 include/bridge.h   |  3 +++
 ip/iplink_bridge.c | 59 +++---------------------------------------------------
 lib/bridge.c       | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 56 deletions(-)
---
base-commit: 6331444995237782f4bdfae7d3cbef7f319d323c
change-id: 20250625-mcast-querier-vlan-lib-6276724b6119

Best regards,
-- 
Fabian Pfitzner <f.pfitzner@pengutronix.de>

