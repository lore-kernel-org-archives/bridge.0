Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E4417545
	for <bridge@lists.linux.dev>; Sun, 12 May 2024 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715501071; cv=none; b=DxNdyWeQMWFb8WVWmwn8OW0X32Jmz3fSpKnDgiISJBRkiJJu9DgVbR1Y1CF4ZxSz5rNCNkpgu2uwXsypwECWwNSOCeGS69eQ0vD+aJfAlCjRBsPmNugEV54h1ikAO0KSj5Rld1lcpFzEWoM1v1cejwU4YkmIoKBECXtJnnag7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715501071; c=relaxed/simple;
	bh=UgkNHWfTVk8YpKE30qIveVOe8pe8nXbSRKLee8Dz4Bo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lf0RqtoyK+UF40tppOY051YNjMMkallclTcRl+Jk+oDgnDtqme3EVYYFXA10+fPXbvtmvSBKbquMI5o9Dmfq3Xm5/SqWLXqJopNQb5R+ribbaGa2ezCEKgJ5bJOtmVQdf3cGsgo0Gcxg0tD0awY9JXmN31IcvrjA5UnoGOu6z6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e1db7e5386so35505339f.3
        for <bridge@lists.linux.dev>; Sun, 12 May 2024 01:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715501069; x=1716105869;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JA5VCptPjyfIoM7ebz+7WHXx2umUxBAkXBABPwEhn6k=;
        b=iEJlL1BmkX+0ONkyTKUwIX5rG0gGXnb/2ledJPd4iP5E7bHOMZC+WuZkGXFR/G2Uao
         xodY36ia37/TJVActjBor05ZzVvratBBLP3lXdM67GFWG5/1UK5cdKi+zczguD9Rgppg
         6P/ANA8J1GdawDGRT69nJ9vsaWL/RMgn1PF6/8GVrmVCSjQvskzckNhvrVv7MiuvIjYS
         Ubb32OauSICDDtWlD42gZcVLzteQU+y3ewI6F+1kbG2DySJoQSEVirCpoIYKOkUpHZ9f
         h6c9zgySYcE6J+hWNP4R6oHSMoY+/GPy/CepqcNqUFyTga6d7fPk6g8TJKfz/DAjEaId
         WsMQ==
X-Gm-Message-State: AOJu0YytKGVS9PcbgCseAUvH11EvxBl5xDiiQo21Eqmo5GhEhtXYIlAR
	nwRlFpAzsNlOPlVrp1N0RylgBqYxCzCkuKRPpHseAQBelTR/S4wMuZI38iUwsGGH8qvTbhggcrS
	sg1z3aCopC0SCZzZ4pu67Jl0oiLfNtIL6kvdC5qCWMCi1nVEw4hOClnQTeA==
X-Google-Smtp-Source: AGHT+IGMCmJFPFJF3fk69Cf2peBO45tLdX3hxvujdc71EobswisJhf13rG+/RIov/aCulJQas0YVTig/qD2uBa5dkW9gn1R5ip5K
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b10:b0:7de:d6a0:d9c4 with SMTP id
 ca18e2360f4ac-7e1b5204829mr24194139f.2.1715501069028; Sun, 12 May 2024
 01:04:29 -0700 (PDT)
Date: Sun, 12 May 2024 01:04:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4e70506183d374d@google.com>
Subject: [syzbot] [bridge?] KMSAN: uninit-value in br_dev_xmit (2)
From: syzbot <syzbot+a63a1f6a062033cf0f40@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, razor@blackwall.org, roopa@nvidia.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10b995a8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617171361dd3cd47
dashboard link: https://syzkaller.appspot.com/bug?extid=a63a1f6a062033cf0f40
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122a37c0980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111a53c0980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fdbc7be30633/disk-dccb07f2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a9e4c11aa835/vmlinux-dccb07f2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/43c3a343ea93/bzImage-dccb07f2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a63a1f6a062033cf0f40@syzkaller.appspotmail.com

=====================================================
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

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3851 [inline]
 kmem_cache_alloc_node+0x622/0xc90 mm/slub.c:3894
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
 pskb_expand_head+0x222/0x19d0 net/core/skbuff.c:2251
 skb_ensure_writable+0x412/0x4a0 net/core/skbuff.c:6117
 __bpf_try_make_writable net/core/filter.c:1665 [inline]
 bpf_try_make_writable net/core/filter.c:1671 [inline]
 bpf_try_make_head_writable net/core/filter.c:1679 [inline]
 ____bpf_clone_redirect net/core/filter.c:2454 [inline]
 bpf_clone_redirect+0x17f/0x470 net/core/filter.c:2432
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

CPU: 0 PID: 5070 Comm: syz-executor183 Not tainted 6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
