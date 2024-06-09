Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2064F1C697
	for <bridge@lists.linux.dev>; Sun,  9 Jun 2024 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717929435; cv=none; b=rmwcCZyOqu5uw/tWfCvmGR7GaJK3QanloFJdLENYUZK/g6TBxedt9wtCg7XAkkQ2s97DGuMZRh3yA+UefKZAXGyJT74agoXGW8Am7hSFswAMgP3ab4rvtGOTFP/qPBrqGS1ya6IEvb3pVtkpLG7zHuiAM4hQ6IcKBEAABoniktY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717929435; c=relaxed/simple;
	bh=L2s03dhFeMytPwGmI5YvhNUtbDtRRLCjBJwQDgtWHJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L20YQvf0/5T1JG1nsOxAuLyn7jZEfIf0NH/3Amfk+CV9CGePeDsLwa5w9Zs5ZnSz6IlYRVpfaodU4r+11LIxWtBHoq6DtL3QQNYrZM9g381rLHlHadlbMroHFSi6Vx10k/wnvH1cM5CoNecoHwac7N/q6sy1tz8OzITxfR+itw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=SCL6iKqg; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="SCL6iKqg"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso5037013a12.0
        for <bridge@lists.linux.dev>; Sun, 09 Jun 2024 03:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717929432; x=1718534232; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUIEGxGg8eY95ds7QR7Av+9t23TMyKmwO6BqnjfUYo4=;
        b=SCL6iKqgq9EbWFnlwPEh19pQMztsP83KLlfJBkBadSeUFt/EctzDS0D2MdB6MERH88
         zkxTeAP/KB9MVSAiyi4ezIU2rAoCVXNccgXdonmMq8pbbED7U/j5V0ZguI0frs8C2w7W
         CexsAELUxsfiScheIP5KzQFesF5N1yPbirDpAVTFZBqIIkZagc/aE1++El3PomI6yt+M
         jRnxfsv5D3+FtOOddcmeIsMtxVKrpDrxqpS8U1iy0FWqbZLPoC9JGXG407DO0VRgQV9A
         r863d+5haVhxGCK8EX3ViaYakeYYqDnrIca/jDsUV6Ih7h6rfqmDXm+/+DU0TIEg62rz
         aKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717929432; x=1718534232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUIEGxGg8eY95ds7QR7Av+9t23TMyKmwO6BqnjfUYo4=;
        b=mso60LeAzUY6Prr2XDHzZMz7qGaqk98vzugyK+GviWcnkT1qmKRxWNAN4Lt+XH+Q1l
         gTfdOmGkkpqHEEBlv8VNoboRYYE2pGnsTDmbmNHZxjed8PK2w2lPE9zBhXvBgD25pNa0
         oZs0MCOOhCeWmuU7rLAdlbWJ8XHB/7iFLAOOUcn6MbZGT5z2KIi6AE7ljyfIVuDEBOH2
         apaZreECUsghby4tRp55n7EXF/Cra0onJEvqkmZhAiOy+Wy7eTqi6caFwI0WHywyM7g5
         tbU/NdR6QghbRX8/iPyJC81SCkY3FMnIeCaD4XCTGN3oSE9I5XgzWVEMrAC/XuGuUH7b
         sHsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVIbAOqRVb9ZbdHhkswmOfqoGJ3aupwkmoA+OfD9CFhijJdvhjZaiSxDw9qMTRMOwFeJ1pC4MMNaSqNfylNNM9x/cMNMjG
X-Gm-Message-State: AOJu0YybL3xb04xLEZNNc/f1RogGsIkWrPv6pwLX4zC2CB/MyswewKQh
	WXsbB97GhjaKzEJuj0k/WJqfqNjhetOsNW6sFd5cuWalFQ/eAuVxFRtIDqTXWfg=
X-Google-Smtp-Source: AGHT+IGfArVuUpG9mwzGQ2LT7Rw4nAR48CIY/0eQnNI4FvUnHk8G0KF+1MZKIWsjivMpclNzBucKbQ==
X-Received: by 2002:a17:906:5ac7:b0:a68:cf56:aaed with SMTP id a640c23a62f3a-a6cdc0e4ac5mr465844766b.74.1717929432294;
        Sun, 09 Jun 2024 03:37:12 -0700 (PDT)
Received: from dev.. ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef8c01579sm259579966b.155.2024.06.09.03.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 03:37:11 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com,
	kuba@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 0/2] net: bridge: mst: fix suspicious rcu usage warning
Date: Sun,  9 Jun 2024 13:36:52 +0300
Message-ID: <20240609103654.914987-1-razor@blackwall.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,
This set fixes a suspicious RCU usage warning triggered by syzbot[1] in
the bridge's MST code. After I converted br_mst_set_state to RCU, I
forgot to update the vlan group dereference helper. Fix it by using
the proper helper, in order to do that we need to pass the vlan group
which is already obtained correctly by the callers for their respective
context. Patch 01 is a requirement for the fix in patch 02.

Note I did consider rcu_dereference_rtnl() but the churn is much bigger
and in every part of the bridge. We can do that as a cleanup in
net-next.

Cheers,
 Nik

[1] https://syzkaller.appspot.com/bug?extid=9bbe2de1bc9d470eb5fe
 =============================
 WARNING: suspicious RCU usage
 6.10.0-rc2-syzkaller-00235-g8a92980606e3 #0 Not tainted
 -----------------------------
 net/bridge/br_private.h:1599 suspicious rcu_dereference_protected() usage!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 4 locks held by syz-executor.1/5374:
  #0: ffff888022d50b18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:144 [inline]
  #0: ffff888022d50b18 (&mm->mmap_lock){++++}-{3:3}, at: __mm_populate+0x1b0/0x460 mm/gup.c:2111
  #1: ffffc90000a18c00 ((&p->forward_delay_timer)){+.-.}-{0:0}, at: call_timer_fn+0xc0/0x650 kernel/time/timer.c:1789
  #2: ffff88805fb2ccb8 (&br->lock){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
  #2: ffff88805fb2ccb8 (&br->lock){+.-.}-{2:2}, at: br_forward_delay_timer_expired+0x50/0x440 net/bridge/br_stp_timer.c:86
  #3: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
  #3: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
  #3: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: br_mst_set_state+0x171/0x7a0 net/bridge/br_mst.c:105

 stack backtrace:
 CPU: 1 PID: 5374 Comm: syz-executor.1 Not tainted 6.10.0-rc2-syzkaller-00235-g8a92980606e3 #0
 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
 Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
  lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
  nbp_vlan_group net/bridge/br_private.h:1599 [inline]
  br_mst_set_state+0x29e/0x7a0 net/bridge/br_mst.c:106
  br_set_state+0x28a/0x7b0 net/bridge/br_stp.c:47
  br_forward_delay_timer_expired+0x176/0x440 net/bridge/br_stp_timer.c:88
  call_timer_fn+0x18e/0x650 kernel/time/timer.c:1792
  expire_timers kernel/time/timer.c:1843 [inline]
  __run_timers kernel/time/timer.c:2417 [inline]
  __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2428
  run_timer_base kernel/time/timer.c:2437 [inline]
  run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
  handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
  __do_softirq kernel/softirq.c:588 [inline]
  invoke_softirq kernel/softirq.c:428 [inline]
  __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
  </IRQ>
  <TASK>

Nikolay Aleksandrov (2):
  net: bridge: mst: pass vlan group directly to br_mst_vlan_set_state
  net: bridge: mst: fix suspicious rcu usage in br_mst_set_state

 net/bridge/br_mst.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.45.1

