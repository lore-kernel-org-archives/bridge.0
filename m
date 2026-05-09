Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEFC3CA4B2
	for <bridge@lists.linux.dev>; Sat,  9 May 2026 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778355327; cv=none; b=BEGEVmkr1BgdLEZfjF6S3cKwZbdVwkPlJfcp06MVFTI4+Q3rnY12mcLoXW/EahO7/6aS2TzrkICniPerTv1DRs7S/Q6nhQ706wqbhyeHW8NSybJjESShg3BZ3lPyO38cYKM1GgZMazGib18prx2qP0EcT/oBmP+otZYCg/ekazs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778355327; c=relaxed/simple;
	bh=RrAD8PWYFOTaDY39Rg4T1zAGCylE4ZJnUkcHMLWFEqI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oGmNxqMNHdzMbWnZMgTJmnDtrtIjBNzfFX5+te9wj+JwBQ14s5Mg1GUu0EVD1iyo2JZdObAInPDLSpaariFgwNgDMsAO4XMRe/C0NLxrdpqpsx38hd/OEofz4JBBu18m3mPrsSe+AIemxFzg7Y0FZyNv0UXtRoarmT329v0H7/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-69644bda339so7358619eaf.1
        for <bridge@lists.linux.dev>; Sat, 09 May 2026 12:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778355325; x=1778960125;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aHM25tFlQ+/S1FtbYaMtOGQOKyJ00q3ZWRGeNkBFGmY=;
        b=AgkGkFxg3P8W5XSI+LTLm1BnoqGmxk9tIcjMZt5qYuWlC68Nx0rdI2U/B83217OWaz
         RjhBscKn5aKfc1V/Vca9bY1sPh2eJjStBMkdi9RV8o0qJsNMEkAK96gaOq9ZF4TIWbaW
         dIPZp2OjtNyK9a0Em9u3UTyoFDQD/vHX3hW5exLWCbhlJlTFQQ9lyC/VE5qCDbS0ugR0
         sPIinqelwdTL8HWpkscXvXyZrrAHZLir64NyAB/Slnb6k67mmAqIXiQjZGsfCadwAp0X
         usxNtl6j7Oy5CoRe7zqzZxBAxk5pp/aAXsw5zw0tSJWQ6Jn14XTjTseb7Oeha3jvi5vO
         hRWQ==
X-Gm-Message-State: AOJu0YwHse1IQDjBHQXtqhUvgJHkKi9VNUXztY1fdrmkrjpICxYU8Wpc
	hA5pnkF5SdpRonxld6VUakb6RcMhZlM4HGmOesUjCxp/+N3olIRpeNXiSqM+Iz8E3jYUHTz2e00
	Ej9bPrNrGXlIjgz08aBUOaK4nZWF2X4nQzR7bF63fX9jaA2Z4nWiAZwG3UbIVDg==
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2e82:b0:67e:e9c:63f0 with SMTP id
 006d021491bc7-699ab62b692mr4327059eaf.25.1778355324763; Sat, 09 May 2026
 12:35:24 -0700 (PDT)
Date: Sat, 09 May 2026 12:35:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ff8c7c.050a0220.1036b8.000b.GAE@google.com>
Subject: [syzbot] [bridge?] kernel BUG in __get_vm_area_node
From: syzbot <syzbot+8b12fc6e0fb139765b58@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9207d47f966b Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e44d06580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0f0911eedbc130a
dashboard link: https://syzkaller.appspot.com/bug?extid=8b12fc6e0fb139765b58
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-9207d47f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c5e883f31aa/vmlinux-9207d47f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/19f3e863ae5c/bzImage-9207d47f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8b12fc6e0fb139765b58@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/vmalloc.c:3206!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 8030 Comm: syz.6.9336 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__get_vm_area_node+0x2d2/0x330 mm/vmalloc.c:3206
Code: 03 80 3c 11 00 75 5c 48 89 43 08 e9 4b ff ff ff e8 43 a8 a4 ff 48 89 df e8 db 98 05 00 31 db e9 37 ff ff ff e8 2f a8 a4 ff 90 <0f> 0b e8 77 6b 11 00 e9 9e fe ff ff e8 6d 6b 11 00 e9 71 fe ff ff
RSP: 0018:ffffc90006f76860 EFLAGS: 00010246
RAX: 0000000000080000 RBX: 0000000000000200 RCX: ffffc90034405000
RDX: 0000000000080000 RSI: ffffffff82633fb1 RDI: ffff8880244b4a00
RBP: 000000000000000c R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000200 R11: 0000000000000000 R12: 0000000000000022
R13: 0000000000008080 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88809727d000(0063) knlGS:00000000f4f61b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f73c4f50 CR3: 0000000055b77000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 000000000000000e DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __vmalloc_node_range_noprof+0x228/0x1630 mm/vmalloc.c:4024
 __kvmalloc_node_noprof+0x3de/0xa00 mm/slub.c:6860
 bucket_table_alloc.isra.0+0x88/0x460 lib/rhashtable.c:186
 rhashtable_insert_rehash lib/rhashtable.c:493 [inline]
 rhashtable_try_insert lib/rhashtable.c:661 [inline]
 rhashtable_insert_slow+0x16ab/0x1de0 lib/rhashtable.c:674
 __rhashtable_insert_fast include/linux/rhashtable.h:788 [inline]
 rhashtable_lookup_insert_fast include/linux/rhashtable.h:965 [inline]
 fdb_create+0x13cf/0x1920 net/bridge/br_fdb.c:415
 fdb_add_local net/bridge/br_fdb.c:450 [inline]
 fdb_add_local+0x155/0x1c0 net/bridge/br_fdb.c:430
 br_fdb_add_local+0x39/0x60 net/bridge/br_fdb.c:960
 __vlan_add+0x17f3/0x2e10 net/bridge/br_vlan.c:340
 br_vlan_add+0x2dc/0xa00 net/bridge/br_vlan.c:810
 __vlan_add+0xf7c/0x2e10 net/bridge/br_vlan.c:297
 nbp_vlan_add+0x258/0x3e0 net/bridge/br_vlan.c:1348
 br_vlan_info+0x159/0x3d0 net/bridge/br_netlink.c:705
 br_process_vlan_info+0x404/0x8f0 net/bridge/br_netlink.c:768
 br_afspec+0x422/0x650 net/bridge/br_netlink.c:836
 br_setlink+0x376/0x630 net/bridge/br_netlink.c:1135
 rtnl_bridge_setlink+0x56d/0x740 net/core/rtnetlink.c:5571
 rtnetlink_rcv_msg+0x3c9/0xe90 net/core/rtnetlink.c:7004
 netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2698
 ___sys_sendmsg+0x190/0x1e0 net/socket.c:2752
 __sys_sendmsg+0x170/0x220 net/socket.c:2784
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xe7/0x950 arch/x86/entry/syscall_32.c:307
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:332
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f08fcc
Code: d2 74 05 c1 e8 0c 89 02 8b 5d fc 31 c0 c9 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 2e 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00 58 b8
RSP: 002b:00000000f4f6150c EFLAGS: 00000292 ORIG_RAX: 0000000000000172
RAX: ffffffffffffffda RBX: 000000000000000c RCX: 0000000080000040
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__get_vm_area_node+0x2d2/0x330 mm/vmalloc.c:3206
Code: 03 80 3c 11 00 75 5c 48 89 43 08 e9 4b ff ff ff e8 43 a8 a4 ff 48 89 df e8 db 98 05 00 31 db e9 37 ff ff ff e8 2f a8 a4 ff 90 <0f> 0b e8 77 6b 11 00 e9 9e fe ff ff e8 6d 6b 11 00 e9 71 fe ff ff
RSP: 0018:ffffc90006f76860 EFLAGS: 00010246
RAX: 0000000000080000 RBX: 0000000000000200 RCX: ffffc90034405000
RDX: 0000000000080000 RSI: ffffffff82633fb1 RDI: ffff8880244b4a00
RBP: 000000000000000c R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000200 R11: 0000000000000000 R12: 0000000000000022
R13: 0000000000008080 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88809727d000(0063) knlGS:00000000f4f61b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f73c4f50 CR3: 0000000055b77000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 000000000000000e DR6: 00000000ffff0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	d2 74 05 c1          	shlb   %cl,-0x3f(%rbp,%rax,1)
   4:	e8 0c 89 02 8b       	call   0x8b028915
   9:	5d                   	pop    %rbp
   a:	fc                   	cld
   b:	31 c0                	xor    %eax,%eax
   d:	c9                   	leave
   e:	c3                   	ret
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	0f 1f 00             	nopl   (%rax)
  21:	51                   	push   %rcx
  22:	52                   	push   %rdx
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	2e 8d b4 26 00 00 00 	cs lea 0x0(%rsi,%riz,1),%esi
  36:	00
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  3e:	58                   	pop    %rax
  3f:	b8                   	.byte 0xb8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
