Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093871E863
	for <bridge@lists.linux.dev>; Mon, 13 May 2024 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596502; cv=none; b=HvnJBPO2iA3KkHelYf2CLAaq8mb2cRQX06sduS7Uht9FCWC7bxcJgQCTh3GTkf1tL9BBfI1hzjKcfWQNETTjhjAvUdO8ru3tDrjcDW5FeY1qLzO9mwpcOHiYd+vjBkFX1kl5mF4IjFdUcV3Mrs1ZPsJwKN9nAlEQT41tSP3+/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596502; c=relaxed/simple;
	bh=iCMDWFPKRtQ+gVx4a6GRTIbskiAp0YKEDhVSfmxdfms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uARzOcacgX0N03PSs5LFwMO2Ec29ajFpXpDEJNIBHHzlr+8rd6XlY0EVuNnLdH0yEoAZLcmT33LIQov0dikCIHvGPCjSUuIPjMBh2rAXOUtnW/iEM4I8JRcmuSKKy9dbhpMnGaN6Ea9AUkjf/MiP1gyA4Fa1G9fkBYrPvEGtqew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=pLVQVIc9; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="pLVQVIc9"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34d7d04808bso3218186f8f.0
        for <bridge@lists.linux.dev>; Mon, 13 May 2024 03:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1715596499; x=1716201299; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJpZYur1p+9mHWIybbm1nY5msF6SUb/keLogygdo/fg=;
        b=pLVQVIc9rAR1Jryr+5sAggQfvZFJVhpYbZ8zcgul4FYhaFgL1+YaM2c0/6GtXlNioS
         H6fwY5vEc9uqaEy6DgwgM/uQoZJtNVIXumD5745S1wBKCx/SM1Z1mukN7dQSpSWsQAOP
         iwS/5v/VxvOMbnk5fLdHgOzqGI5iKzHKQNyaB/91CTFWD4NQxZcU7GTgPyxCSKGaGrmc
         YuLREHUPyOG0p52DylEnMe1HSCwUh5MpEjzka7Yjx1GlQZhunuw7rO1IFQTaBGrPqqlt
         KOJVQzmX77GcoSi9jh/RQ3n3GsyS7qahEV9bDe3G8NQqGYnl/Q7xrtaTGbgFPPZZiIWy
         a7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715596499; x=1716201299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJpZYur1p+9mHWIybbm1nY5msF6SUb/keLogygdo/fg=;
        b=sgsOnC95JuIkul89GeDIN0H4dwkwRPh6PdIMYSihyhGJleun1bfCNQb5/qFSLS9+H1
         +qodIjFlHxyZN3GNSHAtmwWQUAzhQV/JuVgvHAJrS5ig7hJIiAY1VqQRjcGmElyqbZXc
         nbZAYfFuOSDwVFTPso+Nw9FbzvLX9Pywz0uAP/0Gz6bOxM/QX5aXbRqc2t5pl81C75wt
         bJv0Hz7Nq1t7EE4auEYZ1WG6AeeZiCy2hRNNbCdw7k9gRUom2y++cwCSj9XkSqi8UIQG
         mIbVeGHGjCOXa/z7nxCjKRLVZvHiATzXx98WEYwxV28NhXn0bXis1CQqxI/8FHBYLxDw
         qkdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS0oiibRyauaJJiWT4KCqqDGQpXScFgwJXbiD7MuoECX01uXDLYYUgnB+x50TcP8hLpqXpKrU6/7u3rFwf2ZpIXI06P6Mh
X-Gm-Message-State: AOJu0YxbOp9gqFn0kPhXyTij4K+EtNPNQQXYljdBXpiYCSqTiXzIv4UD
	3a+OohthNtAk0MLUCDBAg3EovjOoGZUjLxWtC0tgRExlLAQW2sXMfeqJfRvjkY4=
X-Google-Smtp-Source: AGHT+IE+dY+sdj7gbM+JjmYQ/ss0dGgWFUyv8QeWV15g9mYYd/tPpbQ+LwuVLLv6QGLJYoQrlnzoIw==
X-Received: by 2002:a5d:5490:0:b0:34b:b50:3689 with SMTP id ffacd0b85a97d-3504a61d261mr8758653f8f.10.1715596499125;
        Mon, 13 May 2024 03:34:59 -0700 (PDT)
Received: from debil.. ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bd7asm10714578f8f.17.2024.05.13.03.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 03:34:58 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: roopa@nvidia.com,
	bridge@lists.linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	Nikolay Aleksandrov <razor@blackwall.org>,
	syzbot+a63a1f6a062033cf0f40@syzkaller.appspotmail.com
Subject: [PATCH net] net: bridge: xmit: make sure we have at least eth header len bytes
Date: Mon, 13 May 2024 13:34:19 +0300
Message-ID: <20240513103419.768040-1-razor@blackwall.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <000000000000d4e70506183d374d@google.com>
References: <000000000000d4e70506183d374d@google.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot triggered an uninit value[1] error in bridge device's xmit path
by sending a short (less than ETH_HLEN bytes) skb. To fix it check if
we can actually pull that amount instead of assuming.

Tested with dropwatch:
 drop at: br_dev_xmit+0xb93/0x12d0 [bridge] (0xffffffffc06739b3)
 origin: software
 timestamp: Mon May 13 11:31:53 2024 778214037 nsec
 protocol: 0x88a8
 length: 2
 original length: 2
 drop reason: PKT_TOO_SMALL

[1]
BUG: KMSAN: uninit-value in br_dev_xmit+0x61d/0x1cb0 net/bridge/br_device.c:65
 br_dev_xmit+0x61d/0x1cb0 net/bridge/br_device.c:65
 __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
 netdev_start_xmit include/linux/netdevice.h:4917 [inline]
 xmit_one net/core/dev.c:3531 [inline]
 dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3547
 __dev_queue_xmit+0x34db/0x5350 net/core/dev.c:4341
 dev_queue_xmit include/linux/netdevice.h:3091 [inline]
 __bpf_tx_skb net/core/filter.c:2136 [inline]
 __bpf_redirect_common net/core/filter.c:2180 [inline]
 __bpf_redirect+0x14a6/0x1620 net/core/filter.c:2187
 ____bpf_clone_redirect net/core/filter.c:2460 [inline]
 bpf_clone_redirect+0x328/0x470 net/core/filter.c:2432
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2238
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 bpf_test_run+0x499/0xc30 net/bpf/test_run.c:425
 bpf_prog_test_run_skb+0x14ea/0x1f20 net/bpf/test_run.c:1058
 bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4269
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5678
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5765
 x64_sys_call+0x96b/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+a63a1f6a062033cf0f40@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a63a1f6a062033cf0f40
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index c366ccc8b3db..ecac7886988b 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -27,6 +27,7 @@ EXPORT_SYMBOL_GPL(nf_br_ops);
 /* net device transmit always called with BH disabled */
 netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	enum skb_drop_reason reason = pskb_may_pull_reason(skb, ETH_HLEN);
 	struct net_bridge_mcast_port *pmctx_null = NULL;
 	struct net_bridge *br = netdev_priv(dev);
 	struct net_bridge_mcast *brmctx = &br->multicast_ctx;
@@ -38,6 +39,11 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	const unsigned char *dest;
 	u16 vid = 0;
 
+	if (unlikely(reason != SKB_NOT_DROPPED_YET)) {
+		kfree_skb_reason(skb, reason);
+		return NETDEV_TX_OK;
+	}
+
 	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
 	br_tc_skb_miss_set(skb, false);
 
-- 
2.44.0

