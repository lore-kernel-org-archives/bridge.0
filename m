Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAADC182BC
	for <bridge@lists.linux-foundation.org>; Sat,  5 Apr 2025 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743848739; cv=none; b=eVUJ7kQXTg+02pgBQqZO3iHIG+aYU7KP8SaAdfeNd8yYojWAWZMV3N4UyXrRzVrR/eKqjKjiqqPtdyKIgvn/IWIuoKUbRcveOS8thhzb67o0DUF556h4GXi/pTY0kWUOmFfW2QzyosebRYpeUyMf+LipgkSncVw7I369WCzwllA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743848739; c=relaxed/simple;
	bh=qDbUGVc9ddRn0dviCjSgc3jstlkfiRFWLeY25SxpJaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nbKaENJapvKOOsfbN436SKpgRI/f4fQiZOmTY+wwOqQvzm2vQcgAhSh0acVuUCGjoyxUREZBBR3o/TyIassmS/+h3Do/iAOmEP0mOoitbhdUFbE9uVhsn6Bc5oa6a1+uWCgchEA1wK+VPomjs1wVX2uRJqnhevtcikOV+AFtVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=0cBYLiBX; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="0cBYLiBX"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51A9D40B57
	for <bridge@lists.linux-foundation.org>; Sat,  5 Apr 2025 10:25:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jl8IOpOpKZMM for <bridge@lists.linux-foundation.org>;
 Sat,  5 Apr 2025 10:25:36 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0ACB3404C1
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0ACB3404C1
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=0cBYLiBX
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0ACB3404C1
	for <bridge@lists.linux-foundation.org>; Sat,  5 Apr 2025 10:25:35 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso25446555e9.2
        for <bridge@lists.linux-foundation.org>; Sat, 05 Apr 2025 03:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743848734; x=1744453534; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x3p3N+NpdSfaO48hsEOGVkvt64Z/JP+ZSuhF28JzsA0=;
        b=0cBYLiBXmimGXN4XzFSZiYMg2tYHYE6Z2aQNYwGMjmOTMFO7uYmPcpKEneNL83TEIQ
         ImG3J7kdhijODnHi/MzCsJbs9+N+hYyVXkFz5esi/6qWAItf+P+nqt2hBUfc3eurYkRM
         00MvOl01Od6C6bQwgTjBaRUrXfDxHoJnPlgjn+rIjz8GkAfoBeNAEmo5mGOtWqdAvScd
         54zw9tqIRemnEsqdKULIFLXZHWhYN9mn4soA0GQf+Y4AimhuH4gPqzc9na/yec7qAe4S
         mqMIWtqfT9xlpmUqlmDzAhoJMAu9lXjtlyKvfqfaNQ+HDo9AuJGQBlKJLaQ6JN75AT8q
         3wtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743848734; x=1744453534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3p3N+NpdSfaO48hsEOGVkvt64Z/JP+ZSuhF28JzsA0=;
        b=JqFwUrNtLRzawpVlzs8GAtIxpDpfMCAbTqiv0fxcZvuM/x+YbXYLQY6ONOKk1rtNGN
         Mu+jLjZY0nUMoaQPmIAosrjOnqOkwtd3oqCjepLM6ogBhj9miqvmedB5tigma82dkpa2
         CY+5LNEX9bzuqd0p8SHZWaA+4pxphF6bh+PqARsGW+vR+aCzXmvpPB5POfYNe5f3CAoL
         QOHi0mwMLNymCeXZ8pJuKqVTfcIrvQrk+KnEmQvGtL8iXaynUjXGwbm6+Q5uOc7z0fAG
         oK0B4y1g2SoYAz3zrs5JgIyyE7rAdpzbU3CPceqCBRkRCp5vitcFqOSXJqbeRKx0qkgl
         YhCw==
X-Gm-Message-State: AOJu0YwS1DXx3RntIZMBHENGYl3X7e7N7bgYlv6IQcMYif75KBCcQHrP
	9BiuwUnnDLH6syCZqt643pE4rNjx3UlBkLGnOdGbIYQC/1TqbPqhwqCX2O66eOY=
X-Gm-Gg: ASbGncsc7h2T09X8ApRZzpqcHJVWTs9B+wJqohtk00PXmTGtLjnsIcs06tpugjhytsi
	twgsRFRUUEpg+H92Gfe2a6v6IhqiDXwvTItiGtK9Wgg0cv5qtTcUm52r3LbgpfietJuuRAdRl3h
	gJbSKGd4t5Qm9SHrxyku9JhMYFku/94OsfrImDQwJCqrrNoXs1HWcLR3DjoEfNnuuX3jfCmtt1E
	4Qt7d+vO/EGl47vcTB+rOJVhJ5FKPHGihE6l69xtiJmG1zNqX16144LHFawQFZ8tvRZrg0+2K+m
	Tdmf1Qy03RMjwyUPGKZ9p1ba1/wSYarmM07s9IIBXvoOaarlgValnzhF7guWDKbjhMfqZIsmbo/
	7
X-Google-Smtp-Source: AGHT+IEBZ8NJfJ6jcZr8611CUZAbceEKAdRsLSk+mFfwMk7tvXvHh/qQYlpZkHchFr2NORuwj3yBjw==
X-Received: by 2002:a05:600c:a07:b0:43c:fb95:c752 with SMTP id 5b1f17b1804b1-43ecf843e91mr68245725e9.3.1743848733679;
        Sat, 05 Apr 2025 03:25:33 -0700 (PDT)
Received: from debil.. (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec16ba978sm72524185e9.23.2025.04.05.03.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 03:25:33 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2] MAINTAINERS: update bridge entry
Date: Sat,  5 Apr 2025 13:25:04 +0300
Message-ID: <20250405102504.219970-1-razor@blackwall.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync with the kernel and update the bridge entry with the current bridge
maintainers. Roopa decided to withdraw and Ido has agreed to step in.

Link: https://lore.kernel.org/netdev/20250314100631.40999-1-razor@blackwall.org/
CC: Roopa Prabhu <roopa@nvidia.com>
CC: Ido Schimmel <idosch@nvidia.com>
CC: Stephen Hemminger <stephen@networkplumber.org>
CC: David Ahern <dsahern@kernel.org>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 84931abd561d..c9ea3ea5accb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26,7 +26,7 @@ T: git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git
 L: netdev@vger.kernel.org
 
 Ethernet Bridging - bridge
-M: Roopa Prabhu <roopa@nvidia.com>
+M: Ido Schimmel <idosch@nvidia.com>
 M: Nikolay Aleksandrov <razor@blackwall.org>
 L: bridge@lists.linux-foundation.org (moderated for non-subscribers)
 F: bridge/*
-- 
2.49.0

