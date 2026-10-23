Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792719960;
	b=N6Brjqip0TFqDragLGmdqVDm26oIvCn+VcF1RGsup1i1TcE1EcYHnZfS/oXdGmvgFhzs
	 GUleaVpiq4PlR0enMFqcjdjrw6O7ur0c91emnBIbbPKD43mbgQwYwoD+C3AIJb0m86XWs
	 aRYc32pDkJOFHdHAFkKr9TZwggwBvmJJ977EmjrZwKw/XHex48K3BxeHvzXYjskbp5KgM
	 vFnf2al8G373ptPocyEg8tgVlyuB+3n8ndFzryvezaNsXjKFtuhKszYxOVnmgIiEVIfaW
	 eyH3tafCCGECS8FSPuFacCk+d07lZvENf9EacjJMEuYF2mQi1S2xkyyGROHj9ox2T5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792719960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+2nBh2hTg9GyHqgEIUG/XcZolp0eeZD3+vc0j5AmUsg=;
	b=e1DJABXi1BYTEERgGTfm1AHAKjpf1BKmq9u7BQldC4kffwiP6Hurxv8JpGMmPfYw4vuw
	 Gu+k93j+LP61LYWx0/nDklUP5bDTuGZPvTU3WfTZPdTQ1E7ZKCLvb1oGQ5bedrs5Wp1wW
	 2CRHMGB9nm0+sh12Z1JN0mA0BpL7Sj8FXIs2bFy9b4kOPouAE9b+cIXn+qwhW7yUoOSeh
	 FZ0CzpGaCey4pLeln+byS7Mng1zUxQM085TWrdHbvI0UUZ3hhM1EXS/bVzodnekDhJt0U
	 T6BFb00VA/5moftbk9lXgGm4S+GMXd1XnkXRoPUf3oEjZ44kj3zdXTkTqR/GGvMfVZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=corvaglia.dev;
	spf=pass smtp.mailfrom=corvaglia.dev;
	dkim=pass header.d=corvaglia.dev header.i=@corvaglia.dev header.a=rsa-sha256 header.s=google header.b=DKCo1Pnh;
	arc=none smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A3606A319
	for <bridge@lists.linux.dev>; Fri, 23 Oct 2026 01:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D3A3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corvaglia.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corvaglia.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=corvaglia.dev header.i=@corvaglia.dev header.a=rsa-sha256 header.s=google header.b=DKCo1Pnh
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-679e6ab6471so1589693d50.0
        for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 18:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corvaglia.dev; s=google; t=1792719958; x=1793324758; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+2nBh2hTg9GyHqgEIUG/XcZolp0eeZD3+vc0j5AmUsg=;
        b=DKCo1Pnh4VyTiOAf0BR6NlPi6CrRzoAnmkCo3868Dw921ZfqYRSi1JqyEe4BCVbpBt
         pBAg0JgYEkKz8Ej8Cj2TibrPuScgClCZdKPWLIoeyaGcAw/RIWQj7UZhRNuF5Mm06K+u
         394wNB8RXaoCbF6pmeI78o5FGrKCm8FAD/egJqBTh96U2lRYKSOr/wKQanmTjtE7G+9v
         YOO65U41he3T5pxKEoUPd1dd+A/mAae8yPM4ZpoDbhFHl9zJTEe0jPiKgm/05tPeabZh
         rFGE72RY/JZCFcHjn2jgA2jx+bLhk+739DPtX4ac3/bMGwZjt+DC8zMkh5tfqoSRvOqb
         uFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792719958; x=1793324758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+2nBh2hTg9GyHqgEIUG/XcZolp0eeZD3+vc0j5AmUsg=;
        b=y3DJyc1PQIQhknNgdGGPHCXkqPWXrJrUq1mRKt0pYk1Fei7AksBaBhVuPt6QL1ZKsA
         IjltWKBMdgO0DelJrbXWuxIa00OjoR02lhDBy4TIVWXiw8BfyMtOgajDAFeDP9KNsb0F
         zBUVrH2G9yJzSbRVBq1TSVlMCRvmY47sqYt+cXLxwJJamEzwSkW7P6gH5MZW2qWkGk2A
         xKHkG9nz7at7jufibAFcoQNPDEKI0CHr30ZffnNmYU3jLz0bAHQHkrXEQJ3TXVDJjyJw
         hxIwYPK031PJWEEzuVqGnO8Wjfuxck8AbVw3eij+JaXeb8/0/Gm7uvlrwWQ88+WJczAa
         nHQA==
X-Forwarded-Encrypted: i=1; AKwUvBxWD7Z8j2gVG2tyKJ9l54PM2SLqef00oCK/QdieeNZPOQpg0BKcHz+6CGCayRiPCwbOmB/kc+o=@lists.linux.dev
X-Gm-Message-State: AFq9FYJo0mNaoFmAtzWPUMO0DDlHOJNFikxJXKGANKsK8FVhUAWD4OJI
	Yl1BSobk6lL2/m61SBVvLV3qIAzIAOkUc+iBfn5VDtgVY10GsP4BZOpDQPgJ6OdLVBq3
X-Gm-Gg: AYBFou0HSbQLgqvoWA2mJtFHO35/bBVVwmbgvoD7z95ho1q9XJhoM4mn5uJBMl/LTdZ
	wK8Y1g7LNTbRK5iI88aWTnjyyV5scKSRNWGdgb1W3jG6yewo5mHDRDNyLcRAZp9UX3zVWwj/UPR
	IM3/b8jqxbY9Kl9o0qqGo+HC3ZKOpJDQrkfy9PU2whHBjze4ih5rjOjJOM4Omi9IVzrgiQngRpQ
	EQVp7YSnolQ5n94jVRtL6UyqQ+aHmEOVYHqojAWCeRvGYCmZlPRIXTN3Lm3XSgHdiwWI1dZ5XRU
	JP4P8FzxGigbkvH8Na2huvrNRrht41tVuE6aCCK6DUXPp/OD5EI9b5HwgCQsfgYxlNjANfvH7tn
	2oW/cRAjta0OM9cNPvK9Cp/+ZR4eKWdCFIhBrMz7oOcs4df3Nnp6I0d0V7oghK/vW2+XIHJ931Y
	degTyPSxdsaMyU212g3ENiEhNi0Mzyx5JRqqbg5exAdGyMHXkZJ4NFDPM+5d7LLgmhS4vj1awTA
	lU1GLTkG7O3EaXwwfRD9eUWZofgDsqrBGCgGhYsaT3HD5f9cUkSusxk9dzs1a13
X-Received: by 2002:a05:690e:12c7:b0:679:9e81:e51b with SMTP id 956f58d0204a3-67a21ae6a1amr2754679d50.0.1792719958345;
        Thu, 22 Oct 2026 18:45:58 -0700 (PDT)
Received: from voyager.localdomain ([47.160.132.81])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a33fd8997sm628743d50.4.2026.10.22.18.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 18:45:57 -0700 (PDT)
From: David Corvaglia <david@corvaglia.dev>
To: netdev@vger.kernel.org,
	bridge@lists.linux.dev
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Corvaglia <david@corvaglia.dev>
Subject: [PATCH net] bridge: mrp: fix silent truncation of IN_ID
Date: Thu, 22 Oct 2026 18:45:36 -0700
Message-ID: <20261023014536.72444-1-david@corvaglia.dev>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IFLA_BRIDGE_MRP_IN_STATE_IN_ID and IFLA_BRIDGE_MRP_START_IN_TEST_IN_ID
are NLA_U32, but these values are stored as u16 in their respective
structs. Values above U16_MAX are silently truncated instead of being
rejected.

Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for configuring MRP interconnect")
Signed-off-by: David Corvaglia <david@corvaglia.dev>
---
 net/bridge/br_mrp_netlink.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
index 39f07e13fba5..5abad1cb3914 100644
--- a/net/bridge/br_mrp_netlink.c
+++ b/net/bridge/br_mrp_netlink.c
@@ -6,6 +6,11 @@
 #include "br_private.h"
 #include "br_private_mrp.h"
 
+static const struct netlink_range_validation br_mrp_in_id_range = {
+	.min = 0,
+	.max = U16_MAX,
+};
+
 static const struct nla_policy br_mrp_policy[IFLA_BRIDGE_MRP_MAX + 1] = {
 	[IFLA_BRIDGE_MRP_UNSPEC]	= { .type = NLA_REJECT },
 	[IFLA_BRIDGE_MRP_INSTANCE]	= { .type = NLA_NESTED },
@@ -241,7 +246,8 @@ static int br_mrp_start_test_parse(struct net_bridge *br, struct nlattr *attr,
 static const struct nla_policy
 br_mrp_in_state_policy[IFLA_BRIDGE_MRP_IN_STATE_MAX + 1] = {
 	[IFLA_BRIDGE_MRP_IN_STATE_UNSPEC]	= { .type = NLA_REJECT },
-	[IFLA_BRIDGE_MRP_IN_STATE_IN_ID]	= { .type = NLA_U32 },
+	[IFLA_BRIDGE_MRP_IN_STATE_IN_ID]	=
+		NLA_POLICY_FULL_RANGE(NLA_U32, &br_mrp_in_id_range),
 	[IFLA_BRIDGE_MRP_IN_STATE_STATE]	= { .type = NLA_U32 },
 };
 
@@ -315,7 +321,8 @@ static int br_mrp_in_role_parse(struct net_bridge *br, struct nlattr *attr,
 static const struct nla_policy
 br_mrp_start_in_test_policy[IFLA_BRIDGE_MRP_START_IN_TEST_MAX + 1] = {
 	[IFLA_BRIDGE_MRP_START_IN_TEST_UNSPEC]	= { .type = NLA_REJECT },
-	[IFLA_BRIDGE_MRP_START_IN_TEST_IN_ID]	= { .type = NLA_U32 },
+	[IFLA_BRIDGE_MRP_START_IN_TEST_IN_ID]	=
+		NLA_POLICY_FULL_RANGE(NLA_U32, &br_mrp_in_id_range),
 	[IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]	= NLA_POLICY_MIN(NLA_U32, 1),
 	[IFLA_BRIDGE_MRP_START_IN_TEST_MAX_MISS]	= { .type = NLA_U32 },
 	[IFLA_BRIDGE_MRP_START_IN_TEST_PERIOD]	= { .type = NLA_U32 },
-- 
2.56.0

