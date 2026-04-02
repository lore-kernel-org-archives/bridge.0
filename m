Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0721D3BF67E
	for <bridge@lists.linux.dev>; Thu,  2 Apr 2026 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775138569; cv=none; b=HKKd/z2CRTxjxchCuruJRzkuXPvex7ZtbLTA7xhmDByIvL4NLkLsGpB4DvpCHLgstlKvuV3ydhTLtTHipwKPc1/zPF2zJDpzBTv1rq8EJx/uLT2mUAEI++mB2XO2JTcaaR7xAXO4kbJlVhD9CW4L/GV6lXmuFrABFv/jf3reyJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775138569; c=relaxed/simple;
	bh=QuDJlFmHBgvStEeocMY+izf+6lwz4dximZB3hxaYZr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M1ZAnSe8gUEyycv4OuN7wry3lwzaB4/f8J2RQe6lrynMemMwL9lGR6SRZdcbRkR+6zP5TgjLH2fPKJrHUuwek/lgRjMqNNQVtC3CijmuF7YjNWEGu5y/ECfCJg8gikuBQjHvzGnzWBuDUyYmFXJZJI5EYhjaPkwF77LKl6aZpnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwDdJOGH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwDdJOGH"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48371104ffdso978075e9.1
        for <bridge@lists.linux.dev>; Thu, 02 Apr 2026 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775138566; x=1775743366; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fjebN745cPTznKlBAtXhIYhg+ckfnG5/mIokgKeD9ZM=;
        b=lwDdJOGH8csA7gGI6WfPSLaqHP106goOrzCv6V74djDqB6ssvApaqv1CqR1uiMCi2U
         cKgylnHjQlywh7XIDG5OyGkqemluOdKurvR9P6MtfxRsywZqjMTbEkxqXrmYEGpcgNTZ
         6IQgmt8gGmpLPl/ntoXjkvgvjEyEa5fQasD+cIEIsRUYBl+CNEuZzhrR+p4CV7ylxOJv
         un4m/gj4MZ1BPo3ee4fCXLJEGpphRas5RyEzO0g6HLsGu4+fuxzvGb/kES8MP2tJSw4S
         1g+UaA9mbPi2S8O1banWoplx4ouYEeZEAQL5Ns8qSgLOeayBsT0/PhzHcUBq2GgFehoD
         sSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775138566; x=1775743366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjebN745cPTznKlBAtXhIYhg+ckfnG5/mIokgKeD9ZM=;
        b=oJwWR5BOTUCbvFZ2IJqzbGcXgZcDazgEBYgvKjsXlKIp5hiWPCKlY21bbjY8cEV13W
         zHsT2r7Idgi38MyhAHPb7PQFqKmd67mqV+uguidH68TeHXqWn0bC1p5zJCXIDl4jZLng
         HgTqAmm534B2WrSClBxDCUcUTNWFCcetfFsDzzJlpKESwPeVMAIO8El2qhy1ljFb9+Ra
         HNDZ57AXfhOji/WSz2R2bY4f/w6Y/XSxKnc5UYCcrIu4GrciJSM4LA6np4Y42hSzKeaT
         U/NSPXnQFPr7Oalm96P33aNJTA+qIAAuYQl9On8T3p+8/+o97dsfy6tXw3HzIcPre1ET
         FWgA==
X-Gm-Message-State: AOJu0Yz9FWHmvaCmR2MhzoOA6z3IR6qMkP4s5DJEgX/HkZ9COjU3HCtL
	cF0TzLY6mQjdUvXAtkKwRbSEnv4g5Laf+3t8FGnGl/kFT6ngDJxSHHGl
X-Gm-Gg: ATEYQzzt5ijs2VcmN5Pb+sMg18pCntth16ipE9AQ8SjVWUReiMWn3IJvPi/x004C6m/
	m5A1qAsRv5/hCcJV0pX89WkZokOvGn+XZIrmU65bx8/yt19EaAVtxwx4jTbJ4FH+zY+UHhVARxq
	v0Jw++p/EHre8aSECAdMdSpeuhO8hdAJY86ewxKXuEVgsqnh72hE4+qIEMysdLJpoWbrly9Lc32
	KJapJu6KddHbdCvEJwemqVgI3XJhETnmkmidzv+ZXt0CIG8ldd1JTJxJb+Wob18nBeqlEQH3iga
	y+2l3/wwkjf14nAIoAQyhkKqYiXZ7qDZTjwvsIbDiArdiyFsPsi+T7SKoWwCRFN/0XwrUkuDPad
	bRS2MJuQcoP00SyfR+QREKBB8EqiVfm81HPpJxNtme6AvNN0ojPa+S1z/4pDAj/kRP+sadMxq0J
	F1Wxw9Qb6e3qsRtA+8JYEyAS9yf0cpx5HJrLrLz4QKkxRhg5c/z5P4aetKA3hvI9g7bGE1J+4qc
	tt3wJs=
X-Received: by 2002:a05:600c:474f:b0:485:3fc3:e8e9 with SMTP id 5b1f17b1804b1-48883592bf9mr79660525e9.3.1775138566110;
        Thu, 02 Apr 2026 07:02:46 -0700 (PDT)
Received: from ast-epyc4.inf.ethz.ch (ast-epyc4.inf.ethz.ch. [129.132.161.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e1fe0b0sm7683269f8f.0.2026.04.02.07.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:02:45 -0700 (PDT)
From: Zijing Yin <yzjaurora@gmail.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Zijing Yin <yzjaurora@gmail.com>
Subject: [PATCH net] bridge: guard local VLAN-0 FDB helpers against NULL vlan group
Date: Thu,  2 Apr 2026 07:01:53 -0700
Message-ID: <20260402140153.3925663-1-yzjaurora@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
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

Bug independently reproduced with the attached C reproducer
(repro_br_fdb.c). The crash triggers deterministically on the first
run with CONFIG_BRIDGE_VLAN_FILTERING=n on a clang-built kernel.

Exact crash signature from reproduction:

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000056: 0000 [#1] KASAN NOPTI
  KASAN: null-ptr-deref in range [0x00000000000002b0-0x00000000000002b7]
  RIP: 0010:br_fdb_delete_locals_per_vlan+0x72/0x3f0
  Call Trace:
   br_fdb_toggle_local_vlan_0+0x3d/0x1d0
   br_boolopt_toggle+0xba/0x1a0
   br_boolopt_multi_toggle+0x129/0x250
   br_changelink+0x1100/0x1490
   br_dev_newlink+0x115/0x190
   rtnl_newlink+0xe15/0x25c0

Note: gcc 13.3 with the same config optimizes away the NULL dereference
path (UB elimination), so the crash does not trigger on gcc-built
kernels. The code is still incorrect regardless of compiler behavior.

Reproducer (C source): [PASTE_URL_HERE]
Kernel .config:        [PASTE_URL_HERE]

To reproduce: compile the C reproducer with `gcc -static -o repro repro.c`,
run as root on a clang-built kernel. The crash triggers during
br_dev_newlink() -> br_changelink() when the boolopt toggle reaches
br_fdb_delete_locals_per_vlan_port() with a NULL vlan group. Note:
RTM_SETLINK on an existing bridge may not trigger it due to different
code ordering.

 net/bridge/br_fdb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 0501ffcb8..e2c17f620 100644
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

