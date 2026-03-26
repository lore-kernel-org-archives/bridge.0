Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AFB37996B
	for <bridge@lists.linux.dev>; Thu, 26 Mar 2026 03:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774495483; cv=none; b=h4Rxe6JuvBcEJJ0xIh0+tgxN21GoRsNN47Nx8BFmGoaHl6jkz8PwnHmxh+TSGFYYw0qjDgE57Vgc6USo3bR1Z3T+s5qOUS+NCdrhXdj2jKeEdv4oZuRKNSrLWSa0TUtIcE2aCiNbh5y4mRbGqJFbDL4kcro2TFNuxaW9o1+gxms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774495483; c=relaxed/simple;
	bh=K/PQfR8P9MVwkiIO+y1urfpkVRliInekQl8DW1MODec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lx6agfaGCUdiDd9PBCc+ZC3L/OjdJpxaAxdZjt70K0/42bdUrVXL/lE5/wtTD1/SJlH0UsPaA0MLOLAYi8jb64sXpW1szAViVdZkH8n99hrtWsyDlT5ZB0lmdrz8GOyKJViDs8Y5O8m7CdGGqM2P05aYNwqh3Ft5N9wJdA+6KRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Qk/3K8ds; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Qk/3K8ds"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c107ef474fso1307276eec.0
        for <bridge@lists.linux.dev>; Wed, 25 Mar 2026 20:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774495482; x=1775100282; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O0EG3jDsn9Dx1dDIZW/WxKOBZ4AbtctaYvNgsvk5XBw=;
        b=Qk/3K8dsEt169LY+99cWoLb22Pq/IXZfUzHKkxGXJQwhF2nepaO4saZjfzCVcPew0H
         ULBfd7MuQqDURWRt9EYFxZEPpTjEfOqhcIbFvidUvjbMWSf13UwP36pKCu+H1KJt8mZv
         hFfT9oVFgENJ1VP59UdXyq5fVzfq31x13MVd0VZo4RUe1TlpioCRNIPm1oCEfDGey0Mi
         xzKBxwuMmIlzsZ94DwN/0Aw1ewsC65K/fZUNvaxMq0VpIHM/h0+dOd7fANNgm1F50vJP
         t9Tik73YegwZK58Ztp+6ARAme9Z/048VNInc3h5Rcn70BEejieFhO7z5z4iMYo8WHF7c
         RjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774495482; x=1775100282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0EG3jDsn9Dx1dDIZW/WxKOBZ4AbtctaYvNgsvk5XBw=;
        b=JkQqN5jF3AHEfcRR2gHw+3sWlj8OaoSKRMpA1j+xVYsDPAkTDtK6ePbyGWhIiIdnCp
         65jKlFgW3/D7rYxve4t1/fG4j8AyQqm2toW///yTCFtRTDJ65EvLFgepyXZQcc6Mj5GN
         ULadQrIm+/x+RsoEO1hjxmdNC/lBnSXTmycThcR+7uK/z2hzbp8LTmucDpc6KyazryqZ
         +ZIPgBptvHSJkOEorOQVlQ4D2p7/5stClfiQhqsLTrtxTCd0QwzIY0uKtsnb67lgKnXI
         sfLy5rzKv6AaTpWnk2WFOyCBDciN7kDKYrrdERrlFjtwnvvLQo2GzqjPBWUTwR9DnPFu
         9uuA==
X-Gm-Message-State: AOJu0Yy6/gozrC0zIA46EJuiaKVjJu/ioCTd+RbfHRE991IJf8DtG5iy
	cAaCjO9dQdAlXvekr0EpWVphWTC9il1fLdTLyhvx8WBEpnWI4MMnGiH5HjkU5h2Lkg==
X-Gm-Gg: ATEYQzxf0fG6Aryp0XijuGkHiiuxC9+MyUxNIrgrisO9+MHtRM5ON8WuLcr6nk6AbX4
	3EsFNyB08ZMv2w29BYtZkKwyc1nDCP2EhQCYRsrimlkH6xHFdKQRrNLONQKSKxAbkg8f80rKnFz
	x95AizkXxKpWUUjflOZcfJLH1ShoYseHCrr2lShAxXK9p0f2drLa0Ja4hAcFHY8mxhLKCYV/EHX
	4HMBzf2MBnYqB+cVHtTSnEcS57gYdiM8mBRvk500lh9CLbZF3fKueTeyXn1izxLw9tlvypt3wqz
	dWPtEETSROautDCny09dGB1Oh8eVghuim4+nwvkBYhrP4ens3Y+3Dce5DC0iYiupdbYpcG862x4
	oKpoRgMOpFgKTDTv+I83/s7aboXUUYJiGRXx4/R9MSpTiz+km5NalB/COt8reueVQYh7uWcJ3z+
	Bt8UMaMslP3ZrEy8FhSeGG8ZMbvaU51gRXXid7U2b8ohRDMnwSN9R7BQ==
X-Received: by 2002:a05:7301:ea7:b0:2be:a2d8:e9e3 with SMTP id 5a478bee46e88-2c15d468539mr3356070eec.29.1774495481658;
        Wed, 25 Mar 2026 20:24:41 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec277edsm2317280eec.3.2026.03.25.20.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 20:24:41 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM panic
Date: Wed, 25 Mar 2026 20:24:38 -0700
Message-ID: <20260326032438.3307549-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
interval value from netlink without validation. When interval is 0,
usecs_to_jiffies(0) yields 0, causing the delayed work
(br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
itself with zero delay. This creates a tight loop on system_percpu_wq
that allocates and transmits MRP test frames at maximum rate, exhausting
all system memory and causing a kernel panic via OOM deadlock.

The same zero-interval issue applies to br_mrp_start_in_test_parse()
for interconnect test frames.

Use NLA_POLICY_MIN(NLA_U32, 1) in the nla_policy tables for both
IFLA_BRIDGE_MRP_START_TEST_INTERVAL and
IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL, so zero is rejected at the
netlink attribute parsing layer before the value ever reaches the
workqueue scheduling code. This is consistent with how other bridge
subsystems (br_fdb, br_mst) enforce range constraints on netlink
attributes.

Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for configuring MRP interconnect")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/bridge/br_mrp_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
index ce6f63c77cc0..86f0e75d6e34 100644
--- a/net/bridge/br_mrp_netlink.c
+++ b/net/bridge/br_mrp_netlink.c
@@ -196,7 +196,7 @@ static const struct nla_policy
 br_mrp_start_test_policy[IFLA_BRIDGE_MRP_START_TEST_MAX + 1] = {
 	[IFLA_BRIDGE_MRP_START_TEST_UNSPEC]	= { .type = NLA_REJECT },
 	[IFLA_BRIDGE_MRP_START_TEST_RING_ID]	= { .type = NLA_U32 },
-	[IFLA_BRIDGE_MRP_START_TEST_INTERVAL]	= { .type = NLA_U32 },
+	[IFLA_BRIDGE_MRP_START_TEST_INTERVAL]	= NLA_POLICY_MIN(NLA_U32, 1),
 	[IFLA_BRIDGE_MRP_START_TEST_MAX_MISS]	= { .type = NLA_U32 },
 	[IFLA_BRIDGE_MRP_START_TEST_PERIOD]	= { .type = NLA_U32 },
 	[IFLA_BRIDGE_MRP_START_TEST_MONITOR]	= { .type = NLA_U32 },
@@ -316,7 +316,7 @@ static const struct nla_policy
 br_mrp_start_in_test_policy[IFLA_BRIDGE_MRP_START_IN_TEST_MAX + 1] = {
 	[IFLA_BRIDGE_MRP_START_IN_TEST_UNSPEC]	= { .type = NLA_REJECT },
 	[IFLA_BRIDGE_MRP_START_IN_TEST_IN_ID]	= { .type = NLA_U32 },
-	[IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]	= { .type = NLA_U32 },
+	[IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]	= NLA_POLICY_MIN(NLA_U32, 1),
 	[IFLA_BRIDGE_MRP_START_IN_TEST_MAX_MISS]	= { .type = NLA_U32 },
 	[IFLA_BRIDGE_MRP_START_IN_TEST_PERIOD]	= { .type = NLA_U32 },
 };
-- 
2.43.0

