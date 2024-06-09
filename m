Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFD11CD20
	for <bridge@lists.linux.dev>; Sun,  9 Jun 2024 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717929437; cv=none; b=dEKA1XiOsZkzBOTPQpHJS0eBjUKSCIXkuQeIIxsmnz88fMu0Ey+VKgsvGBhipXT6ih33WWmdawyyQkR9IMiA7BLe3ZT0BhUMqG8Sk3j4Z7T5Oi4Cet92CgA82j2HIDb6sUTSLc225pfUaLjRI9aTz/KJP0q0ijmW6dHse3ch+/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717929437; c=relaxed/simple;
	bh=4TXi9SXz9OVyOJjNs/IHWB8Qsr+wbVOl7SsAVYV3TgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAMwsuChfXojoPdcHwveuMya90tZu5CCa3Hoij43ai6JDAbP4hYlw54zpCtt29tB/OYWB53CC0l2TN48rRa378ioXAgMgm4NUJm59BUi5LU8+SC1DMO5NkATrSa+N+EWTpFT4Pbe7r7Sgb7RkVwpJ2bN0Jd9+luGzly+wzf+z7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ug/z7sJb; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ug/z7sJb"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57c68682d1aso1283393a12.3
        for <bridge@lists.linux.dev>; Sun, 09 Jun 2024 03:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717929434; x=1718534234; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOj4bjY+lhbhqxjIIOB09zL/M8kVwJXeIo3CY1Bd0ew=;
        b=ug/z7sJbydm0fKIB28c/O/wNHDrfWf3KWNt6Y+nvAsTZKuyHP8uxZ8G+yRYlFdxR2h
         nUwUP348f/kslTy33S4Z39Yre4SEQf1fB+GQ+l462c9e5BViYNb3LbFaJfk/bsUNEZgI
         raFBE3gq+VwdOTsY5+AOsuGKaSfdUj3lXGYmrMMaZVK4zAIBewLTL9y0Z9vN6ZQw72GE
         vx/uTEXM4acRBfggwty1kZcwfYHpZYEkebT1qiseCaMjYYmGOUlCT8vYbmpv04BW1HSL
         L1abKuOHEN78YT5ZQFAIg7rmETTzaZChv4yYIz8YL18fxP1uKdjVJCBk2Ih+I5uoWklK
         Dp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717929434; x=1718534234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOj4bjY+lhbhqxjIIOB09zL/M8kVwJXeIo3CY1Bd0ew=;
        b=lSDj4IQOldmYEBiC4lbw4TJ8KzdBH+UYp+lX0hcqFpXOX15AGwsgRQtGUtViRHZemr
         WiGU67cgDXEWo1UxEWdrEud1rTbrOcVfsq76dD0KKPYQKbWvpUdvLk3JZ2VnRNu15gcJ
         RbdyFm9suC3enbz5mLiIlblHE8SLxaJ5uIk3Fp+5l+Q6ZU/Afx3xd/NlQrbp4w3B1bsw
         kBSr3gDIgGcCyrjt7Bf0smGjFETXZDiZfSqmY+tcfMvvF/iSvT0SV+VtQiiULukQn89A
         WYvUcCqzQTAfQnsgvx/A9PyBU44R6t3iA/auvaw+OrNcFnBTRXRAYgC9WDMmBCASRGi+
         8fcA==
X-Forwarded-Encrypted: i=1; AJvYcCXY3+y1KOD0LdHeNsS3zRy9RPZv7UojCNPQvqOWTVZJ2CBd91iznFpCXoC0DGu61tgWM0Lue9pSJXE8aiFSHrVl1kMRe/Cw
X-Gm-Message-State: AOJu0YzviBGUawfZnNeR7IhQKlLT3CMEQmwuVEi0ILcKOKakL7Q/k5dI
	OrWbzshbxF6K6VZq/dSzWfrMtw4/t7QkGUpkWcgw3Q12Ong9e5CWoCxgg4sadls=
X-Google-Smtp-Source: AGHT+IFr3TV6EzXli/aPkOkGJCUsIaQl1kozvgBR2nlBuHzkW0c9AioUt4odRelhKTQ6w6F7ccpE9A==
X-Received: by 2002:a17:906:2b52:b0:a6f:1473:379c with SMTP id a640c23a62f3a-a6f1473387cmr98709766b.45.1717929433997;
        Sun, 09 Jun 2024 03:37:13 -0700 (PDT)
Received: from dev.. ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef8c01579sm259579966b.155.2024.06.09.03.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 03:37:12 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com,
	kuba@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	syzbot+9bbe2de1bc9d470eb5fe@syzkaller.appspotmail.com
Subject: [PATCH net 1/2] net: bridge: mst: pass vlan group directly to br_mst_vlan_set_state
Date: Sun,  9 Jun 2024 13:36:53 +0300
Message-ID: <20240609103654.914987-2-razor@blackwall.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240609103654.914987-1-razor@blackwall.org>
References: <20240609103654.914987-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass the already obtained vlan group pointer to br_mst_vlan_set_state()
instead of dereferencing it again. Each caller has already correctly
dereferenced it for their context. This change is required for the
following suspicious RCU dereference fix. No functional changes
intended.

Fixes: 3a7c1661ae13 ("net: bridge: mst: fix vlan use-after-free")
Reported-by: syzbot+9bbe2de1bc9d470eb5fe@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9bbe2de1bc9d470eb5fe
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mst.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 3c66141d34d6..1de72816b0fb 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -73,11 +73,10 @@ int br_mst_get_state(const struct net_device *dev, u16 msti, u8 *state)
 }
 EXPORT_SYMBOL_GPL(br_mst_get_state);
 
-static void br_mst_vlan_set_state(struct net_bridge_port *p, struct net_bridge_vlan *v,
+static void br_mst_vlan_set_state(struct net_bridge_vlan_group *vg,
+				  struct net_bridge_vlan *v,
 				  u8 state)
 {
-	struct net_bridge_vlan_group *vg = nbp_vlan_group(p);
-
 	if (br_vlan_get_state(v) == state)
 		return;
 
@@ -121,7 +120,7 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 		if (v->brvlan->msti != msti)
 			continue;
 
-		br_mst_vlan_set_state(p, v, state);
+		br_mst_vlan_set_state(vg, v, state);
 	}
 
 out:
@@ -140,13 +139,13 @@ static void br_mst_vlan_sync_state(struct net_bridge_vlan *pv, u16 msti)
 		 * it.
 		 */
 		if (v != pv && v->brvlan->msti == msti) {
-			br_mst_vlan_set_state(pv->port, pv, v->state);
+			br_mst_vlan_set_state(vg, pv, v->state);
 			return;
 		}
 	}
 
 	/* Otherwise, start out in a new MSTI with all ports disabled. */
-	return br_mst_vlan_set_state(pv->port, pv, BR_STATE_DISABLED);
+	return br_mst_vlan_set_state(vg, pv, BR_STATE_DISABLED);
 }
 
 int br_mst_vlan_set_msti(struct net_bridge_vlan *mv, u16 msti)
-- 
2.45.1

