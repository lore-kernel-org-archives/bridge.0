Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1EB39A05D
	for <bridge@lists.linux.dev>; Sat,  1 Aug 2026 00:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785545739; cv=none; b=PXzH7Grn/fg7xBcfxUm5cu39KRrrjc0zFpGUiz6SWXeMui4A/gKzJblDUO0mFkuX+icD44bPtLXJ4365nx23x1Ho2nIpo8M8ZYn5WYRnvGx7OKtLkZLnPfBZODWiU7KptqYJ1a9Xl3TczMqTuyXsvmV4bmXu+ETi8PfhcYjEXkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785545739; c=relaxed/simple;
	bh=aWz4kcV/AjqntA6nJMXU3T9F1qlrOtVLGAyfwShjzng=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HZGMDTIm9ucsumDM2kiCXhvdPMPp62Gph51vsu5jEnFBF//ZTiBrtaf4LYzsui5qd20TFchQ6PUtfswtEO/RbjNUQtRHNrHxEbZ8iFoUyHwO2fklIoWC0AzED3wopwE9Y0nD4pZTFaw1TGLTSNecdKTHmhYdC9FePmgqhKEZ5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4a36606e230so2047903b6e.2
        for <bridge@lists.linux.dev>; Fri, 31 Jul 2026 17:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785545734; x=1786150534;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZA5LvUEt2FwGgOBdTzltpKIALnlVONsI8sGo9/aAobg=;
        b=hKjcwMWNESOvF95rRyxAg6nEaaF7FxzDviUtTiYZAUZ4sWLy6nLjecMVtfbtsIdi2H
         m0+CN+Es/exNbY7e/GbWkSSwMruEAUYRZ1jqG1BtxaL3ZM/jils2KgLwDl93hpAhSy6F
         i0YmEABhN4xXAKxhhOMa5Rvo4y7XXr0aYUO1T9jEitUeKKF0Scup+R+k0vTxbn69lYc/
         b09X6wJv2uYzk2uQ5IL4LZv+j+kT9WnT883XcO1JIyzfWctOz4uXDmHMv06m5X8AD9lR
         +5HnSobm4zLCcLUYbBRSzWgsF/V+Gvs/O7jjVeRbl675N5896TTVazGBpnJzJgtog3ib
         S29g==
X-Gm-Message-State: AOJu0YzTb920ogNJwEFhYyQ1/aI6KfZhi/WNHm37u/DUnsHcrngCDvOT
	UmH/Ddy1onIMubPoaCzaoa3SPITFnNb5Hm2cHCp9zyscFJ9e/cNulp4wEJ1psd9aMcLrM0kNQAU
	rj4hXy60F02qVOqPStJmmCf42Egem7LJORUu26cfp4/l1TtN5BT7eOWNW2FTEdA==
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2225:b0:4ab:230c:5faa with SMTP id
 5614622812f47-4af5e3e5522mr3607854b6e.18.1785545734163; Fri, 31 Jul 2026
 17:55:34 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:55:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6d4406.2d659fcc.1d46f5.01ad.GAE@google.com>
Subject: [syzbot] [bridge?] KASAN: slab-use-after-free Read in br_handle_frame
From: syzbot <syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    04026c998c24 net/rds: use krealloc_array() for iovector gr..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1141c49e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9f592a4e0cc86da
dashboard link: https://syzkaller.appspot.com/bug?extid=128e9f5a0f85a51215b1
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4f82b6352d02/disk-04026c99.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9b29e52c71b2/vmlinux-04026c99.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b1e84e828d6/bzImage-04026c99.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com

bridge0: received packet on bridge_slave_1 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:1)
bridge0: received packet on bridge_slave_1 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:1)
ip6_tunnel: ip6tnl2 xmit: Local address not yet configured!
==================================================================
BUG: KASAN: slab-use-after-free in is_multicast_ether_addr include/linux/etherdevice.h:133 [inline]
BUG: KASAN: slab-use-after-free in is_valid_ether_addr include/linux/etherdevice.h:209 [inline]
BUG: KASAN: slab-use-after-free in br_handle_frame+0xcfb/0x1510 net/bridge/br_input.c:349
Read of size 4 at addr ffff88807c476008 by task kworker/R-bat_e/3227

CPU: 1 UID: 0 PID: 3227 Comm: kworker/R-bat_e Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Workqueue: bat_events batadv_tt_purge
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 is_multicast_ether_addr include/linux/etherdevice.h:133 [inline]
 is_valid_ether_addr include/linux/etherdevice.h:209 [inline]
 br_handle_frame+0xcfb/0x1510 net/bridge/br_input.c:349
 __netif_receive_skb_core+0x989/0x30b0 net/core/dev.c:6102
 __netif_receive_skb_one_core net/core/dev.c:6213 [inline]
 __netif_receive_skb net/core/dev.c:6328 [inline]
 process_backlog+0x706/0x1860 net/core/dev.c:6679
 __napi_poll+0xaa/0x330 net/core/dev.c:7738
 napi_poll net/core/dev.c:7801 [inline]
 net_rx_action+0x61d/0xf50 net/core/dev.c:7958
 handle_softirqs+0x225/0x840 kernel/softirq.c:622
 do_softirq+0x76/0xd0 kernel/softirq.c:523
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 batadv_tt_local_purge+0x2c1/0x340 net/batman-adv/translation-table.c:1366
 batadv_tt_purge+0x35/0xa10 net/batman-adv/translation-table.c:3565
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 rescuer_thread+0x7b6/0x10b0 kernel/workqueue.c:3629
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5627:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5362 [inline]
 __kmalloc_node_track_caller_noprof+0x4c3/0x730 mm/slub.c:5497
 kmalloc_reserve net/core/skbuff.c:637 [inline]
 __alloc_skb+0x2bd/0x7a0 net/core/skbuff.c:715
 alloc_skb include/linux/skbuff.h:1384 [inline]
 mld_newpack+0x165/0xcb0 net/ipv6/mcast.c:1790
 add_grhead net/ipv6/mcast.c:1901 [inline]
 add_grec+0x119f/0x19d0 net/ipv6/mcast.c:2040
 mld_send_cr net/ipv6/mcast.c:2126 [inline]
 mld_ifc_work+0x30e/0xd60 net/ipv6/mcast.c:2711
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 3227:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2705 [inline]
 slab_free mm/slub.c:6405 [inline]
 kfree+0x1c5/0x640 mm/slub.c:6720
 skb_kfree_head net/core/skbuff.c:1077 [inline]
 skb_free_head net/core/skbuff.c:1089 [inline]
 pskb_expand_head+0x469/0x13a0 net/core/skbuff.c:2338
 netif_skb_check_for_xdp net/core/dev.c:5580 [inline]
 netif_receive_generic_xdp net/core/dev.c:5611 [inline]
 do_xdp_generic+0x9a5/0x12d0 net/core/dev.c:5679
 __netif_receive_skb_core+0x10e0/0x30b0 net/core/dev.c:6025
 __netif_receive_skb_one_core net/core/dev.c:6213 [inline]
 __netif_receive_skb net/core/dev.c:6328 [inline]
 netif_receive_skb_internal net/core/dev.c:6414 [inline]
 netif_receive_skb+0x1fe/0xbf0 net/core/dev.c:6473
 NF_HOOK+0xa4/0x3a0 include/linux/netfilter.h:325
 br_handle_frame_finish+0x1192/0x1990 net/bridge/br_input.c:-1
 br_nf_hook_thresh+0x3dd/0x4c0 net/bridge/br_netfilter_hooks.c:-1
 br_nf_pre_routing_finish_ipv6+0x90c/0xc40 net/bridge/br_netfilter_ipv6.c:-1
 NF_HOOK include/linux/netfilter.h:325 [inline]
 br_nf_pre_routing_ipv6+0x382/0x6f0 net/bridge/br_netfilter_ipv6.c:183
 nf_hook_entry_hookfn include/linux/netfilter.h:165 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
 br_handle_frame+0x127f/0x1510 net/bridge/br_input.c:442
 __netif_receive_skb_core+0x989/0x30b0 net/core/dev.c:6102
 __netif_receive_skb_one_core net/core/dev.c:6213 [inline]
 __netif_receive_skb net/core/dev.c:6328 [inline]
 process_backlog+0x706/0x1860 net/core/dev.c:6679
 __napi_poll+0xaa/0x330 net/core/dev.c:7738
 napi_poll net/core/dev.c:7801 [inline]
 net_rx_action+0x61d/0xf50 net/core/dev.c:7958
 handle_softirqs+0x225/0x840 kernel/softirq.c:622
 do_softirq+0x76/0xd0 kernel/softirq.c:523
 __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 batadv_tt_local_purge+0x2c1/0x340 net/batman-adv/translation-table.c:1366
 batadv_tt_purge+0x35/0xa10 net/batman-adv/translation-table.c:3565
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 rescuer_thread+0x7b6/0x10b0 kernel/workqueue.c:3629
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88807c476000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 8 bytes inside of
 freed 2048-byte region [ffff88807c476000, ffff88807c476800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88807c472000 pfn:0x7c470
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801b005000 ffffea0001f06210 ffffea00013ad810
raw: ffff88807c472000 0000000800080001 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88801b005000 ffffea0001f06210 ffffea00013ad810
head: ffff88807c472000 0000000800080001 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 29164, tgid 29161 (syz.4.10629), ts 619315175671, free_ts 619310279727
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0x21fa/0x2270 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3294 [inline]
 allocate_slab+0x79/0x5e0 mm/slub.c:3408
 new_slab mm/slub.c:3454 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7338
 refill_sheaf mm/slub.c:2832 [inline]
 __pcs_replace_empty_main+0x2bf/0x6b0 mm/slub.c:4703
 alloc_from_pcs mm/slub.c:4801 [inline]
 slab_alloc_node mm/slub.c:4933 [inline]
 __do_kmalloc_node mm/slub.c:5361 [inline]
 __kmalloc_node_track_caller_noprof+0x557/0x730 mm/slub.c:5497
 kmalloc_reserve net/core/skbuff.c:637 [inline]
 __alloc_skb+0x2bd/0x7a0 net/core/skbuff.c:715
 alloc_skb include/linux/skbuff.h:1384 [inline]
 alloc_skb_with_frags+0xc6/0x760 net/core/skbuff.c:6769
 sock_alloc_send_pskb+0x878/0x990 net/core/sock.c:3013
 sock_alloc_send_skb include/net/sock.h:1907 [inline]
 llc_ui_sendmsg+0x459/0xe30 net/llc/af_llc.c:968
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
 __sock_sendmsg net/socket.c:790 [inline]
 sock_sendmsg+0x1ca/0x2d0 net/socket.c:813
 splice_to_socket+0xb5e/0x12a0 fs/splice.c:884
 do_splice_from fs/splice.c:936 [inline]
 direct_splice_actor+0x101/0x160 fs/splice.c:1159
 splice_direct_to_actor+0x57b/0xcb0 fs/splice.c:1103
page last free pid 29163 tgid 29158 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0xc1e/0xd10 mm/page_alloc.c:2950
 rcu_do_batch kernel/rcu/tree.c:2645 [inline]
 rcu_core+0x78b/0x10a0 kernel/rcu/tree.c:2897
 handle_softirqs+0x225/0x840 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674

Memory state around the buggy address:
 ffff88807c475f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807c475f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807c476000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88807c476080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c476100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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
