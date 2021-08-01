Return-Path: <hdanton@sina.com>
From: Hillf Danton <hdanton@sina.com>
Date: Sun,  1 Aug 2021 21:14:06 +0800
Message-Id: <20210801131406.1750-1-hdanton@sina.com>
In-Reply-To: <00000000000014105005c87cffdc@google.com>
References: <00000000000014105005c87cffdc@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [syzbot] possible deadlock in br_ioctl_call
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: syzbot <syzbot+34fe5894623c4ab1b379@syzkaller.appspotmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>

On Sun, 01 Aug 2021 03:34:24 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    3bdc70669eb2 Merge branch 'devlink-register'
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11ee370a300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=914a8107c0ffdc14
> dashboard link: https://syzkaller.appspot.com/bug?extid=34fe5894623c4ab1b379
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114398c6300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d6d61a300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+34fe5894623c4ab1b379@syzkaller.appspotmail.com
> 
> netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
> netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
> netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.14.0-rc2-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor772/8460 is trying to acquire lock:
> ffffffff8d0a9608 (br_ioctl_mutex){+.+.}-{3:3}, at: br_ioctl_call+0x3b/0xa0 net/socket.c:1089
> 
> but task is already holding lock:
> ffffffff8d0cb568 (rtnl_mutex){+.+.}-{3:3}, at: dev_ioctl+0x1a7/0xee0 net/core/dev_ioctl.c:579
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (rtnl_mutex){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:959 [inline]
>        __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
>        register_netdev+0x11/0x50 net/core/dev.c:10474
>        br_add_bridge+0x97/0xf0 net/bridge/br_if.c:459
>        br_ioctl_stub+0x750/0x7f0 net/bridge/br_ioctl.c:390
>        br_ioctl_call+0x5e/0xa0 net/socket.c:1091
>        sock_ioctl+0x30c/0x640 net/socket.c:1185
>        vfs_ioctl fs/ioctl.c:51 [inline]
>        __do_sys_ioctl fs/ioctl.c:1069 [inline]
>        __se_sys_ioctl fs/ioctl.c:1055 [inline]
>        __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #0 (br_ioctl_mutex){+.+.}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:3051 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3174 [inline]
>        validate_chain kernel/locking/lockdep.c:3789 [inline]
>        __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
>        lock_acquire kernel/locking/lockdep.c:5625 [inline]
>        lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
>        __mutex_lock_common kernel/locking/mutex.c:959 [inline]
>        __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
>        br_ioctl_call+0x3b/0xa0 net/socket.c:1089
>        dev_ifsioc+0xc1f/0xf60 net/core/dev_ioctl.c:382
>        dev_ioctl+0x1b9/0xee0 net/core/dev_ioctl.c:580
>        sock_do_ioctl+0x18b/0x210 net/socket.c:1128
>        sock_ioctl+0x2f1/0x640 net/socket.c:1231
>        vfs_ioctl fs/ioctl.c:51 [inline]
>        __do_sys_ioctl fs/ioctl.c:1069 [inline]
>        __se_sys_ioctl fs/ioctl.c:1055 [inline]
>        __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(rtnl_mutex);
>                                lock(br_ioctl_mutex);
>                                lock(rtnl_mutex);
>   lock(br_ioctl_mutex);
> 
>  *** DEADLOCK ***

Fix it by doing bridge ioctl outside rtnl lock after checking netdev present
and bumping up its reference. Recheck netdev state (or take rtnl lock) after
acquiring br_ioctl_mutex with a stable netdev.

Now only for thoughts.

+++ x/net/core/dev_ioctl.c
@@ -379,7 +379,12 @@ static int dev_ifsioc(struct net *net, s
 	case SIOCBRDELIF:
 		if (!netif_device_present(dev))
 			return -ENODEV;
-		return br_ioctl_call(net, netdev_priv(dev), cmd, ifr, NULL);
+		dev_hold(dev);
+		rtnl_unlock();
+		err = br_ioctl_call(net, netdev_priv(dev), cmd, ifr, NULL);
+		dev_put(dev);
+		rtnl_lock();
+		return err;
 
 	case SIOCSHWTSTAMP:
 		err = net_hwtstamp_validate(ifr);
