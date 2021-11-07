Return-Path: <34qiHYQkbAGUVbcNDOOHUDSSLG.JRRJOHXVHUFRQWHQW.FRP@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Sun, 07 Nov 2021 02:22:26 -0800
Message-ID: <000000000000b48a3d05d03040f8@google.com>
From: syzbot <syzbot+11e187621fbc19749a18@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Bridge] [syzbot] BUG: TASK stack guard page was hit at ADDR (stack
	is ADDR..ADDR)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, syzkaller-bugs@googlegroups.com

Hello,

syzbot found the following issue on:

HEAD commit:    cc0356d6a02e Merge tag 'x86_core_for_v5.16_rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108bb246b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5d447cdc3ae81d9
dashboard link: https://syzkaller.appspot.com/bug?extid=11e187621fbc19749a18
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+11e187621fbc19749a18@syzkaller.appspotmail.com

BUG: TASK stack guard page was hit at ffffc9000d447fc8 (stack is ffffc9000d448000..ffffc9000d450000)
stack guard page: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 383 Comm: syz-executor.0 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mark_lock+0x23/0x17b0 kernel/locking/lockdep.c:4554
Code: 84 00 00 00 00 00 90 41 57 41 56 41 55 41 54 41 89 d4 48 ba 00 00 00 00 00 fc ff df 55 53 48 81 ec 18 01 00 00 48 8d 5c 24 38 <48> 89 3c 24 48 c7 44 24 38 b3 8a b5 41 48 c1 eb 03 48 c7 44 24 40
RSP: 0018:ffffc9000d447fd8 EFLAGS: 00010096
RAX: 0000000000000000 RBX: ffffc9000d448010 RCX: ffffffff815c419d
RDX: dffffc0000000000 RSI: ffff88803a27e1d8 RDI: ffff88803a27d700
RBP: 0000000000000002 R08: 0000000000000000 R09: ffffffff8fd38a07
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000008
R13: ffff88803a27d700 R14: ffff88803a27e160 R15: dffffc0000000000
FS:  00007f1792855700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000d447fc8 CR3: 000000017af51000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 mark_usage kernel/locking/lockdep.c:4514 [inline]
 __lock_acquire+0x8a7/0x54a0 kernel/locking/lockdep.c:4969
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 rcu_lock_acquire include/linux/rcupdate.h:268 [inline]
 rcu_read_lock include/linux/rcupdate.h:688 [inline]
 br_get_link_af_size_filtered+0xa7/0xbe0 net/bridge/br_netlink.c:104
 rtnl_link_get_af_size net/core/rtnetlink.c:598 [inline]
 if_nlmsg_size+0x40c/0xa50 net/core/rtnetlink.c:1039
 rtmsg_ifinfo_build_skb+0x5e/0x1a0 net/core/rtnetlink.c:3808
 rtmsg_ifinfo_event net/core/rtnetlink.c:3844 [inline]
 rtmsg_ifinfo_event net/core/rtnetlink.c:3835 [inline]
 rtnetlink_event+0x123/0x1d0 net/core/rtnetlink.c:5622
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_change_features+0x61/0xb0 net/core/dev.c:10075
 bond_compute_features+0x56c/0xaa0 drivers/net/bonding/bond_main.c:1471
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3638 [inline]
 bond_netdev_event+0x755/0xae0 drivers/net/bonding/bond_main.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2002
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 netdev_features_change net/core/dev.c:1374 [inline]
 netdev_sync_lower_features net/core/dev.c:9851 [inline]
 __netdev_update_features+0x986/0x1840 net/core/dev.c:10003
 netdev_update_features net/core/dev.c:10058 [inline]
 dev_disable_lro+0x8d/0x3e0 net/core/dev.c:1646
 br_add_if+0xb78/0x1f20 net/bridge/br_if.c:645
 add_del_if+0x10c/0x140 net/bridge/br_ioctl.c:98
 br_ioctl_stub+0x1d0/0x7e0 net/bridge/br_ioctl.c:407
 br_ioctl_call+0x5e/0xa0 net/socket.c:1092
 dev_ifsioc+0xcf8/0x10c0 net/core/dev_ioctl.c:386
 dev_ioctl+0x1b9/0xed0 net/core/dev_ioctl.c:585
 sock_do_ioctl+0x15a/0x230 net/socket.c:1132
 sock_ioctl+0x2f1/0x640 net/socket.c:1235
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f1795321ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1792855188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f17954350e0 RCX: 00007f1795321ae9
RDX: 0000000020000000 RSI: 00000000000089a2 RDI: 0000000000000004
RBP: 00007f179537bf25 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe1c04ac0f R14: 00007f1792855300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 2e97ffe52c6a9452 ]---
RIP: 0010:mark_lock+0x23/0x17b0 kernel/locking/lockdep.c:4554
Code: 84 00 00 00 00 00 90 41 57 41 56 41 55 41 54 41 89 d4 48 ba 00 00 00 00 00 fc ff df 55 53 48 81 ec 18 01 00 00 48 8d 5c 24 38 <48> 89 3c 24 48 c7 44 24 38 b3 8a b5 41 48 c1 eb 03 48 c7 44 24 40
RSP: 0018:ffffc9000d447fd8 EFLAGS: 00010096
RAX: 0000000000000000 RBX: ffffc9000d448010 RCX: ffffffff815c419d
RDX: dffffc0000000000 RSI: ffff88803a27e1d8 RDI: ffff88803a27d700
RBP: 0000000000000002 R08: 0000000000000000 R09: ffffffff8fd38a07
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000008
R13: ffff88803a27d700 R14: ffff88803a27e160 R15: dffffc0000000000
FS:  00007f1792855700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000d447fc8 CR3: 000000017af51000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	84 00                	test   %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	00 00                	add    %al,(%rax)
   6:	90                   	nop
   7:	41 57                	push   %r15
   9:	41 56                	push   %r14
   b:	41 55                	push   %r13
   d:	41 54                	push   %r12
   f:	41 89 d4             	mov    %edx,%r12d
  12:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  19:	fc ff df
  1c:	55                   	push   %rbp
  1d:	53                   	push   %rbx
  1e:	48 81 ec 18 01 00 00 	sub    $0x118,%rsp
  25:	48 8d 5c 24 38       	lea    0x38(%rsp),%rbx
* 2a:	48 89 3c 24          	mov    %rdi,(%rsp) <-- trapping instruction
  2e:	48 c7 44 24 38 b3 8a 	movq   $0x41b58ab3,0x38(%rsp)
  35:	b5 41
  37:	48 c1 eb 03          	shr    $0x3,%rbx
  3b:	48                   	rex.W
  3c:	c7                   	.byte 0xc7
  3d:	44 24 40             	rex.R and $0x40,%al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
