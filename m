Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792F328468D
	for <bridge@lists.linux.dev>; Tue,  7 Oct 2025 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759824955; cv=none; b=ZaVtNV1vjMpdXu8F3+2ZhxYbueJSX8ZHCoufXW3WGcz87lT79UFqXaWA48mQLCNiPeVt5dM0Lee1BHCn2TpdfmIJyRapr1fxQwalpvqtkNisPZqrBmtelu+DydoAXSe545Qs/0xfI+KZ7QCZs82EPi+1tpzi76lh6oVcoh74lPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759824955; c=relaxed/simple;
	bh=cPnv7w2X0stTQnku4HMN5Ut9YFp+W6zl1F8RwXMzF3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z9uODSxwSiPhWFmWZ4iVG6TJjekgdKfguHwQJYVm0t5eX8oz4yTC9qa1DissGbLZOH6hXlzriIYIQ8mWZrAnwn/hsUYBUHZYUsAQPUTQqSP1vo3EuwO96LTGDDQ8TtmM+itqZWnIjocwB091tEuVAYpmIr1rmR7j6NFJ6dJ9ohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgNJXASu; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgNJXASu"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b256c8ca246so1206069766b.1
        for <bridge@lists.linux.dev>; Tue, 07 Oct 2025 01:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759824950; x=1760429750; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qf77yEGo9b9X4Y3EI1g9cCQ5ukTIt05Cnfqv6X1CMII=;
        b=PgNJXASupl9Holn2IzGhJudjIxSpww4eQYX3FXdLaKECRJfFmB40GRO0bmKN0VquBp
         IQ4sERTShH7iRJVPdNi6pXmnHYOEimmZEBbEna6XoDIfdErkaigeF1CZXnOAg0K/BTbN
         broO9wD8uCUema0nBKFLql2MnlLUUa3aq5oT2vzmfx+z6ce/uJI4vHGPmEssBZySTJrP
         CPIJ1ZX2k+FDTI08KG9iGVNS+5Mgh0WjoDIJ5Mk9+gcdCOdjgD6EALduYJYWAVZzHH2P
         wn8hD3uDfZQFEzx8AJuUVZ9W0lLFQHiVUZxoavemBBpOolnulBIRiIGz6nyTC6LpEeSs
         yc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759824950; x=1760429750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qf77yEGo9b9X4Y3EI1g9cCQ5ukTIt05Cnfqv6X1CMII=;
        b=f5ciG+Bv2qXSFOCZLMZ5fCZMN8Ekc7pKqvdwpQgyu4jdHAooEZ5XFw+8dgRDFxSOc3
         W4XYFHiVMDhvbalxb44wet8buhK+uyOYzD6Xe4gw1s3bWbFKTX2PV+ZT4Jr8djhybJUs
         l6f1mPJ6EAoThpPbpaNqgyy3Uy2wZQBnJveq855Um1LthdEAUb/a278FoL9FOnMhSfoY
         HNrvhfJO+v3scHXNSmbRHWKTfAkuRXgqyfDL1Wjy3Naks6RxohWk6xogADoaQTJddnZ5
         GBvTVxN3NeZ2aJrTGdS26cwl/jk5ajRgZZ33/Wib62c6ptB8+Y5OXk4CB8/2pd+gVWAi
         fa6g==
X-Gm-Message-State: AOJu0YxWr1n0WJqX/N3NNMVS+HDKGFzCP3FxUIQYYQCfu6+dx9TT4B8b
	TalV41RpfSw2aHMziHMLg3Rt5Kt8CHqTXcOh/88KQlGAV99dhGx1/sv8
X-Gm-Gg: ASbGncu9YYAk+TXmStmA3gwnqpzRffAkHbOFu/Yeqb+3uM4G/rj6BlSAPWKZA3cUgCC
	/rarbDhDFfUaHD9LQDuoo8ltoGXMTDpbjUM3Kdns6xxZTQliX574U0dzg/HqowqPUZyVDBGxVEu
	Mrv+0rOEjFrQnMlGHr1EvhHNHUbMEi6aNY7RXppgXdcXF1WcDSY8addODzhgGAy5Nxlk4kLh5bx
	sX4VsL5vikhF9vH+b27HTHW46F46csKN35ZNKEEypn0JBFqqgBsKU2+Ok3xpPGeTfTLscsbb1zG
	KNyVh4IRIX/RtYauyljkVaj79Rs2Jj5mWh4JJIjMYoEruhIGwfnQguCr2iGfLdWt3uCU1bRsJtq
	ydvIlnIYI4/AWcla58DOFAIRqeuSW3bkp8Hh8Vv/5psspot433m1ZoSikY64mCAN4Kft3QmlGKi
	6MBGx5Ak1ngUitKfZZ03bvAE68igtqvpZIRGuuXxCEjw==
X-Google-Smtp-Source: AGHT+IFg16oZZSoScCoFNVXKIhQVbb07lghOlKOqecH3B4hiCjRVmKapplUwUi60y/itXKHUx8ALVg==
X-Received: by 2002:a17:906:6ad2:b0:b4c:1ad1:d08c with SMTP id a640c23a62f3a-b4c1ad1d71dmr1040646866b.17.1759824949562;
        Tue, 07 Oct 2025 01:15:49 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4f7eacdfe6sm121313566b.27.2025.10.07.01.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 01:15:48 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v1 nf] bridge: br_vlan_fill_forward_path_pvid: use br_vlan_group_rcu()
Date: Tue,  7 Oct 2025 10:15:01 +0200
Message-ID: <20251007081501.6358-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bug: br_vlan_fill_forward_path_pvid uses br_vlan_group() instead of
br_vlan_group_rcu(). Correct this bug.

Fixes: bcf2766b1377 ("net: bridge: resolve forwarding path for VLAN tag actions in bridge devices")
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

---

Also see the debugging info send by Florian in mailing:
"[RFC PATCH v3 nf-next] selftests: netfilter: Add bridge_fastpath.sh"

net/bridge/br_private.h:1627 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
7 locks held by socat/410:
 #0: ffff88800d7a9c90 (sk_lock-AF_INET){+.+.}-{0:0}, at: inet_stream_connect+0x43/0xa0
 #1: ffffffff9a779900 (rcu_read_lock){....}-{1:3}, at: __ip_queue_xmit+0x62/0x1830
 #2: ffffffff9a779900 (rcu_read_lock){....}-{1:3}, at: ip_output+0x57/0x3c0
 #3: ffffffff9a779900 (rcu_read_lock){....}-{1:3}, at: ip_finish_output2+0x263/0x17d0
 #4: ffffffff9a779900 (rcu_read_lock){....}-{1:3}, at: process_backlog+0x38a/0x14b0
 #5: ffffffff9a779900 (rcu_read_lock){....}-{1:3}, at: netif_receive_skb_internal+0x83/0x330
 #6: ffffffff9a779900 (rcu_read_lock){....}-{1:3}, at: nf_hook.constprop.0+0x8a/0x440

stack backtrace:
CPU: 0 UID: 0 PID: 410 Comm: socat Not tainted 6.17.0-rc7-virtme #1 PREEMPT(full)
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
 <IRQ>
 dump_stack_lvl+0x6f/0xb0
 lockdep_rcu_suspicious.cold+0x4f/0xb1
 br_vlan_fill_forward_path_pvid+0x32c/0x410 [bridge]
 br_fill_forward_path+0x7a/0x4d0 [bridge]
 ...

 net/bridge/br_vlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 939a3aa78d5c..54993a05037c 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1455,7 +1455,7 @@ void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
 	if (!br_opt_get(br, BROPT_VLAN_ENABLED))
 		return;
 
-	vg = br_vlan_group(br);
+	vg = br_vlan_group_rcu(br);
 
 	if (idx >= 0 &&
 	    ctx->vlan[idx].proto == br->vlan_proto) {
-- 
2.50.0

