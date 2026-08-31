Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1573E0750
	for <bridge@lists.linux.dev>; Mon, 31 Aug 2026 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169770; cv=none; b=HluAq8XFxYNRa3/bpr7T04ya6DetT1WuGsqiZju+4sbPpczrm5rl4cPoNo9WFtz5PFnJAlfPiHjy9RNW2bBjB3GGLxPMXlBr8Fba7+AjHmDgoxQtxk7JSeOLmHpiuX0xI3HUDvzZV/F4OXfaejdd9HehieNUUFkro50ytSo1kwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169770; c=relaxed/simple;
	bh=jFkDjmEyqyiWfrpYXxLtDdtA9fMSc4XIhiKy4OnakCk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UJnd+icwpzUJwci/Q2Xk0UoX8BEk0wjGhLQpkgtSnqK05ssGZddqVTFVF1cDlkpPvMDk1cOPzQXjljkaoTtUAX5TyS73vB29WpQ3RujWL3Oi9sQwS8zqHcpl2WDR0iiz3ty1ZeGjmEUqkz7V0os3QXNcWNHiMTR6H8hJATMwpJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-4511f6a63edso287663fac.1
        for <bridge@lists.linux.dev>; Mon, 31 Aug 2026 02:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788169768; x=1788774568;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kb6/DvD2yhBb3DVkM1VqLGvfuN4hkrtvjLZBLuP8QX8=;
        b=eR5ZjKyhORPPxmgq7NfktOI9Vo0aVOuZjfNd7W9pSqE/yVdK1/7XV5/vEpuaTg9Lfc
         /NZseYLJheaHUf5CBUYYhDPZELyjalKM4L7rLhSs7M7CM1dIMjxuameMFsyc9YgS13Zj
         NukA9yxBbua3sLzT3l8o8z7Fr1GNQqPkhqet+nDxc3xtqEOncPf3EBUzdGKnG2wodp2I
         QMdBosYrabTBVQEACm7gxP5mROkXhX9vs/UydHrnOo6DGsMQ03yWG1TrDtZvRSmvR06I
         CvJpil5miDs86lPDOotn9nboGMEFTDpkIRlts6Jj0sj1zl7Ds06Ok1ELsY5X14gwzB2Z
         uj0Q==
X-Gm-Message-State: AFuF++m2IPTb0KuPlgGIMgQ18+75lngNCOTBFXSIhTpcO1Un9p6I/+qB
	qZAE5o33q1Fj4VHswouMDkjSQVgmN5xkRskLbf5OlPsTXgnWRXK5IK2oB+OGkcv9aSO8Eb0BC6I
	S2K+4Fr2dyDHZu89oOjORGpFEkiMXSWh/tVsSt2co7HBsjvhMoaTKXOvBBVTi6A==
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f4b:b0:4b2:8e1c:5920 with SMTP id
 5614622812f47-4b3981ace12mr24126505b6e.9.1788169767878; Mon, 31 Aug 2026
 02:49:27 -0700 (PDT)
Date: Mon, 31 Aug 2026 02:49:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a954e27.4d659fcc.734b4.0046.GAE@google.com>
Subject: [syzbot] [bridge?] KASAN: use-after-free Read in skb_clone
From: syzbot <syzbot+22c4f9a7026c86bcc3b8@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1b78070aaef6 Merge tag 'net-7.3-rc1' of git://git.kernel.o..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1535ce25580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=22c4f9a7026c86bcc3b8
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9bf9d046731e/disk-1b78070a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/31e105356045/vmlinux-1b78070a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6087b1118967/bzImage-1b78070a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+22c4f9a7026c86bcc3b8@syzkaller.appspotmail.com

bridge0: received packet on bridge_slave_1 with own address as source address (addr:aa:aa:aa:aa:aa:1c, vlan:1)
==================================================================
BUG: KASAN: use-after-free in skb_zcopy include/linux/skbuff.h:1793 [inline]
BUG: KASAN: use-after-free in skb_orphan_frags include/linux/skbuff.h:3435 [inline]
BUG: KASAN: use-after-free in skb_clone+0x31d/0x3a0 net/core/skbuff.c:2107
Read of size 1 at addr ffff88802ad30080 by task kworker/u8:15/7915

CPU: 1 UID: 0 PID: 7915 Comm: kworker/u8:15 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: events_unbound cfg80211_wiphy_work
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 skb_zcopy include/linux/skbuff.h:1793 [inline]
 skb_orphan_frags include/linux/skbuff.h:3435 [inline]
 skb_clone+0x31d/0x3a0 net/core/skbuff.c:2107
 deliver_clone net/bridge/br_forward.c:125 [inline]
 maybe_deliver net/bridge/br_forward.c:191 [inline]
 br_flood+0x3c3/0x8d0 net/bridge/br_forward.c:245
 br_handle_frame_finish+0x1119/0x1950 net/bridge/br_input.c:229
 nf_hook_bridge_pre net/bridge/br_input.c:313 [inline]
 br_handle_frame+0x81b/0x1510 net/bridge/br_input.c:442
 __netif_receive_skb_core+0x989/0x30c0 net/core/dev.c:6151
 __netif_receive_skb_one_core net/core/dev.c:6262 [inline]
 __netif_receive_skb net/core/dev.c:6377 [inline]
 process_backlog+0x727/0x18b0 net/core/dev.c:6728
 __napi_poll+0xaa/0x330 net/core/dev.c:7787
 napi_poll net/core/dev.c:7850 [inline]
 net_rx_action+0x61d/0xf50 net/core/dev.c:8007
 handle_softirqs+0x226/0x860 kernel/softirq.c:645
 do_softirq+0x77/0xd0 kernel/softirq.c:546
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x140 kernel/softirq.c:473
 spin_unlock_bh include/linux/spinlock.h:407 [inline]
 cfg80211_inform_single_bss_data+0x1491/0x1be0 net/wireless/scan.c:2426
 cfg80211_inform_bss_data+0x263/0x3cc0 net/wireless/scan.c:3266
 cfg80211_inform_bss_frame_data+0x3c7/0x840 net/wireless/scan.c:3358
 ieee80211_bss_info_update+0x791/0xa50 net/mac80211/scan.c:230
 ieee80211_rx_bss_info net/mac80211/ibss.c:1065 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1546 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1ce3/0x2c40 net/mac80211/ibss.c:1573
 ieee80211_iface_process_skb net/mac80211/iface.c:1769 [inline]
 ieee80211_iface_work+0x78a/0x1010 net/mac80211/iface.c:1823
 cfg80211_wiphy_work+0x29e/0x420 net/wireless/core.c:541
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88802ad36000 pfn:0x2ad30
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0000a99c08 ffff8880b87417b0 0000000000000000
raw: ffff88802ad36000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x528c0(GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NORETRY|__GFP_COMP), pid 13508, tgid 13502 (syz.2.1942), ts 299754405803
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x2209/0x2280 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x217/0x5a0 mm/page_alloc.c:5436
 alloc_pages_mpol+0x21e/0x390 mm/mempolicy.c:2486
 alloc_frozen_pages_noprof mm/mempolicy.c:2557 [inline]
 alloc_pages_noprof+0xb1/0x2b0 mm/mempolicy.c:2577
 skb_page_frag_refill+0xf5/0x460 net/core/sock.c:3193
 tun_build_skb drivers/net/tun.c:1706 [inline]
 tun_get_user+0x1b32/0x44d0 drivers/net/tun.c:1856
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:2091
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 7915 tgid 7915 ts 394412542880 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0xc93/0xd90 mm/page_alloc.c:2962
 skb_free_frag include/linux/skbuff.h:3559 [inline]
 skb_free_head net/core/skbuff.c:1093 [inline]
 pskb_expand_head+0x6d1/0x13a0 net/core/skbuff.c:2347
 __skb_cow include/linux/skbuff.h:3904 [inline]
 skb_cow_head include/linux/skbuff.h:3938 [inline]
 __vlan_insert_inner_tag include/linux/if_vlan.h:368 [inline]
 vlan_insert_inner_tag include/linux/if_vlan.h:441 [inline]
 vlan_insert_tag include/linux/if_vlan.h:468 [inline]
 vlan_insert_tag_set_proto include/linux/if_vlan.h:489 [inline]
 __vlan_hwaccel_push_inside include/linux/if_vlan.h:529 [inline]
 validate_xmit_vlan net/core/dev.c:3976 [inline]
 validate_xmit_skb+0x3aa/0x14f0 net/core/dev.c:4081
 __dev_queue_xmit+0xb04/0x3820 net/core/dev.c:4913
 dev_queue_xmit include/linux/netdevice.h:3461 [inline]
 vlan_dev_hard_start_xmit+0x201/0x420 net/8021q/vlan_dev.c:126
 __netdev_start_xmit include/linux/netdevice.h:5429 [inline]
 netdev_start_xmit include/linux/netdevice.h:5438 [inline]
 xmit_one net/core/dev.c:3937 [inline]
 dev_hard_start_xmit+0x2cd/0x830 net/core/dev.c:3953
 __dev_queue_xmit+0x14c0/0x3820 net/core/dev.c:4926
 dev_queue_xmit include/linux/netdevice.h:3461 [inline]
 br_dev_queue_push_xmit+0x370/0x4b0 net/bridge/br_forward.c:53
 NF_HOOK+0x360/0x3f0 include/linux/netfilter.h:325
 br_forward_finish+0xd3/0x130 net/bridge/br_forward.c:66
 NF_HOOK+0x360/0x3f0 include/linux/netfilter.h:325
 __br_forward+0x397/0x540 net/bridge/br_forward.c:115
 deliver_clone net/bridge/br_forward.c:131 [inline]
 maybe_deliver net/bridge/br_forward.c:191 [inline]
 br_flood+0x3e6/0x8d0 net/bridge/br_forward.c:245
 br_handle_frame_finish+0x1119/0x1950 net/bridge/br_input.c:229
 nf_hook_bridge_pre net/bridge/br_input.c:313 [inline]
 br_handle_frame+0x81b/0x1510 net/bridge/br_input.c:442
 __netif_receive_skb_core+0x989/0x30c0 net/core/dev.c:6151

Memory state around the buggy address:
 ffff88802ad2ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802ad30000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88802ad30080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88802ad30100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88802ad30180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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
