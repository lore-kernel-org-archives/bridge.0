Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1866A3009C4
	for <bridge@lists.linux.dev>; Mon,  3 Nov 2025 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174272; cv=none; b=uveSKs7sBtMwKNXMOBUfxRWyUUfW8BerV8WO+1E5aqPAbukhth4lrsJdDPZ1qHtI/h1oyMzpcPlvkzDkuF7cn7YnkD1s+08v5y3heLdBiHPsJBfUr5v7adnT/rEK1HqsHSajjdDhGW68EOfm1vDx6Es/A8mbVqpKWz++OI8qOvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174272; c=relaxed/simple;
	bh=GKVjahR3ap831Uf5wi33NYCSIUIU6MFjPaGQIB2p8xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cdQ5RyF+CdHcMX81INAe5w0XQ4sZ/aIxZwOYRg1iA8DYU1U2kzRm025zlq7rVPSsTzTY3TdfHMLVfOoV6aPwPv949zzOT0wvUyFFEXRm3g+wtGTq2nkX9XdcoBDt0krCrUiJNJjCU6WJvhZJeEYI+PgxT3mR0pijrZskzwN6FIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=M/+LY16g; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="M/+LY16g"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso7882328a12.1
        for <bridge@lists.linux.dev>; Mon, 03 Nov 2025 04:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762174268; x=1762779068; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fp+j2vbWEN1jivOwFbY5w28izSQxvXUbwwshogJJkN4=;
        b=M/+LY16gyb8sP0o7Z+p7pY/UrZKDziV1p2OxVDaEC5aFWnUARY34rVgkBQ/b7PPC/U
         cG4WAVhZ2HoSsIaCix5KguoFYw0/N5JhiTIiaomrqHBZ99cWRItr10+JkA4yruJa0fQY
         GuZblZf21AXbBtdXNkWDs+3c7ZdGrNn/Upi5+NGDR13Q5fG6i7/d/aaz6WQDW0jiGRYv
         XyON8fT/dBh1FjYXsczIKyjWDwFVE8P0hIf07y06Om7m1ZUE+Rp8oBnEcZQBEm8Xx0Is
         T38C2+UeZDMFc3vEvbHDykvjWj2Jk8AWaerR6BxdNJn7z0BnqZdU6XxFjxNvGY4tn6dU
         NdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762174268; x=1762779068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fp+j2vbWEN1jivOwFbY5w28izSQxvXUbwwshogJJkN4=;
        b=fIfXyoMnyhTePiPkyekfUYU8pZtPbZlE0g7+kDHm22ZLty7XreIA/f6uJn/cVJjtEQ
         VFnvopvelCpTNUrc9nBMu0tpVLdldLsxYYnVzgylMzeaiHNHU5EParqdW+jHL8sMVwDM
         riOtR+pSdWrtH4ZF2Lswm/hlJC2P7yLsgly/Ulyay7Jsyp26rpc+EI6+22dya0mbW3Uv
         IiF7fs3tdskgomMrrIlQ9pEsGHi0XfqsUXJODJYRh7wIOjbBJIe3O5YaWaDDnqCfJe8R
         7aTvwrPfvhlmfQXga860EijClm2CKL0yfuHdq6L6xeW42KpxwMg3sJgjVCllXFaeyZPw
         szCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL1iaEAEjEJ79xRS1wK52I2A8A31nOzU5j0yc0HuDAxEm2bPomX7jdmpVcDe+AsTHSvJ9MXW8=@lists.linux.dev
X-Gm-Message-State: AOJu0YwIb4+zKhmnzIPuzD8y6B+T7OPkDkch7zbhj7XPlbFRMRtU5Hl8
	3emu0sgYARC7FhQ4J3KjwkZxaWZV/ypY9FUJsyKlaSee8mdDq48WiQTkPNADPwayUqE=
X-Gm-Gg: ASbGncv0h/bo4oMq6wk/4s5s4LCYyWtJBftjaBlCMrgLImWRr2nOT15XbrHX8FTOcAa
	5cohwT5yONDC+RkWmHRrUX1qyOEAPUtNDp136lv5HXwqpXFPVnqH9N/7Otng1XnmigLgDkbpBRx
	dBfvlyynSsM3xUCD+GAuna5fBKbXjc5ra4kg3V7IcvG7dXXI7Uiqeq/60p2rHGvjucBuZHnBlAI
	h+DjWLLjUZ90GmAzdK/lhIpWxb9VrttEMne2+EWQpfR/8GKpfRtafUcfcA8yOb7yGT4YB/pgLGX
	XsX1njKck70sYqL41OyO9pa/ORrDGRuZDNyFOtgNjZhdVYNZJwVNdZVkuhj+2d2WBD8Xtq8+cv5
	lugq57NVN1d1jjR4GWpNK1zpDVHY/+SKqE8lE/xNx3Bzai2g0IUgASJ4KsJs+0zXrZdnPcrDmzs
	c64/T8i8g5JAHVkzjVsuQxdwc0Xb1jYlLsz/gbSQBuv5pAEft7+L3RPQ==
X-Google-Smtp-Source: AGHT+IES3A3mK7ytMqt2Z/bXsHWIadDaVVUZjNu9ZS8jCVz1Tei4xBzhPLhjMSuOTaIGhY7kYmOTLg==
X-Received: by 2002:a05:6402:5212:b0:640:c460:8a9b with SMTP id 4fb4d7f45d1cf-640c46097d4mr2915046a12.4.1762174268058;
        Mon, 03 Nov 2025 04:51:08 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640a503fc82sm5915978a12.4.2025.11.03.04.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 04:51:06 -0800 (PST)
Message-ID: <e2acc82f-8928-4ba2-876e-2a669c07cd70@blackwall.org>
Date: Mon, 3 Nov 2025 14:51:04 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bridge?] KASAN: slab-use-after-free Read in
 br_switchdev_fdb_populate
To: syzbot <syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com>,
 bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, idosch@nvidia.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <69088ffa.050a0220.29fc44.003d.GAE@google.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <69088ffa.050a0220.29fc44.003d.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 13:20, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fd57572253bc Merge tag 'sched_ext-for-6.18-rc3-fixes' of g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13f957e2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=609c87dcb0628493
> dashboard link: https://syzkaller.appspot.com/bug?extid=dd280197f0f7ab3917be
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a4541b741dd8/disk-fd575722.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/eae4ddf523dd/vmlinux-fd575722.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/28e03b35c3fc/bzImage-fd575722.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in br_switchdev_fdb_populate+0x390/0x3a0 net/bridge/br_switchdev.c:141
> Read of size 8 at addr ffff888025122808 by task kworker/0:2/977
> 

hmm I have an idea about this one, it's possibly related to
MST enabled && vlan filtering disabled. I'll try to repro and
post a fix if I'm correct.

Cheers,
 Nik

> CPU: 0 UID: 0 PID: 977 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
> Workqueue: events_long br_fdb_cleanup
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xcd/0x630 mm/kasan/report.c:482
>  kasan_report+0xe0/0x110 mm/kasan/report.c:595
>  br_switchdev_fdb_populate+0x390/0x3a0 net/bridge/br_switchdev.c:141
>  br_switchdev_fdb_notify+0x1df/0x2c0 net/bridge/br_switchdev.c:165
>  fdb_notify+0x16c/0x1a0 net/bridge/br_fdb.c:186
>  fdb_delete+0x76e/0x12a0 net/bridge/br_fdb.c:324
>  br_fdb_cleanup+0x43e/0x600 net/bridge/br_fdb.c:574
>  process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
>  process_scheduled_works kernel/workqueue.c:3346 [inline]
>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
>  kthread+0x3c5/0x780 kernel/kthread.c:463
>  ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> Allocated by task 5810:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:77
>  poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
>  __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:417
>  kmalloc_noprof include/linux/slab.h:957 [inline]
>  kzalloc_noprof include/linux/slab.h:1094 [inline]
>  new_nbp net/bridge/br_if.c:431 [inline]
>  br_add_if+0x41d/0x1b70 net/bridge/br_if.c:599
>  do_set_master+0x40f/0x730 net/core/rtnetlink.c:2956
>  do_setlink.constprop.0+0xbd8/0x4380 net/core/rtnetlink.c:3158
>  rtnl_changelink net/core/rtnetlink.c:3769 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3928 [inline]
>  rtnl_newlink+0x1446/0x2000 net/core/rtnetlink.c:4065
>  rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6951
>  netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
>  netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>  netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
>  netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1896
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg net/socket.c:742 [inline]
>  __sys_sendto+0x4a3/0x520 net/socket.c:2244
>  __do_sys_sendto net/socket.c:2251 [inline]
>  __se_sys_sendto net/socket.c:2247 [inline]
>  __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2247
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 15061:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:77
>  __kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:587
>  kasan_save_free_info mm/kasan/kasan.h:406 [inline]
>  poison_slab_object mm/kasan/common.c:252 [inline]
>  __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:284
>  kasan_slab_free include/linux/kasan.h:234 [inline]
>  slab_free_hook mm/slub.c:2539 [inline]
>  slab_free mm/slub.c:6630 [inline]
>  kfree+0x2b8/0x6d0 mm/slub.c:6837
>  kobject_cleanup lib/kobject.c:689 [inline]
>  kobject_release lib/kobject.c:720 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x1e7/0x5a0 lib/kobject.c:737
>  rcu_do_batch kernel/rcu/tree.c:2605 [inline]
>  rcu_core+0x79c/0x1530 kernel/rcu/tree.c:2861
>  handle_softirqs+0x219/0x8e0 kernel/softirq.c:622
>  __do_softirq kernel/softirq.c:656 [inline]
>  invoke_softirq kernel/softirq.c:496 [inline]
>  __irq_exit_rcu+0x109/0x170 kernel/softirq.c:723
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
>  sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1052
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
> 
> Last potentially related work creation:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
>  kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:559
>  __call_rcu_common.constprop.0+0xa5/0xa10 kernel/rcu/tree.c:3123
>  br_del_if+0xe0/0x270 net/bridge/br_if.c:740
>  do_set_master+0x172/0x730 net/core/rtnetlink.c:2940
>  do_setlink.constprop.0+0xbd8/0x4380 net/core/rtnetlink.c:3158
>  rtnl_group_changelink net/core/rtnetlink.c:3783 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3937 [inline]
>  rtnl_newlink+0x18e0/0x2000 net/core/rtnetlink.c:4065
>  rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6951
>  netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
>  netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>  netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
>  netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1896
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg net/socket.c:742 [inline]
>  ____sys_sendmsg+0xa98/0xc70 net/socket.c:2630
>  ___sys_sendmsg+0x134/0x1d0 net/socket.c:2684
>  __sys_sendmsg+0x16d/0x220 net/socket.c:2716
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff888025122800
>  which belongs to the cache kmalloc-1k of size 1024
> The buggy address is located 8 bytes inside of
>  freed 1024-byte region [ffff888025122800, ffff888025122c00)
> 
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888025125800 pfn:0x25120
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000240 ffff88813ffa6dc0 ffffea0001ee1810 ffffea0000c8c210
> raw: ffff888025125800 000000000010000e 00000000f5000000 0000000000000000
> head: 00fff00000000240 ffff88813ffa6dc0 ffffea0001ee1810 ffffea0000c8c210
> head: ffff888025125800 000000000010000e 00000000f5000000 0000000000000000
> head: 00fff00000000003 ffffea0000944801 00000000ffffffff 00000000ffffffff
> head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5807, tgid 5807 (syz-executor), ts 72613372336, free_ts 72596370994
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1850
>  prep_new_page mm/page_alloc.c:1858 [inline]
>  get_page_from_freelist+0x10a3/0x3a30 mm/page_alloc.c:3884
>  __alloc_frozen_pages_noprof+0x25f/0x2470 mm/page_alloc.c:5183
>  alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
>  alloc_slab_page mm/slub.c:3055 [inline]
>  allocate_slab mm/slub.c:3228 [inline]
>  new_slab+0x24a/0x360 mm/slub.c:3282
>  ___slab_alloc+0xdae/0x1a60 mm/slub.c:4651
>  __slab_alloc.constprop.0+0x63/0x110 mm/slub.c:4770
>  __slab_alloc_node mm/slub.c:4846 [inline]
>  slab_alloc_node mm/slub.c:5268 [inline]
>  __do_kmalloc_node mm/slub.c:5641 [inline]
>  __kmalloc_noprof+0x501/0x880 mm/slub.c:5654
>  kmalloc_noprof include/linux/slab.h:961 [inline]
>  kzalloc_noprof include/linux/slab.h:1094 [inline]
>  __alloc_workqueue+0x112/0x1810 kernel/workqueue.c:5715
>  alloc_workqueue_noprof+0xd2/0x200 kernel/workqueue.c:5818
>  wg_newlink+0x24d/0x780 drivers/net/wireguard/device.c:341
>  rtnl_newlink_create net/core/rtnetlink.c:3833 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3950 [inline]
>  rtnl_newlink+0xc45/0x2000 net/core/rtnetlink.c:4065
>  rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6951
>  netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
>  netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>  netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
>  netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1896
> page last free pid 5809 tgid 5809 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1394 [inline]
>  __free_frozen_pages+0x7df/0x1160 mm/page_alloc.c:2906
>  qlink_free mm/kasan/quarantine.c:163 [inline]
>  qlist_free_all+0x4d/0x120 mm/kasan/quarantine.c:179
>  kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
>  __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:352
>  kasan_slab_alloc include/linux/kasan.h:252 [inline]
>  slab_post_alloc_hook mm/slub.c:4970 [inline]
>  slab_alloc_node mm/slub.c:5280 [inline]
>  __kmalloc_cache_noprof+0x274/0x780 mm/slub.c:5758
>  kmalloc_noprof include/linux/slab.h:957 [inline]
>  kzalloc_noprof include/linux/slab.h:1094 [inline]
>  kset_create lib/kobject.c:965 [inline]
>  kset_create_and_add+0x4d/0x190 lib/kobject.c:1008
>  register_queue_kobjects net/core/net-sysfs.c:2106 [inline]
>  netdev_register_kobject+0x1ef/0x3d0 net/core/net-sysfs.c:2362
>  register_netdevice+0x13dc/0x2270 net/core/dev.c:11294
>  ipcaif_newlink+0x73/0x2c0 net/caif/chnl_net.c:452
>  rtnl_newlink_create net/core/rtnetlink.c:3833 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3950 [inline]
>  rtnl_newlink+0xc45/0x2000 net/core/rtnetlink.c:4065
>  rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6951
>  netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
>  netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>  netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
>  netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1896
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg net/socket.c:742 [inline]
>  __sys_sendto+0x4a3/0x520 net/socket.c:2244
>  __do_sys_sendto net/socket.c:2251 [inline]
>  __se_sys_sendto net/socket.c:2247 [inline]
>  __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2247
> 
> Memory state around the buggy address:
>  ffff888025122700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888025122780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ffff888025122800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                       ^
>  ffff888025122880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888025122900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

