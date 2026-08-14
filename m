Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D31341A797
	for <bridge@lists.linux.dev>; Fri, 14 Aug 2026 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714864; cv=none; b=mrJBo6jk/VcyTNxnbxpVqzj1sFCC95kIMnPeqF4TFpyIrFsqDOCSgbJiPTZ0V/si/EYg4O8wYkiV2in7t+DqWAGkfDWnEx+/zRTf+bc7G9+endhDpJOBeamwITRq7DC3ofRPgLe4W4Loazh4NYib1tirGMg7ji22Q6eZq2hFeWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714864; c=relaxed/simple;
	bh=ZCtbq8/4454INlMgyOXmWQio4JxckUhjzIjAlzKMO7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SwGPoA+KKq6rnz+WLb/Y7HF3+Kca4LFzi9LQhSEs5A6dQNq82iRWmN2srhetLYR0FTqxNZ0f/akxyht51wBRFYGFM3XEUz5/l5o48p0fbIStLKS6xG0/wqmCA4417W4+y7wh1w/9O9Ks8P3kDkNXNtxetsBywZfDjOSdNPNYN1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BU5Hg5In; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU5Hg5In"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso11019355ad.2
        for <bridge@lists.linux.dev>; Fri, 14 Aug 2026 06:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786714860; x=1787319660; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zipcP6cMMo2au5RIIwFC0kV7yCXjZzf04W+orfthdMs=;
        b=BU5Hg5InMFUBb1nA3QpqiXAvKxM13AqLHRDbOc0ndsUqL4ZVTPQDLSuuP2O/RkHk5/
         /tRA3DqaeZInB5PoHuu+oGXfUdZ6Nq/G2QzoIka2PGuuUAevqNxpjnuNHXZvy+p15QK2
         bbiVv56OrpmGq7F/hVZsQLFR5gItVjSEXDU5OgfENpPfzzy54f3/v4AGuz4BNJhIrU7m
         6edcywTzeeV4HaTowMADxQZCt2EU2if2Ku5IPw6J4sPv7jbsT3AjrLLSlyRe3wUKLZGG
         VxE4cpIJNZko5/4rjA2OnVXvf5+HcTvU6jd3uzaZQllc9dK2qbv40DGndXEvrWGF+qjX
         EBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714860; x=1787319660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zipcP6cMMo2au5RIIwFC0kV7yCXjZzf04W+orfthdMs=;
        b=T5hjoZ75rrdJKE09bhanH2eLB48VZidKgDTgD631xlLvcw7lQ2JzwfTT00MFaqtvA+
         pbM1QGMDQZnRP1G7R8T895ps5++tCiFmmIJAJuXwLU75ERxjlIWB3/RHGlHCHkxqs03v
         brJMPrhrihu+Zn5kBkD0dK1V6cDRPodg7U26oflxR7udot8AUnQ3xo6rj8i3gJKGyss2
         m5cUctkoX7Tud6KWQxbyAe1VyqgMxbOskiNL+AwHPl8Di1BvWDJ0LwyBz4BLMz9e4xxM
         CxQ9Fixhpilwr5UqokNu+zMWvNTK+Rkck7tMNjwYBlZ6pAmX7a8iAW28CXLVJm4WVNI/
         z0Dw==
X-Gm-Message-State: AOJu0YyvEHGi/FmXZM9dBrCdJZ32xNQih2YJ9L5h09FZxhCB0DlRRL+P
	/AO+S8wm6Dz0L/uN/x/vUDZwSylLJ0/5a+UFwfmpqvKj0eBu2B7PlWux
X-Gm-Gg: AR+sD12EMMOUqgY1zXqdZznqEneMJlKZU0sBdbQl+Uuzl6Cy61QyLCYB02sEkOgUrOn
	ntkTbZwd7uLfV0dab5wQzBPrbjFUPubYfhkqA4A9h/TDrQ/u/eX9dGbG3MDtM01cVBmVKv+K5do
	6lvQ4YFxBmyJ6dcK1pfqb1WksYErAaNR6hgwnH2siIiXts4VDw2RTiCOgS++9JTILabcj1Ewigi
	TBYgFc7XOx4NjWaSqcXdQHAOyP2XZ1ybz1kPhRw2MqzRkBCIZOxUMCTDKBuehDDVlkfb+1dHuTw
	vH8ay0eQgH+W+CaEnSL+jDQ53Dsa6kJRhEwWDbj3JdUutdNVKCb5ew71I1VhI1NIGxOMMogR2qj
	DHCv+UAVXLUrFB9avwQdtoCL+ddctdxG1sVpV5E+O0tLRv/So+4DP7OjG9GUMN9HFVgPzXie9/c
	yxL4ODPLws8poJzj8pnFu4aYPVprZxRbGOFUE/VzQHAij1vC8OADrMN0IieZ7OdzJD0g0Hs4S1Q
	8ESeC8o
X-Received: by 2002:a17:902:e547:b0:2c1:ee75:56bb with SMTP id d9443c01a7336-2d3b0dc57d3mr63121865ad.20.1786714860112;
        Fri, 14 Aug 2026 06:41:00 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:e9af:7c0e:be31:2c3f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aebc3de2sm9822995ad.70.2026.08.14.06.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:40:59 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH net] net: bridge: Reject descending VLAN tunnel ranges
Date: Fri, 14 Aug 2026 21:40:53 +0800
Message-ID: <20260814134053.1387275-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A pair of descending VLAN and tunnel IDs can pass the tunnel range span
check. The VLAN subtraction produces a negative int, which is converted
to unsigned when compared with the u32 tunnel ID subtraction. It can
therefore equal the wrapped tunnel ID delta.

The range loop then performs no iterations. Since the batched
notification handling added a post-loop error check, this leaves err
uninitialized and makes the request's return value unpredictable.

Reject descending VLAN ranges before comparing the spans. Valid
ascending and single-entry ranges remain unchanged, while malformed
descending ranges consistently return -EINVAL.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 94339443686b ("net: bridge: notify on vlan tunnel changes done via the old api")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 net/bridge/br_netlink_tunnel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
index 71a12da30004c..05f560eeb789c 100644
--- a/net/bridge/br_netlink_tunnel.c
+++ b/net/bridge/br_netlink_tunnel.c
@@ -301,7 +301,8 @@ int br_process_vlan_tunnel_info(const struct net_bridge *br,
 
 		if (!(tinfo_last->flags & BRIDGE_VLAN_INFO_RANGE_BEGIN))
 			return -EINVAL;
-		if ((tinfo_curr->vid - tinfo_last->vid) !=
+		if (tinfo_curr->vid < tinfo_last->vid ||
+		    (tinfo_curr->vid - tinfo_last->vid) !=
 		    (tinfo_curr->tunid - tinfo_last->tunid))
 			return -EINVAL;
 		t = tinfo_last->tunid;
-- 
2.51.0
