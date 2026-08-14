Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D3C3BE642
	for <bridge@lists.linux.dev>; Fri, 14 Aug 2026 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717030; cv=none; b=q8BVT1/2GChLiNgy3tt2DCT17SWEkbKeEpwhxSAwT5crtQZ/R9JZd5GCd9LlKMBbP87XLNC+Y97FPNLJ8C7VIiZ5KxRo2zqOpHr+RD5cIuck2q+V1J+9IkO9iYYNqkIaAesEFQ7lR8ewDBVMa3+a8NUVrTHeIse26DZYahaPWJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717030; c=relaxed/simple;
	bh=+1pofQkSiSZNjqrELg6oiqQLO30fdl24DyzOPTIA+do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E55FeA2vPKxKkw+y0w0l7+lqjxviVvUF/5LftCwQuakPeZGDIk2oOVT+7ZN1iuyX0jbBTX+LqLOZVK6PWVEWVImyWe56vs9t4HYVWfeM/e4hKN14KnKkUo0ljQJr26f4LMNgd7WfeEBMf93aaOAFIrzQoK7c1ondKgnd6A2RdHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=e+PMqDUH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="e+PMqDUH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49800c6a846so11387685e9.3
        for <bridge@lists.linux.dev>; Fri, 14 Aug 2026 07:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786717014; x=1787321814; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JW1WdEQv/IZL7koXdWZmPocV2txIARzi4HLvEvaMHqU=;
        b=e+PMqDUHaXfvu8lVlNNy6Vq/R+E0Co1sMi1GvLshWiCTPqwv60b1R4u3DHmL6ufgcm
         3ddiu9QwHu3mZEquYB7lqWD6iwyeZSKfp/6xNdRbXQ8cogZo2+lY1dC3EKqKue6ogzgY
         juyIBEemY++ehw8ccDHC1wklvcepWJU7A5y8Jt2ryYadGhAH9WLCmvlB6QZxZIOj4SEs
         Z6sGMHrQdHHdgRZ8xBk07R5lKBXEUxzlBlsEUvh+bqh0W8s+BYXc5KQmqpZboUpbF4jZ
         8CQ/d302bWLg3GPW73RLp99D1aGcCRuoJSXts5qh+7IXRWvtVPK8eF5erTolM983Vu3/
         WRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786717014; x=1787321814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JW1WdEQv/IZL7koXdWZmPocV2txIARzi4HLvEvaMHqU=;
        b=XNx4Gw6bDuQYjfBQMPE8J9CjRnd0q5EQnc/XP9S4RgKrThEyOjqjjGT6w0dcZ/MxBp
         li2AkMiDpNSQLHv6lIGcQBFX9BRP4Kn14UpDhTvk+JoC4AUo36nZpA+2981/kqlBi2bX
         Og9zrjlwcI4P3bNMjtamDjnvW7t08YcDPtpMGmuGI1GaXD0zX3Cck3V4kb8CGTfH5PKE
         AM32B3JfqYic6vNrAQZ870QBvZRpSLq+Yvz8x2Dxng07COwC0F9DXKngYffnO17LkW6H
         xrK4iRTf698cfexEUiEHY3q/Inx1BtVxOac9smQe/lp0AQUF5P6jAjiA7+tmvxjt1myt
         gE0w==
X-Forwarded-Encrypted: i=1; AHgh+Rra0PzpdtxmYJrO+38HGZYgqsF6nEiRBrhXw6v6W3wPLgyobMVCNmhVp60TTCHxrEt4MQUXcfQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YyEzywVYISpuszTww5yBMR3sC7WwR+g9Ey+sogVfrcj8XhcPp5/
	wCmyqYjZ55TTR3SidzNhes+3RmXziClWfPZZNNIWq3V2bx80Gmld4ggM4DBjC/JuRwk=
X-Gm-Gg: AR+sD11uEK+ElEGkKWhVVV6VXakGtCHVX6+5djw7KPhXjWj8qf7t2CaSroL68XS32qQ
	ePz9wNKiXXM2fxWDjSMdzzEs3Cj7/slrex0lfzKW1EsVhdIee1DXylVeSGOgbxYk48Ld84yBhmv
	JLdT636hasWFYbK84ZOvJcx0hQ6VDoiEUU6ZylY39zb9usDKyT7a4DNXY61MKIpaYhkZR6hCdY1
	bYF0o7QX0HqXZWgj9a4k71DgGlX+KlxHo6SaOXkTXr+3ceGO0ZkbUYuHghlD4S9tXRWQ2Bj958c
	i0hXXriKbp2iQ0EFhy+0Z2LL5nxFc00SaTDNiJ8Rnf9H8kN0tneKIP/iTlj+Pq7/zBYloV/lrXM
	dE5F6MGCMhVQYuFjfJcOHIR/E4iKOx22lEDWqBFwO/USXchoMow6hxr62kXuXErrOukO8iYgIxS
	iqgCNgBXySKVEe6r53YYXkAa4iS58ZqBczeCnF9h8OTcpMQe5PitNgQ8vb/tJX2TTifoW7RgqTc
	+jvdc9Wvsp6sZTqWtnBaQ==
X-Received: by 2002:a05:600c:5392:b0:495:48d7:f178 with SMTP id 5b1f17b1804b1-4998795d6bemr97219905e9.11.1786717013727;
        Fri, 14 Aug 2026 07:16:53 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-499899753ccsm36764805e9.0.2026.08.14.07.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:16:53 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net] net: bridge: vlan: fix inverted default vlan notification
Date: Fri, 14 Aug 2026 17:16:40 +0300
Message-ID: <20260814141640.64958-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A notification should be emitted only when the vlan delete was successful
and not otherwise. The proper check is if br/nbp_vlan_delete returned 0.

Fixes: f545923b4a6b ("net: bridge: vlan: notify on vlan add/delete/change flags")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
Found this issue while preparing some vlan code cleanups.

 net/bridge/br_vlan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 31c1b2cf75d9..1e0e436629ec 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1136,7 +1136,7 @@ int __br_vlan_set_default_pvid(struct net_bridge *br, u16 pvid,
 		if (err)
 			goto out;
 
-		if (br_vlan_delete(br, old_pvid))
+		if (!br_vlan_delete(br, old_pvid))
 			br_vlan_notify(br, NULL, old_pvid, 0, RTM_DELVLAN);
 		br_vlan_notify(br, NULL, pvid, 0, RTM_NEWVLAN);
 		__set_bit(0, changed);
@@ -1158,7 +1158,7 @@ int __br_vlan_set_default_pvid(struct net_bridge *br, u16 pvid,
 				   &vlchange, extack);
 		if (err)
 			goto err_port;
-		if (nbp_vlan_delete(p, old_pvid))
+		if (!nbp_vlan_delete(p, old_pvid))
 			br_vlan_notify(br, p, old_pvid, 0, RTM_DELVLAN);
 		br_vlan_notify(p->br, p, pvid, 0, RTM_NEWVLAN);
 		__set_bit(p->port_no, changed);
-- 
2.47.3

