Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8E128150F
	for <bridge@lists.linux.dev>; Wed,  1 Apr 2026 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775058544; cv=none; b=mo7TEftlfVHgje9E1aFGZXRZj8ILDodCkZKdGE3IH6O3neLRix9ZJmQM0n+5wHv/kcfhdnPmK4FqcfKniprbZpOICWbn3Vm+jdtdt43nMgqc04OPvq8ZZffblz/UC9TBEVvfS71MzyAi2uu1oQfx6khxuqcPnnwm7Jh71JelPJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775058544; c=relaxed/simple;
	bh=kwqZqSHyhMEFq3zIeMyxlIPbqt2vUdc/6TijX13GaHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YAaejOsSBKgKnnK1NL7crSznh8r5TThJBZRetpXUwg5VmIepFdEfpR3iU5zphSMqRw3VwbwOAKFL0QDzTxX31WwAe8Dxku7ghfqiQfqGLb3sr42GwLayeqNBBv+xWxhRcSZw4dqsmPSTCWp/uBTN53GXYojB3J1M/ag1Cu+Y4rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Il8f95Fe; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il8f95Fe"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4853a5ffc05so15076365e9.0
        for <bridge@lists.linux.dev>; Wed, 01 Apr 2026 08:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775058540; x=1775663340; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=50fzfjsSVKBt8ZoaICP31zyxkLKQdtthMhX3pC/ytMQ=;
        b=Il8f95FedjlURP8gVamwYhqRpWNcIqnxSvZDo7S5xMQPwIQNSIBEvTQ0czGB2zBfnP
         sHd77HqbogFbWhOu0U21CzMKi8+P9gA+rO+PTcIZSatYnnPKVYfsE0qTDIpFThzUiLHI
         t2GmBbsg649zAypvVZskgLos1Q8gMCODSgVLQ4pXj73xek7nj/6VzkXClj65lwp5aCWS
         LtdSRqMaNew9b7kpO4RkagQnQ2VcvTQiJAn2iupXDCXfoOY10YRxxPcI0BkjTIVTqVU4
         0LwyHjlxX/XTkQnbEHRe7lv4QEd/NLfwWpB+KP9fjlRrMWdI4ofUyEKhbA7xtr4kf1ZI
         2JIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775058540; x=1775663340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50fzfjsSVKBt8ZoaICP31zyxkLKQdtthMhX3pC/ytMQ=;
        b=WvANrSeGMy7hueaUceCj/MORrx5VRhG9pk+0ELT2Jb9ARH3Nkb9UMhWSHTey6MmnoP
         7Mq4czfBQwnMfqC5JoxGWyU+8t4DnQ9GWQgjvE8q2yOQlUsLqLBOES9pzD6u/Yc/YKlr
         K6Oz0aDYc/rE7wEzSHwwJgrMeZVi9k9rVlXbbggvSU/iOh/vthXFdZqcn0C2I/dCNKSG
         dDmy/53gjgU/RLBRRrsy8OK/TGc7Q9HNtHfJ1uh3DrDB0UcI1N7zB6JYdNBE4ZEi8DZX
         mmgoD47rtH5mMaIMJeZEheqRkpJ6A6sprSTDYF+/JfhmdKjzZg+ERLv0+SfV1t3ak41l
         /JXg==
X-Gm-Message-State: AOJu0YyVBPeVUEW8fR2yIIyO1q4hrnYzl+bSFKXFF6HkTXoXytF9rt8t
	37HFclSmVFeLMAoN2TMWVVTb+/YCeLROJp+JlUsLf74Rl/eoL1yDqGMi0luZsfinlxg=
X-Gm-Gg: ATEYQzxGvsvHzXbWrglPKZa5wLQUpxHUXfY6v9ctlT89erEKiZhrgNjC0nD3sPhF0OX
	3F6oxo7vkxF87jIOxPeWYBzqItYiQOutQ+EdaLUX7Ut+o5rH+sv7WaNsaJrrMmEzdc3J7PcsdRx
	GNTSGjHN0mxynIp6PWsftT7DucaOv2tIxdBdud8xI1OH9SRuoDqMVd0MLR7K6Q3TJOLeUoxmW7H
	pUTpSC8DNw99h7nqrtvZUtKBhZB+2H49/4BjumD27ghg+2pGZHbn4Jjo6zF64gtIIdKqUbRqbf1
	DVyLTg/QDJ80JmiL0/az9mKh3pYZIRR3me1J3nJULJBB8Vqaiw8S9h7DTjuIFINB1uQCfyizvH8
	+5YMyvz2l9+e0m5uxjaenMJdNV+LWQJMkpiY9yl5kVpm2a7AaJHmhH1oIKogTTXvKPPyx+MKoQI
	453orTNG+71lclevDQAf1Ans2ber5yZhU34+QBycADdYYidKlTgTBK4p+mtmW65/oEMOyAzGL7i
	hszWw4=
X-Received: by 2002:a05:600c:474f:b0:485:3fc3:e8e9 with SMTP id 5b1f17b1804b1-48883592bf9mr42497045e9.3.1775058540309;
        Wed, 01 Apr 2026 08:49:00 -0700 (PDT)
Received: from ast-epyc4.inf.ethz.ch (ast-epyc4.inf.ethz.ch. [129.132.161.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e952b0bsm114043595e9.12.2026.04.01.08.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 08:48:59 -0700 (PDT)
From: Zijing Yin <yzjaurora@gmail.com>
To: bridge@lists.linux.dev
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Zijing Yin <yzjaurora@gmail.com>
Subject: [PATCH net] bridge: guard local VLAN-0 FDB helpers against NULL vlan group
Date: Wed,  1 Apr 2026 08:48:24 -0700
Message-ID: <20260401154824.2905980-1-yzjaurora@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email
Content-Transfer-Encoding: 8bit

When CONFIG_BRIDGE_VLAN_FILTERING is not set, br_vlan_group() and
nbp_vlan_group() return NULL (br_private.h stub definitions). The
BR_BOOLOPT_FDB_LOCAL_VLAN_0 toggle code is compiled unconditionally and
reaches br_fdb_delete_locals_per_vlan_port() and
br_fdb_insert_locals_per_vlan_port(), where the NULL vlan group pointer
is dereferenced via list_for_each_entry(v, &vg->vlan_list, vlist).

The observed crash is in the delete path, triggered when creating a
bridge with IFLA_BR_MULTI_BOOLOPT containing BR_BOOLOPT_FDB_LOCAL_VLAN_0
via RTM_NEWLINK. The insert helper has the same bug pattern.

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000056: 0000 [#1] KASAN NOPTI
  KASAN: null-ptr-deref in range [0x00000000000002b0-0x00000000000002b7]
  RIP: 0010:br_fdb_delete_locals_per_vlan+0x2b9/0x310
  Call Trace:
   br_fdb_toggle_local_vlan_0+0x452/0x4c0
   br_toggle_fdb_local_vlan_0+0x31/0x80 net/bridge/br.c:276
   br_boolopt_toggle net/bridge/br.c:313
   br_boolopt_multi_toggle net/bridge/br.c:364
   br_changelink net/bridge/br_netlink.c:1542
   br_dev_newlink net/bridge/br_netlink.c:1575

Add NULL checks for the vlan group pointer in both helpers, returning
early when there are no VLANs to iterate. This matches the existing
pattern used by other bridge FDB functions such as br_fdb_add() and
br_fdb_delete().

Fixes: 21446c06b441 ("net: bridge: Introduce UAPI for BR_BOOLOPT_FDB_LOCAL_VLAN_0")
Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
---
Tested on Linux v7.0-rc5 (upstream tag) with clang 20.1.0, KASAN
enabled, CONFIG_BRIDGE_VLAN_FILTERING=n.

Note: gcc 13.3 with the same config optimizes away the NULL dereference
path (UB elimination), so the crash does not trigger on gcc-built
kernels. The code is still incorrect regardless of compiler behavior.

Reproducer (C source): https://pastebin.com/YsWAMGa9
Kernel .config:        https://pastebin.com/QMA1Y00i

To reproduce: compile the C reproducer with `gcc -static -o repro repro.c`,
run as root on a clang-built kernel. The crash triggers during
br_dev_newlink() -> br_changelink() when the boolopt toggle reaches
br_fdb_delete_locals_per_vlan_port() with a NULL vlan group. Note:
RTM_SETLINK on an existing bridge may not trigger it due to different
code ordering.

 net/bridge/br_fdb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 0501ffc..e2c17f6 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -597,6 +597,9 @@ static void br_fdb_delete_locals_per_vlan_port(struct net_bridge *br,
 		dev = br->dev;
 	}
 
+	if (!vg)
+		return;
+
 	list_for_each_entry(v, &vg->vlan_list, vlist)
 		br_fdb_find_delete_local(br, p, dev->dev_addr, v->vid);
 }
@@ -630,6 +633,9 @@ static int br_fdb_insert_locals_per_vlan_port(struct net_bridge *br,
 		dev = br->dev;
 	}
 
+	if (!vg)
+		return 0;
+
 	list_for_each_entry(v, &vg->vlan_list, vlist) {
 		if (!br_vlan_should_use(v))
 			continue;
-- 
2.43.0

