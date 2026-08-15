Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF01438E8AD
	for <bridge@lists.linux.dev>; Sat, 15 Aug 2026 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786798286; cv=none; b=DPS6O+3Cgo+MB3MY01a1cMXGrL+/6QtgJ7vfDw24w17dWuLfmdl3ViFCufORvHmkRetYUxjj/X2gehMZyhQ424Bt3Q1gUqJOM6xrCe4W1vPp9kKSgJhohkOKYt5Sqd+f/K7NvDutvDQy0xkfpb+G8CQFHI/HWDD6x56qCzXrr8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786798286; c=relaxed/simple;
	bh=HIbQ+JpYX0jXmi8cSJxSlzmovPVYMmN7thbmjNK6mfg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jDWUm1AJ9dBoRhzMRM7z1ief/VvW4883MWmILSnWT0KuSKZm63JVRFMfzzP9qgoU7xMreEH9ExI1boluSo4NDPCcrYDcMXTxy8EjmismLkQUOybwhCwubkVHANwo7muZcL3k9tkwJDmPqyVrLsJhaHLEAxq30IrRoWptIiJzU+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7ec5495f105so1698223a34.3
        for <bridge@lists.linux.dev>; Sat, 15 Aug 2026 05:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786798283; x=1787403083;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dddfo1vyS814kxJG2CMmVaBkCCAcVL7znNO+WyfKBjU=;
        b=VH8XKwDhRsA+svy9wQh79wsIM+vJyQ7qtSS11FM259ATO7M9Je7A+KU9w75bDpO4bZ
         Nqitwvz8bHwzKVimU0TjOuBBAlvpSX9tYWq3+Jh8sVxh4oW8sn+AHlZlo0nY6v196//Q
         BIGyxjsId+eg86sA4Bi+ovRdJux0AeFDetrOf6cgLKcLvphoF0PgPZR6anQwFTfO3XMV
         K7Gk2PcbchfM2b3ronkAUNBDlbo/+cNSKc9hsZyNMt+dX3ZKq/OX8m/9kEotPVSZRR66
         Rst5Cj0XpKm89HFh4D6Qo26D2rz1IStQAtyR7Kvq0ht3O9rltm+lgGE6k5DzeJHF63AO
         hXdg==
X-Gm-Message-State: AOJu0Yygi4OKp6SedmPO+ipYuwYlNdz21bQ5i5DRlIvDy8/Up2A/pkTo
	bKGv2rZc9gWJgZvYday2sIkv/GEqYSrZo8WCXJIU7NDS2eb0SKPp0EhZmN2/zHbYFszPmtpS5MJ
	Onodi6KFmFvnjwIwiRw6WZadJO/xI3XDjWrcyXAuQ8wvESt4d+ElfdeOq36k=
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a4a:e911:0:b0:6ae:8a52:ffa5 with SMTP id
 006d021491bc7-6b0d6885374mr10618841eaf.23.1786798283707; Sat, 15 Aug 2026
 05:51:23 -0700 (PDT)
Date: Sat, 15 Aug 2026 05:51:23 -0700
In-Reply-To: <6a1d714e.c1435f33.295d1e.2a35.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8060cb.5ca1970b.32aa76.0008.GAE@google.com>
Subject: Re: [syzbot] [bridge?] KASAN: use-after-free Read in filemap_map_pages
From: syzbot <syzbot+b72767277f29b6407083@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    15ef2f78c49d Merge tag 'input-for-v7.2-rc7' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11cfe279580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d67342c314f228d
dashboard link: https://syzkaller.appspot.com/bug?extid=b72767277f29b6407083
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15cfe279580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b72767277f29b6407083@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ptep_get include/linux/pgtable.h:495 [inline]
BUG: KASAN: use-after-free in filemap_map_folio_range mm/filemap.c:3820 [inline]
BUG: KASAN: use-after-free in filemap_map_pages+0x1b75/0x1f80 mm/filemap.c:3955
Read of size 8 at addr ffff88803f851a00 by task syz-executor403/6035

CPU: 2 UID: 0 PID: 6035 Comm: syz-executor403 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 ptep_get include/linux/pgtable.h:495 [inline]
 filemap_map_folio_range mm/filemap.c:3820 [inline]
 filemap_map_pages+0x1b75/0x1f80 mm/filemap.c:3955
 do_fault_around mm/memory.c:5818 [inline]
 do_read_fault mm/memory.c:5851 [inline]
 do_fault+0x985/0x1750 mm/memory.c:5994
 do_pte_missing mm/memory.c:4566 [inline]
 handle_pte_fault mm/memory.c:6379 [inline]
 __handle_mm_fault+0x187d/0x2a00 mm/memory.c:6517
 handle_mm_fault+0x37b/0xa30 mm/memory.c:6686
 do_user_addr_fault+0x74c/0x12f0 arch/x86/mm/fault.c:1394
 handle_page_fault arch/x86/mm/fault.c:1483 [inline]
 exc_page_fault+0x6f/0xd0 arch/x86/mm/fault.c:1536
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:595
RIP: 0010:fault_in_readable+0xde/0x190 mm/gup.c:2161
Code: 68 46 ae ff 4c 89 f0 48 85 c0 0f 85 bf 00 00 00 e8 77 4c ae ff 0f 01 cb 0f ae e8 4c 89 fb 4d 85 ff 75 31 eb 48 e8 62 4c ae ff <44> 8a 33 e8 5a 4c ae ff 48 81 c3 00 10 00 00 31 ff 48 81 e3 00 f0
RSP: 0018:ffffc90003a87af8 EFLAGS: 00050293
RAX: 0000000000000000 RBX: 00007fe62c200000 RCX: ffffffff825c2758
RDX: ffff888033b84a80 RSI: ffffffff825c271e RDI: ffff888033b84a80
RBP: 00007fe62c200001 R08: 0000000000000006 R09: 00007fe62c200001
R10: 00007fe62c200000 R11: 0000000000000000 R12: 0000000000000001
R13: 1ffff92000750f60 R14: 0000000000000000 R15: 00007fe62c200000
 fault_in_iov_iter_readable+0x101/0x2c0 lib/iov_iter.c:106
 generic_perform_write+0x863/0xa40 mm/filemap.c:4413
 shmem_file_write_iter+0x10e/0x140 mm/shmem.c:3424
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_pwrite64 fs/read_write.c:794 [inline]
 __do_sys_pwrite64 fs/read_write.c:802 [inline]
 __se_sys_pwrite64 fs/read_write.c:799 [inline]
 __x64_sys_pwrite64+0x1eb/0x250 fs/read_write.c:799
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe62c7fce5e
Code: 08 0f 85 f5 e2 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90 41 57 41 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
RSP: 002b:00007fe62b9fe1a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007fe62b9fe6c0 RCX: 00007fe62c7fce5e
RDX: 0000000000000001 RSI: 00007fe62c200000 RDI: 0000000000000003
RBP: 0000000000000021 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffd0
R13: 0000000000000000 R14: 00007ffdde346d90 R15: 00007ffdde346e78
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888000000000 pfn:0x3f851
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000100 dead000000000122 0000000000000000
raw: ffff888000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x440dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO|__GFP_COMP), pid 6004, tgid 6004 (cmp), ts 79653237963, free_ts 79740307238
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf48/0x3530 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x299/0x2dc0 mm/page_alloc.c:5304
 alloc_pages_mpol+0x1fb/0x540 mm/mempolicy.c:2490
 alloc_pages_noprof+0x1a/0x160 mm/mempolicy.c:2581
 pagetable_alloc_noprof include/linux/mm.h:3685 [inline]
 pmd_alloc_one_noprof include/asm-generic/pgalloc.h:143 [inline]
 __pmd_alloc+0x3b/0x950 mm/memory.c:6772
 pmd_alloc include/linux/mm.h:3601 [inline]
 __handle_mm_fault+0xa9c/0x2a00 mm/memory.c:6469
 handle_mm_fault+0x37b/0xa30 mm/memory.c:6686
 do_user_addr_fault+0x5a3/0x12f0 arch/x86/mm/fault.c:1343
 handle_page_fault arch/x86/mm/fault.c:1483 [inline]
 exc_page_fault+0x6f/0xd0 arch/x86/mm/fault.c:1536
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:595
page last free pid 6002 tgid 6002 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0x79f/0x1090 mm/page_alloc.c:2950
 __pagetable_free include/linux/mm.h:3695 [inline]
 pagetable_free include/linux/mm.h:3719 [inline]
 pagetable_dtor_free include/linux/mm.h:3818 [inline]
 __tlb_remove_table include/asm-generic/tlb.h:221 [inline]
 __tlb_remove_table_free mm/mmu_gather.c:228 [inline]
 tlb_remove_table_rcu+0x2cf/0x380 mm/mmu_gather.c:291
 rcu_do_batch kernel/rcu/tree.c:2645 [inline]
 rcu_core+0x5a2/0x10d0 kernel/rcu/tree.c:2897
 handle_softirqs+0x1ea/0x9b0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x162/0x210 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1062
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674

Memory state around the buggy address:
 ffff88803f851900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88803f851980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88803f851a00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88803f851a80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88803f851b00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================
----------------
Code disassembly (best guess):
   0:	68 46 ae ff 4c       	push   $0x4cffae46
   5:	89 f0                	mov    %esi,%eax
   7:	48 85 c0             	test   %rax,%rax
   a:	0f 85 bf 00 00 00    	jne    0xcf
  10:	e8 77 4c ae ff       	call   0xffae4c8c
  15:	0f 01 cb             	stac
  18:	0f ae e8             	lfence
  1b:	4c 89 fb             	mov    %r15,%rbx
  1e:	4d 85 ff             	test   %r15,%r15
  21:	75 31                	jne    0x54
  23:	eb 48                	jmp    0x6d
  25:	e8 62 4c ae ff       	call   0xffae4c8c
* 2a:	44 8a 33             	mov    (%rbx),%r14b <-- trapping instruction
  2d:	e8 5a 4c ae ff       	call   0xffae4c8c
  32:	48 81 c3 00 10 00 00 	add    $0x1000,%rbx
  39:	31 ff                	xor    %edi,%edi
  3b:	48                   	rex.W
  3c:	81                   	.byte 0x81
  3d:	e3 00                	jrcxz  0x3f
  3f:	f0                   	lock


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
