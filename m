Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A201EFF93
	for <bridge@lists.linux.dev>; Fri,  4 Sep 2026 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482434; cv=none; b=F2GcafOR51oWNMXCqw5CgMd2oCUgskidgS4ptRcLw4ghX74vwtcizKrSKS4Gy1OH+fw6wtF3U7Xh/+kUmEW0IAXJ7DYF6Fq/FDvAKsRAy72c8zWEImFiyrb8Bze3k76XI9NCuqBBhWxvCY5GJxCqYpzOovVMx/HvOXBhR0bEfaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482434; c=relaxed/simple;
	bh=7LQpb0Pa73PlrS8iOd6HJy/L6pdf8Fsn9gXcja5ixfo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=X0pXqUotHj9QRBKiMsnaVi9kkX94HBiTLC86Ts4WGy4lP6Q/R63LKzPb7xyObhs2PXyTLhxteK6pBqBqUbZp+IsfZ3NJ6RJ+yr+vBagunpSQOzlZBM8YHhQu02Lh1VRxDrEQ7e5ABAMWZN/ub1q3ybQODotTRhO/1c0RwFCUpCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6b163fddf0aso1639104eaf.1
        for <bridge@lists.linux.dev>; Thu, 03 Sep 2026 17:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788482431; x=1789087231;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hNPf08Y7tBx8DkNypiWcYaCaJCCHHn5rIsGOQMKw6+M=;
        b=O8oe9bK2cpbBhulTzkrMFb3w/rAwhAFXRds2pndUEODyitUAhBzwVEczTajCPqHbKM
         uRJR2UxQfX8DB0nUC+fYGM+ttAioEXrXgx0T0ZQTcbeXL38t64tfzleTn1zIL1sE6G7W
         LT8UirbYl92aJQ/JIdGjqg39xicDJcCGgpFbvYHz1qAlzIQrp/5bCF65gD9GYJXz89Nf
         hCH0ASwXaAK5YXGoJW6iYgdYBvQ7f9CICB0OFv+5G8/Ff6PFCeiImmvzqgBQxxJTxn/W
         H+m0RFMbRokzdBUa7mJsv4ltMGnc/WDCwBdK2VlPRqxN9E95+n3F/9sVZNRk/r6c6trp
         UoJw==
X-Gm-Message-State: AFuF++m36Npdch1UPxH1+br+xXEdsaR8ekjO9bGPlJq02oyNrGYIPgZn
	/8RnXo0TTFISPvXDU5Wd8OBP5XSoFIqPjwVI4PCTJpwlV4O9Xr/ahDpLcv+E8gkOc3972ZVaUxA
	qLFZf5q5AA3hpkc0XxvqLbZaZR8IbAwDGlKKgSYq4hODWZtctS/+tTVHnnxeETw==
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4df8:b0:6b6:1db8:5d1f with SMTP id
 006d021491bc7-6b627d58214mr2086763eaf.13.1788482431355; Thu, 03 Sep 2026
 17:40:31 -0700 (PDT)
Date: Thu, 03 Sep 2026 17:40:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9a137f.9266084e.bf0d7.02e3.GAE@google.com>
Subject: [syzbot] [bridge?] general protection fault in br_del_frame
From: syzbot <syzbot+1df7473ef265fe8ba6e1@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    818bebeb63dd drm/xe: Don't hand out the flat CCS storage a..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1596a979580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccca94d2c01b9e78
dashboard link: https://syzkaller.appspot.com/bug?extid=1df7473ef265fe8ba6e1
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1431e625580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-818bebeb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6e4100526b12/vmlinux-818bebeb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/723c4783ee96/bzImage-818bebeb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1df7473ef265fe8ba6e1@syzkaller.appspotmail.com

bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
Oops: general protection fault, probably for non-canonical address 0xfbd59c0000000024: 0000 [#1] SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0xdead000000000120-0xdead000000000127]
CPU: 1 UID: 0 PID: 12 Comm: kworker/u32:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:__hlist_del include/linux/list.h:1038 [inline]
RIP: 0010:hlist_del_rcu include/linux/rculist.h:599 [inline]
RIP: 0010:br_del_frame+0x106/0x1a0 net/bridge/br_input.c:482
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 87 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 65 18 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75 76 49 89 1c 24 48 85 db 74 24 e8 c6 45 72 f7 48 8d
RSP: 0018:ffffc900000f78e8 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 1bd5a00000000024 RSI: ffffffff8a98bb9f RDI: ffffffff91453338
RBP: ffffffff91453320 R08: 0000000000000001 R09: 000000000000002c
R10: 0000000000000200 R11: 0000000000000001 R12: dead000000000122
R13: ffff88802e200800 R14: 000000000000001c R15: ffff88802e200800
FS:  0000000000000000(0000) GS:ffff8880d5ca2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdcf9541e9c CR3: 0000000026926000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 mep_delete_implementation+0x292/0x340 net/bridge/br_cfm.c:591
 br_cfm_port_del+0x14f/0x1e0 net/bridge/br_cfm.c:872
 del_nbp+0x168/0xd50 net/bridge/br_if.c:348
 br_dev_delete+0x96/0x1c0 net/bridge/br_if.c:387
 br_net_exit_rtnl+0xdb/0x140 net/bridge/br.c:414
 ops_exit_rtnl_list net/core/net_namespace.c:181 [inline]
 ops_undo_list+0x896/0xab0 net/core/net_namespace.c:249
 cleanup_net+0x499/0x920 net/core/net_namespace.c:706
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3387
 process_scheduled_works kernel/workqueue.c:3470 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3551
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__hlist_del include/linux/list.h:1038 [inline]
RIP: 0010:hlist_del_rcu include/linux/rculist.h:599 [inline]
RIP: 0010:br_del_frame+0x106/0x1a0 net/bridge/br_input.c:482
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 87 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 65 18 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75 76 49 89 1c 24 48 85 db 74 24 e8 c6 45 72 f7 48 8d
RSP: 0018:ffffc900000f78e8 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 1bd5a00000000024 RSI: ffffffff8a98bb9f RDI: ffffffff91453338
RBP: ffffffff91453320 R08: 0000000000000001 R09: 000000000000002c
R10: 0000000000000200 R11: 0000000000000001 R12: dead000000000122
R13: ffff88802e200800 R14: 000000000000001c R15: ffff88802e200800
FS:  0000000000000000(0000) GS:ffff8880d5ca2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdcf9541e9c CR3: 0000000026926000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	00 fc                	add    %bh,%ah
   2:	ff                   	lcall  (bad)
   3:	df 48 89             	fisttps -0x77(%rax)
   6:	fa                   	cli
   7:	48 c1 ea 03          	shr    $0x3,%rdx
   b:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   f:	0f 85 87 00 00 00    	jne    0x9c
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	4c 8b 65 18          	mov    0x18(%rbp),%r12
  23:	4c 89 e2             	mov    %r12,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	75 76                	jne    0xa6
  30:	49 89 1c 24          	mov    %rbx,(%r12)
  34:	48 85 db             	test   %rbx,%rbx
  37:	74 24                	je     0x5d
  39:	e8 c6 45 72 f7       	call   0xf7724604
  3e:	48                   	rex.W
  3f:	8d                   	.byte 0x8d


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
