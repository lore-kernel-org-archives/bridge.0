Return-Path: <dvyukov@google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=YvkFVNaKgyfaWCCit+lJl0+4kfZHwo/7+Xv7+ypm2QQ=;
	b=pk2icfzvaf0IJeA0sPJsS4yaWHRrBTIlL6p/orbpWmDRPdeYXSNblsgwK/cg+ROCYE
	8rENbkgeSiDNIJwFmqsxk6NNyDLv3WTSSs8QDo9GfJZ77azRwnys4UTvXG9yf5ixQS0C
	hVXIqclW+TQ3y7QQ0NUehCruXKLRY8kzv5eySkc23AxcAobg/op39650siqiLig7X7WW
	+IzgZAprJu0DP+zWQbj0F4lyYQ4RPp+/Kn3r74oqdpaxJdYNABf8al9QtHJ+67gu6TiQ
	tlp7c1y25eJe7HAKIdVa9HwQU9YrISpek7mVRSG3ZAZcdTq5eszash0c+vMlj4iHVa99
	lOZQ==
MIME-Version: 1.0
References: <000000000000862b160580765e94@google.com>
	<3c44c1ff-2790-ec06-35c6-3572b92170c7@cumulusnetworks.com>
In-Reply-To: <3c44c1ff-2790-ec06-35c6-3572b92170c7@cumulusnetworks.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 28 Jan 2019 09:28:36 +0100
Message-ID: <CACT4Y+ZA8gBURbeZaDtrt5NoqFy8a8W3jyaWbs34Qjic4Bu+DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] KASAN: use-after-free Read in br_mdb_ip_get
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, syzbot <syzbot+bc5ab0af2dbf3b0ae897@syzkaller.appspotmail.com>, David Miller <davem@davemloft.net>

On Sun, Jan 27, 2019 at 10:34 PM Nikolay Aleksandrov
<nikolay@cumulusnetworks.com> wrote:
>
> On 27/01/2019 22:26, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    ba6069759381 Merge tag 'mmc-v5.0-rc2' of git://git.kernel...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17b342c4c00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
> > dashboard link: https://syzkaller.appspot.com/bug?extid=bc5ab0af2dbf3b0ae897
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> >Unfortunately,I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+bc5ab0af2dbf3b0ae897@syzkaller.appspotmail.com
> >
> > bridge0: port 2(bridge_slave_1) entered blocking state
> > bridge0: port 2(bridge_slave_1) entered forwarding state
> > bridge0: port 1(bridge_slave_0) entered blocking state
> > bridge0: port 1(bridge_slave_0) entered forwarding state
> > ==================================================================
> > BUG: KASAN: use-after-free in memcmp+0xb3/0xc0 lib/string.c:862
> > Read of size 1 at addr ffff88809f1efe70 by task syz-executor1/8111
> >
> [snip]
> >
> >Allocated by task 8111:
> >  save_stack+0x45/0xd0 mm/kasan/common.c:73
> >  set_track mm/kasan/common.c:85 [inline]
> >  __kasan_kmalloc mm/kasan/common.c:496 [inline]
> >  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:469
> >  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:504
> >  kmem_cache_alloc_trace+0x151/0x760 mm/slab.c:3609
> >  kmalloc include/linux/slab.h:545 [inline]
> >  kzalloc include/linux/slab.h:740 [inline]
> >  br_multicast_new_group.part.0+0xdc/0x1a40 net/bridge/br_multicast.c:476
> >  br_multicast_new_group+0x19d/0x200 net/bridge/br_multicast.c:471
> >  br_multicast_add_group+0x4ce/0x7d0 net/bridge/br_multicast.c:552
> >br_ip6_multicast_add_group net/bridge/br_multicast.c:626 [inline]
> >  br_ip6_multicast_mld2_report net/bridge/br_multicast.c:1043 [inline]
> >  br_multicast_ipv6_rcv net/bridge/br_multicast.c:1667 [inline]
> >  br_multicast_rcv+0x24aa/0x4270 net/bridge/br_multicast.c:1705
> >  br_dev_xmit+0x7f4/0x1780 net/bridge/br_device.c:93
> >  __netdev_start_xmit include/linux/netdevice.h:4382 [inline]
> >  netdev_start_xmit include/linux/netdevice.h:4391 [inline]
> >  xmit_one net/core/dev.c:3278 [inline]
> >  dev_hard_start_xmit+0x261/0xc70 net/core/dev.c:3294
> >  __dev_queue_xmit+0x2f8a/0x3a60 net/core/dev.c:3864
> >  dev_queue_xmit+0x18/0x20 net/core/dev.c:3897
> >  neigh_resolve_output net/core/neighbour.c:1476 [inline]
> >  neigh_resolve_output+0x6a0/0xb30 net/core/neighbour.c:1456
> >  neigh_output include/net/neighbour.h:508 [inline]
> >  ip6_finish_output2+0xc56/0x28e0 net/ipv6/ip6_output.c:120
> >  ip6_finish_output+0x577/0xc30 net/ipv6/ip6_output.c:154
> >  NF_HOOK_COND include/linux/netfilter.h:278 [inline]
> >  ip6_output+0x23c/0xa00 net/ipv6/ip6_output.c:171
> >  dst_output include/net/dst.h:444 [inline]
> >  NF_HOOK include/linux/netfilter.h:289 [inline]
> >  NF_HOOK include/linux/netfilter.h:283 [inline]
> >  mld_sendpack+0xa44/0xfd0 net/ipv6/mcast.c:1683
> >  mld_send_cr net/ipv6/mcast.c:1979 [inline]
> >  mld_ifc_timer_expire+0x449/0x8a0 net/ipv6/mcast.c:2478
> >  call_timer_fn+0x254/0x900 kernel/time/timer.c:1325
> >  expire_timers kernel/time/timer.c:1362 [inline]
> >  __run_timers+0x6fc/0xd50 kernel/time/timer.c:1681
> >  run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1694
> >  __do_softirq+0x30b/0xb11 kernel/softirq.c:292
> >
> > Freed by task 8111:
> >  save_stack+0x45/0xd0 mm/kasan/common.c:73
> >  set_track mm/kasan/common.c:85 [inline]
> >  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:458
> >  kasan_slab_free+0xe/0x10 mm/kasan/common.c:466
> >  __cache_free mm/slab.c:3487 [inline]
> >  kfree+0xcf/0x230 mm/slab.c:3806
> >  br_multicast_new_group.part.0+0x1489/0x1a40 net/bridge/br_multicast.c:486
>
>
> Weird, this is the kfree() on the error path of br_multicast_new_group()
> when rhashtable_lookup_insert_fast() fails, which means the entry should
> not be linked in the rhashtable or the hlist.
> All other frees are via kfree_rcu. I'll keep looking..

Humm.... +rhashtable.c maintianers

The code in br_multicast_new_group is effectively:

mp = kzalloc(sizeof(*mp), GFP_ATOMIC);
err = rhashtable_lookup_insert_fast(&br->mdb_hash_tbl, &mp->rhnode,
br_mdb_rht_params);
if (err)
    kfree(mp);

So it looks like rhashtable_lookup_insert_fast both returned an error
and left the new object linked in the table. Since it happened only
once, it may have something to do with concurrent resizing/shrinking.


> >  br_multicast_new_group+0x19d/0x200 net/bridge/br_multicast.c:471
> >  br_multicast_add_group+0x4ce/0x7d0 net/bridge/br_multicast.c:552
> >  br_ip6_multicast_add_group net/bridge/br_multicast.c:626 [inline]
> >  br_ip6_multicast_mld2_report net/bridge/br_multicast.c:1043 [inline]
> >  br_multicast_ipv6_rcv net/bridge/br_multicast.c:1667 [inline]
> >  br_multicast_rcv+0x24aa/0x4270 net/bridge/br_multicast.c:1705
> >  br_dev_xmit+0x7f4/0x1780 net/bridge/br_device.c:93
> >  __netdev_start_xmit include/linux/netdevice.h:4382 [inline]
> >  netdev_start_xmit include/linux/netdevice.h:4391 [inline]
> >  xmit_one net/core/dev.c:3278 [inline]
> > dev_hard_start_xmit+0x261/0xc70 net/core/dev.c:3294
> >  __dev_queue_xmit+0x2f8a/0x3a60 net/core/dev.c:3864
> >  dev_queue_xmit+0x18/0x20 net/core/dev.c:3897
> >  neigh_resolve_output net/core/neighbour.c:1476 [inline]
> >  neigh_resolve_output+0x6a0/0xb30 net/core/neighbour.c:1456
> >  neigh_output include/net/neighbour.h:508 [inline]
> >  ip6_finish_output2+0xc56/0x28e0 net/ipv6/ip6_output.c:120
> >  ip6_finish_output+0x577/0xc30 net/ipv6/ip6_output.c:154
> > NF_HOOK_COND include/linux/netfilter.h:278 [inline]
> >  ip6_output+0x23c/0xa00 net/ipv6/ip6_output.c:171
> >  dst_output include/net/dst.h:444 [inline]
> >  NF_HOOK include/linux/netfilter.h:289 [inline]
> >  NF_HOOK include/linux/netfilter.h:283 [inline]
> >  mld_sendpack+0xa44/0xfd0 net/ipv6/mcast.c:1683
> >  mld_send_cr net/ipv6/mcast.c:1979 [inline]
> >  mld_ifc_timer_expire+0x449/0x8a0 net/ipv6/mcast.c:2478
> >  call_timer_fn+0x254/0x900 kernel/time/timer.c:1325
> >  expire_timers kernel/time/timer.c:1362 [inline]
> >  __run_timers+0x6fc/0xd50 kernel/time/timer.c:1681
> >  run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1694
> >  __do_softirq+0x30b/0xb11 kernel/softirq.c:292
> >
> > The buggy address belongs to the object at ffff88809f1efe00
> >  which belongs to the cache kmalloc-192 of size 192
> > The buggy address is located 112 bytes inside of
> >  192-byte region [ffff88809f1efe00,ffff88809f1efec0)
> > The buggy address belongs to the page:
> > page:ffffea00027c7bc0 count:1 mapcount:0 mapping:ffff88812c3f0040 index:0x0
> > flags: 0x1fffc0000000200(slab)
> > raw: 01fffc0000000200 ffffea00027df108 ffffea00027c7c48 ffff88812c3f0040
> > raw: 0000000000000000 ffff88809f1ef000 0000000100000010 0000000000000000
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >  ffff88809f1efd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >  ffff88809f1efd80: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >> ffff88809f1efe00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                                                             ^
> >  ffff88809f1efe80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> >  ffff88809f1eff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ==================================================================
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> >syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
>
> --
>You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/3c44c1ff-2790-ec06-35c6-3572b92170c7%40cumulusnetworks.com.
> For more options, visit https://groups.google.com/d/optout.
