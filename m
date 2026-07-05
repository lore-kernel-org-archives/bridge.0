Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54003016E1
	for <bridge@lists.linux.dev>; Sun,  5 Jul 2026 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783288698; cv=none; b=UiZ0/nkWDEVYmEgV+qBNzE7vNoaG8Jx08kJbD40pkE77YfiWVX9N/cPysR9o1b724QYreYARU8gYoGb2uQ97MXwc8VAi4s1/G4tOwiYV40VDq79HtU/QXar2ZSbzLXLAVyCGJu7nPZTm/oWCZFoKpMTj/BBcJ2am8fIf4FtNqXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783288698; c=relaxed/simple;
	bh=fsLQWYx9S7rh9aWQvUIiOdoCnDPWNE+xTofZODHUeqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UPDi8mF+w2XGgEy+JAQi1CC+uLL9/W/3LEIWqJ1p+27Ke9QRJdUO6A9l/mq9uCcgBkqRTdG+5ZoDqI7whtcp8oNTFWYWfyQldPmuM6jxDFpASoVy9b7PR5OQ+gA8O75JnCiUCzXhLxn+fuw8v/rAEWUnC6wxnKD6/n1Pil3Jh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=RAjIvHZJ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="RAjIvHZJ"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso1164084a12.2
        for <bridge@lists.linux.dev>; Sun, 05 Jul 2026 14:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783288696; x=1783893496; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=utKDtKTqMmc6gZ7doveiePDIjTFwLL4HY/v+gdcdSqY=;
        b=RAjIvHZJ+yTrjQEwlQYswoOs7LbiD7L3vVJOQzRYX9pecrzg06bBJhiEDkl/WECHnQ
         IWB38kxYbqoZfBKBJyGqs93AgzxWqqfssJZgHFdFQznE9JhSPUMXhKN6rk8ijq+RuZVK
         WOL8IXUlRfxbfXaUNxCHzoCjsbwhkAP66njaEOSYbKBNwzn0Pc3zRwi9CkfSZI88oHAQ
         msemXPsYZkDU/rwTVvBsVktO5ub1ATCyYDti4yxizBp14cz0LxViKTKPcyHhinHFiCEw
         u3lWGbaZRYytv2s2XV+QS6EMfkzzh3bWRSALz9uBiy6tBnv5jmlBTfCUsOx4LBZJ1w0s
         KN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783288696; x=1783893496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=utKDtKTqMmc6gZ7doveiePDIjTFwLL4HY/v+gdcdSqY=;
        b=Chsm51HGD02MGMdaSDJ/Ex6GsAlsCgPCSWq3/o5KfY+bdolQL9MLTedhFzurQnjK2/
         WjP1iM//6JpJh+7lKTeWjw6s6idZod/SD9KsF678uWpAlNAGhR3jPVCKxjem/egrWlqd
         if+TU6Rs4GdZnjqNVKIAP7ir6wTq6tATMhmj7LVN70mkWRpm/U0kW7fIkLO8KjHeKIQx
         GDJgkokLDtHgsCbDcQ+9J8FfXtCLEYP8Z6StuZ6Kw9UKq2Jp7tvLJQBQAXIbg5k9V8UL
         PsVxcFwXD71sSwHslGk006Zdwe9gS4k4q3B2Riq+9CcfLQ6l0ERqc2sl4W0Xhzan6T8Q
         l78A==
X-Forwarded-Encrypted: i=1; AHgh+RpD9XpCY/UEouKLF4jUqbIKTkFNvVZ+SU4kixnK1mKJOrqQSEAvCi93h7tiAdMmD1A+WUO6EAA=@lists.linux.dev
X-Gm-Message-State: AOJu0YySvIomkFoj68z1bMo9NyWMYNodRHR5qSsAYdiAio591do8yFcK
	BxIWe3q922W2Cqfo9S7qQu/kd9MascqqNHNWbjtC0TISJ2cexkzZeNrAy1UvYxscMw==
X-Gm-Gg: AfdE7cni1+L1cP56HrLE/zAJ66TT4nMEWrzYKTUuTCvpyWXhT3dGcrmAsClm/bcm0K0
	M8ll8vcmOlGklaiarLODsjdlLd+EEWJm26Wdxbwv+KYeIuTqe7GiNBIuc6bGxZRIKdziBC89E2L
	YgV5gtHnSHALJ4ILddK00fKMT6JtvYc4c5Womz8//Q9WGTEuNYvFanyNrCg4RMHUWu0EnZfi6hp
	db/i6lubM2j86gnKaR2HRICVHI++4QmGCTVfSZqidRr4vnvFPwHERcQwI5vAEefBb/4rlVvnyIl
	WW47rBbSDdbWNJtI7U4YRlrLzs936TJI5r/Oy4Oakk2jfaz+rQP7XeHqns5mPAlITsJ1nKtnLe0
	K5KjHi1q+79zOXjxwtzzKgo2npCfnvxFHVAbSrmEDCowjjM1iJgjhZr9qGI1rkwkBionIQJY3Xu
	T6L3FYJFVW
X-Received: by 2002:a17:90b:510e:b0:37f:133a:3e09 with SMTP id 98e67ed59e1d1-382803b483amr7241574a91.3.1783288696081;
        Sun, 05 Jul 2026 14:58:16 -0700 (PDT)
Received: from p1.. ([2607:fb91:152b:9c50:23c1:1e1c:319e:7007])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38097da1a0fsm3210495a91.2.2026.07.05.14.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 14:58:15 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH nf] netfilter: ebtables: terminate table name before find_table_lock()
Date: Sun,  5 Jul 2026 14:58:00 -0700
Message-ID: <20260705215800.2223145-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update_counters() and compat_update_counters() forward a user-supplied
32-byte table name to find_table_lock() without NUL-terminating it. On a
lookup miss, find_inlist_lock() calls try_then_request_module(..., "%s%s",
"ebtable_", name), and vsnprintf() reads past the name field and the
stack object until it hits a zero byte.

  BUG: KASAN: stack-out-of-bounds in string (lib/vsprintf.c:648 lib/vsprintf.c:730)
  Read of size 1 at addr ffff8880119dfb20 by task exploit/147
  Call Trace:
  ...
   string (lib/vsprintf.c:648 lib/vsprintf.c:730)
   vsnprintf (lib/vsprintf.c:2945)
   __request_module (kernel/module/kmod.c:150)
   do_update_counters.isra.0 (net/bridge/netfilter/ebtables.c:371 net/bridge/netfilter/ebtables.c:380)
   update_counters (net/bridge/netfilter/ebtables.c:1440)
   do_ebt_set_ctl (net/bridge/netfilter/ebtables.c:2573)
   nf_setsockopt (net/netfilter/nf_sockopt.c:101)
   ip_setsockopt (net/ipv4/ip_sockglue.c:1424)
   raw_setsockopt (net/ipv4/raw.c:847)
   __sys_setsockopt (net/socket.c:2393)
  ...

compat_do_replace() shares the same unterminated name via
compat_copy_ebt_replace_from_user(); terminate it there too so all
find_table_lock() callers behave alike. The other callers already
terminate the name after the copy.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 81e675c227ec ("netfilter: ebtables: add CONFIG_COMPAT support")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/bridge/netfilter/ebtables.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index f20c039e44c8..5b74ff827493 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1434,6 +1434,8 @@ static int update_counters(struct net *net, sockptr_t arg, unsigned int len)
 	if (copy_from_sockptr(&hlp, arg, sizeof(hlp)))
 		return -EFAULT;
 
+	hlp.name[sizeof(hlp.name) - 1] = '\0';
+
 	if (len != sizeof(hlp) + hlp.num_counters * sizeof(struct ebt_counter))
 		return -EINVAL;
 
@@ -2273,6 +2275,8 @@ static int compat_copy_ebt_replace_from_user(struct ebt_replace *repl,
 
 	memcpy(repl, &tmp, offsetof(struct ebt_replace, hook_entry));
 
+	repl->name[sizeof(repl->name) - 1] = '\0';
+
 	/* starting with hook_entry, 32 vs. 64 bit structures are different */
 	for (i = 0; i < NF_BR_NUMHOOKS; i++)
 		repl->hook_entry[i] = compat_ptr(tmp.hook_entry[i]);
@@ -2395,6 +2399,8 @@ static int compat_update_counters(struct net *net, sockptr_t arg,
 	if (copy_from_sockptr(&hlp, arg, sizeof(hlp)))
 		return -EFAULT;
 
+	hlp.name[sizeof(hlp.name) - 1] = '\0';
+
 	/* try real handler in case userland supplied needed padding */
 	if (len != sizeof(hlp) + hlp.num_counters * sizeof(struct ebt_counter))
 		return update_counters(net, arg, len);
-- 
2.43.0

