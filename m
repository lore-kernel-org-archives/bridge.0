Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63071EB5DB
	for <bridge@lists.linux.dev>; Mon, 14 Apr 2025 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660832; cv=none; b=ITt6+jhBb4wYv2wvomh19179ZWKjDixsnqdN3J0ly3e1J3K42pOiS8hJueQm5bNsk/yTwiosOxh8JeVVZSSkSRpFp1Q0x9FPngvDD4uVy7AoTQl99L9z6Ei/4/f1NIZGSS9CZj79wRZ4WGVMU2A9ISbGs5TmX9pZi81fIdybu1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660832; c=relaxed/simple;
	bh=wN66fbhXuks93JafYdJZ3w2vTDMMVeP/MTvUpMP+HNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGdbkc6yeTYPPK4Zyly6BBtA02STcEt/yQp6aT8t3zsY0zunRntiARFFSbfLoK6PlZUaImH3C+MrGLuBGQ1U4edJNh5rFK7XHSo42SMRAnzUc9lkkmrv1iNW94c7ziYvDRj/uDyQdQAiCXnE+z2q1u3hO+mYcoV0SwF6FGdZfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhvGIczW; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhvGIczW"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso10892632a12.1
        for <bridge@lists.linux.dev>; Mon, 14 Apr 2025 13:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744660829; x=1745265629; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4YA62eK01MS4YMpjP4qPRP/SWRiVysC+pcVZ2AAuJuw=;
        b=BhvGIczWjLpNnQeg9sWqMWkaCDZAGYwD2Eel8fI/E2dkHwzVJ98I9nW5ycf18cVkU0
         xXcG9aB72nMJVkl0gwXXMZ9ugJMM9Z6imAPrRAnuZx34LcadE45R4wWem+yW1IHiHQaF
         tEPXg2vKlrIKdAoP4YKGA3WcFooCydTlcyle1vnGBaJpYJkoCwjAszrxdBRwz42AV6Rv
         X4EGIr0EB5Jz2fnW+CZc7h313rgY6orJ81NalpRV9/oy0qCwbDl2ojLhMDu+iioEo9cc
         EUIHbEevjykG0b80gKBZmgRYc8Bxw4P4cki52+bEcuBoMWYhoRL3JSrTwe/ISsXDyyqe
         fqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744660829; x=1745265629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YA62eK01MS4YMpjP4qPRP/SWRiVysC+pcVZ2AAuJuw=;
        b=bMejG/gGNlH2fNDr7MUpDB59EVINowMZT9vErTzlzBKKsDjMRXDukxx/nLuz4/DBuc
         /Xj86PdGmTF7D1h559+BNgTEcL86pRdpL7CdY71JpxZXGFmb2NQPRcGGQaLQo5q4rOfn
         sWrlt9Nwj5m4F7BqYALyf9Tz7/aNVru3WAJzqY98LVGIswc4Ux1AkzOsEIY5z4LHDg47
         TrJ5H2eesVOFObb6kCuM6pPnOr03yfKllX8/9fMWrJx808jWs6SLEfwDiRa2a2vc7LCv
         c9G/OqoLC3rc/FRda6a9Lv0cUmmFkW5LVlcMuumJd/ws6TWIYTyQ0UuGAmUu7QlJBm0L
         VkeA==
X-Gm-Message-State: AOJu0Yz9loqJYu7xIPx07zd4Y+WSnDcKxvASdEV+rIokWpPCaMRUFzHK
	k8P8MJRhbC471cRh0FEhILlxnyE6HMjiY9mAa9KrRubN6dmOM4MD
X-Gm-Gg: ASbGncs21lY5vo5YZXZPwgSdLQy/45CENHnQrSyh5PxFAetEqEC/UB0AkP/20AnRlxp
	6ZZR+dBM3TH+MHun6QOvf2dststQ5iEpv9plSHQsBXOUvlUjQGOHucHNxXXh3EXK9h5/WaWzHnn
	1YH7J0vUqHd5jHjcCqYcC23JBCTmev1zCKRmMlUVk1l08pIkZqPAhah+l/wu5N0+IX/RQ4TiOlV
	6NswyYyC6+qHWk5ni9BxkzDaF0vqX9NSQmRfxeO8ihA9xk8zpYIIFLX0QX+bNRzUf/rTS5wcSpD
	wXNq+NMf+6/wYH6iDDQmsMIgpOPzgvtSAVmNyUZa8PCtlmkBExXbQqO57aEgIPAamlLM6/I+e9g
	VGFbIz+sT+sZ+F78Cus9a
X-Google-Smtp-Source: AGHT+IEGlZbkJjexJwqszfNiPam4av9rMkvTxh9IM6rb8tuetGKBs60SC5tLj13pfhDdo50QNYJQrA==
X-Received: by 2002:a17:907:3d0a:b0:ac1:dde7:b57f with SMTP id a640c23a62f3a-acb1688aaf6mr60931866b.23.1744660828916;
        Mon, 14 Apr 2025 13:00:28 -0700 (PDT)
Received: from localhost (dslb-002-205-021-146.002.205.pools.vodafone-ip.de. [2.205.21.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccd1cfsm965494566b.138.2025.04.14.13.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:00:28 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: bridge: switchdev: do not notify new brentries as changed
Date: Mon, 14 Apr 2025 22:00:20 +0200
Message-ID: <20250414200020.192715-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adding a bridge vlan that is pvid or untagged after the vlan has
already been added to any other switchdev backed port, the vlan change
will be propagated as changed, since the flags change.

This causes the vlan to not be added to the hardware for DSA switches,
since the DSA handler ignores any vlans for the CPU or DSA ports that
are changed.

E.g. the following order of operations would work:

$ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 0
$ ip link set lan1 master swbridge
$ bridge vlan add dev swbridge vid 1 pvid untagged self
$ bridge vlan add dev lan1 vid 1 pvid untagged

but this order would break:

$ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 0
$ ip link set lan1 master swbridge
$ bridge vlan add dev lan1 vid 1 pvid untagged
$ bridge vlan add dev swbridge vid 1 pvid untagged self

Additionally, the vlan on the bridge itself would become undeletable:

$ bridge vlan
port              vlan-id
lan1              1 PVID Egress Untagged
swbridge          1 PVID Egress Untagged
$ bridge vlan del dev swbridge vid 1 self
$ bridge vlan
port              vlan-id
lan1              1 PVID Egress Untagged
swbridge          1 Egress Untagged

since the vlan was never added to DSA's vlan list, so deleting it will
cause an error, causing the bridge code to not remove it.

Fix this by checking if flags changed only for vlans that are already
brentry and pass changed as false for those that become brentries, as
these are a new vlan (member) from the switchdev point of view.

Since *changed is set to true for becomes_brentry = true regardless of
would_change's value, this will not change any rtnetlink notification
delivery, just the value passed on to switchdev in vlan->changed.

Fixes: 8d23a54f5bee ("net: bridge: switchdev: differentiate new VLANs from changed ones")
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
Changelog v1 -> v2:
- dropped the second patch always notifying dsa drivers on brentry changes
- dropped the cover letter, as its overkill for one patch and it mostly
  reiterated what is already written in here
- fixed the example in the commit message to use vlan_default_pvid 0
- fix thinko brake -> break
- extended the changelog to include the assurance that rtnetlink
  notifications should not be affected

 net/bridge/br_vlan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index d9a69ec9affe..939a3aa78d5c 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -715,8 +715,8 @@ static int br_vlan_add_existing(struct net_bridge *br,
 				u16 flags, bool *changed,
 				struct netlink_ext_ack *extack)
 {
-	bool would_change = __vlan_flags_would_change(vlan, flags);
 	bool becomes_brentry = false;
+	bool would_change = false;
 	int err;
 
 	if (!br_vlan_is_brentry(vlan)) {
@@ -725,6 +725,8 @@ static int br_vlan_add_existing(struct net_bridge *br,
 			return -EINVAL;
 
 		becomes_brentry = true;
+	} else {
+		would_change = __vlan_flags_would_change(vlan, flags);
 	}
 
 	/* Master VLANs that aren't brentries weren't notified before,
-- 
2.43.0

