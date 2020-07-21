Return-Path: <3qEAXXwkbAIU178tjuun0jyyrm.pxxpun31n0lxw2nw2.lxv@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Tue, 21 Jul 2020 12:23:20 -0700
Message-ID: <0000000000005613c705aaf88e04@google.com>
From: syzbot <syzbot+4c0c011e71ae95a85ffe@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Bridge] BUG: MAX_LOCKDEP_CHAINS too low! (2)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, clang-built-linux@googlegroups.com, davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, syzkaller-bugs@googlegroups.com

Hello,

syzbot found the following issue on:

HEAD commit:    6a70f89c Merge tag 'nfs-for-5.8-3' of git://git.linux-nfs...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17607db3100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a160d1053fc89af5
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0c011e71ae95a85ffe
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ba6d7d100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b72dd7100000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4c0c011e71ae95a85ffe@syzkaller.appspotmail.com

BUG: MAX_LOCKDEP_CHAINS too low!
turning off the locking correctness validator.
CPU: 1 PID: 30234 Comm: kworker/u4:3 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: bond1453 bond_resend_igmp_join_requests_delayed
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 add_chain_cache kernel/locking/lockdep.c:3063 [inline]
 lookup_chain_cache_add kernel/locking/lockdep.c:3162 [inline]
 validate_chain kernel/locking/lockdep.c:3183 [inline]
 __lock_acquire.cold+0x11/0x3f8 kernel/locking/lockdep.c:4380
 lock_acquire+0x1f1/0xad0 kernel/locking/lockdep.c:4959
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:353 [inline]
 br_multicast_add_group+0x68/0x740 net/bridge/br_multicast.c:546
 br_ip6_multicast_add_group net/bridge/br_multicast.c:622 [inline]
 br_ip6_multicast_add_group net/bridge/br_multicast.c:606 [inline]
 br_ip6_multicast_mld2_report net/bridge/br_multicast.c:1048 [inline]
 br_multicast_ipv6_rcv net/bridge/br_multicast.c:1712 [inline]
 br_multicast_rcv+0x1083/0x4730 net/bridge/br_multicast.c:1747
 br_dev_xmit+0x708/0x1510 net/bridge/br_device.c:87
 __netdev_start_xmit include/linux/netdevice.h:4611 [inline]
 netdev_start_xmit include/linux/netdevice.h:4625 [inline]
 xmit_one net/core/dev.c:3556 [inline]
 dev_hard_start_xmit+0x193/0x950 net/core/dev.c:3572
 __dev_queue_xmit+0x2091/0x2d60 net/core/dev.c:4131
 bond_dev_queue_xmit+0xf8/0x1c0 drivers/net/bonding/bond_main.c:302
 bond_3ad_xor_xmit drivers/net/bonding/bond_main.c:4258 [inline]
 __bond_start_xmit drivers/net/bonding/bond_main.c:4398 [inline]
 bond_start_xmit+0x534/0xfc0 drivers/net/bonding/bond_main.c:4426
 __netdev_start_xmit include/linux/netdevice.h:4611 [inline]
 netdev_start_xmit include/linux/netdevice.h:4625 [inline]
 xmit_one net/core/dev.c:3556 [inline]
 dev_hard_start_xmit+0x193/0x950 net/core/dev.c:3572
 __dev_queue_xmit+0x2091/0x2d60 net/core/dev.c:4131
 neigh_hh_output include/net/neighbour.h:498 [inline]
 neigh_output include/net/neighbour.h:507 [inline]
 ip6_finish_output2+0x7f1/0x17b0 net/ipv6/ip6_output.c:117
 __ip6_finish_output net/ipv6/ip6_output.c:143 [inline]
 __ip6_finish_output+0x447/0xab0 net/ipv6/ip6_output.c:128
 ip6_finish_output+0x34/0x1f0 net/ipv6/ip6_output.c:153
 NF_HOOK_COND include/linux/netfilter.h:296 [inline]
 ip6_output+0x1db/0x520 net/ipv6/ip6_output.c:176
 dst_output include/net/dst.h:443 [inline]
 NF_HOOK include/linux/netfilter.h:307 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 mld_sendpack+0x92a/0xdb0 net/ipv6/mcast.c:1679
 mld_send_report+0xc3/0x230 net/ipv6/mcast.c:1881
 ipv6_mc_rejoin_groups net/ipv6/mcast.c:2637 [inline]
 ipv6_mc_netdev_event+0x287/0x480 net/ipv6/mcast.c:2650
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
 call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
 call_netdevice_notifiers+0x79/0xa0 net/core/dev.c:2053
 bond_resend_igmp_join_requests_delayed+0x5d/0x170 drivers/net/bonding/bond_main.c:590
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
