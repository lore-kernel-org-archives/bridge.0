Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D219318ED9
	for <bridge@lists.linux.dev>; Sat, 28 Mar 2026 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774679405; cv=none; b=qLgfKdCy2UB+9m560tYBzsy96BgV+uq8bveun0wAcQ6ec33ms8vE45G2+ZEqdO5XgykMMDefBui67tuhbDXSnAJdLSZxVGU5hV5KNQ9yvhI/c40ezP5BD5sc3mb37ixJDaC6OgK4vjW0ScouNqYtaqrC2v5ZOF8kR//mazb7U24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774679405; c=relaxed/simple;
	bh=xW1wc94YfM9S77eQBr4XSjqABGmaEYNxYjRtreidgFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qsOEBWEp0A0MrzOO5yzd78Jt2ecHfEewKoCsHrmjGVf+v1D+3uli19+rtv0Y10+Keun25empUrDHeXyb2X2exCW1FCZ0tzMzalVCuXlGBwi3EL73xs37JeikwXiSKuK2hZeZndEspRjNP34rTrpDH0ktLBcdzqWD+F2OzlgWEcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=EuQSO5Io; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="EuQSO5Io"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b6b0500e06so3940879eec.1
        for <bridge@lists.linux.dev>; Fri, 27 Mar 2026 23:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774679403; x=1775284203; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZC3wXGU2hX/iAEcs6Ou5xr77klGlMLsUM+XsPJ10yg=;
        b=EuQSO5IoXj+NiQWudo5Kg7f4LmQ4KkjplWhmcpAmZZwtqG8s5hvm8Wgytxna5tdJbU
         ipmSkT3vJipx8ReerOrlyBPwQ79LKrJdzQcqcGTB8/4ihkg6guDgypU4Pkn6yp2LK/Yu
         2SvOOg/OBVsXooT0MWBHPv4bNL9rY3fKWk33l9WPlDG1dp2xbTbWEQt5tnt694p5LqMT
         PZcp1118c/on6ITK0SzVoOygykAm3DVFdTwgaSzR4Fj2vA7X+yXfZBCIYmC8OVUNfEsg
         z4nlMwV2bPbEtBxNjwlmHHnBA4515p84IRm+jtL00O/xjI3e97gik+MHyReoAO73QSVH
         5Vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774679403; x=1775284203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZC3wXGU2hX/iAEcs6Ou5xr77klGlMLsUM+XsPJ10yg=;
        b=hiVgGLI081v5UirkvJYX+VNXxuaP8G59PJRO73LlA9OKh7x7hcdBzWXaG4AuS5/LAe
         hFy1ojfKJbJOL+j8aRkFhA6+fEjw8mrDiJVVteEoss4MKbT51vIvgWjS3rJosuZfkbkP
         UMFZ1Ll33Yi1MCo/W9/6RLoZhglUzznXobY5ShNHrQnh/b1kC/xH60ieWr5x+K4ci6Cf
         XWnd5haOYUy0VpRAQr8PtcWS8Bawo4R1OHMQ1S94sSSnb474+X7IvNf/7eAuDvd8yzix
         Q91GvQboQj2VCLZK1fnUTFoorwlHr0AWWO4I/7+gsDOfPOzH89esYkKv6r30Uup73+6z
         Jg8A==
X-Gm-Message-State: AOJu0YzVwE9fmevE2+C3xMEOo2rmRx2cICJC6DKM8J7ilUp0Li8aAzFn
	2sOMNkDlDXW1JwopXTyjyvB+rt+oL8+8tXR0+vkjW3qIkbfajmEpH9wOO6m4fWmqdw==
X-Gm-Gg: ATEYQzwwWdYEPW9F9fcO0jQfe3A250bUPVjslYYWfeApWu/Yvba6i1pdlrYX9BZgM8T
	2KWBg25KGzGKoUY8RwyXDRIqaSpXC/6WrnYvb3eBgsQx8+dz9+ulZDHhv46Gugbu/iHoyvZR5EJ
	2ZdnYGS+OP+4URHBkFg0br01+tR75hLLgBzV7JAXC43iRbf53fwf22Yqbr0eEj0q1xnMilD13Q7
	q3+2bhwVNLYW+yakBH4gV1PKfiN4VWt7fYvgMEA/IIaBQgUE/4UMac6f4+PgGUgq3shAr9QOjbf
	jqqTpVwxZwB4/Uyyjywp2+pnMomL061+sifLw2Q6ZYyxsXN7OtIDrNyPapr3YHstVFq4AubPrAH
	vJS4hMeccmuK1yoBwCB225O3fzhbXT8pS7InJ8045NJEnKWlvX5tWnL1GUL8j0bPm2ynj11kITd
	WzZwV/PEZD5g+7zxLxruAl/o7gvGsSKrfK5gAUfFq2or8+HT+GixeQJA==
X-Received: by 2002:a05:7300:ac8a:b0:2be:fe8:8b0a with SMTP id 5a478bee46e88-2c185e44a68mr2625453eec.21.1774679403069;
        Fri, 27 Mar 2026 23:30:03 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c7483ffcsm1376216eec.26.2026.03.27.23.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 23:30:02 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	horms@kernel.org,
	razor@blackwall.org,
	kuba@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2] bridge: mrp: reject zero test interval to avoid OOM panic
Date: Fri, 27 Mar 2026 23:30:00 -0700
Message-ID: <20260328063000.1845376-1-xmei5@asu.edu>
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

Fixes: 20f6a05ef635 ("bridge: mrp: Rework the MRP netlink interface")
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

