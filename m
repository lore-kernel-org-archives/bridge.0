Return-Path: <dvyukov@google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=a7VDZZZXEiqpUMxR2epBNxlztcO5LubfSvEWeAapll0=;
	b=Vz0C3WZYb4Fp3TpqT1JFTOg1Qkg04LB86oOybiT+0mGl9+v3PhN9ZXGARPYtgjpwOb
	KcO4U3Pf66pRkxERFy90oHZYolwQlkRZ+833Rkup4yS4jQRY906taspbIcebxxziYhXc
	1qT1QcsDLIbrsyBuqFISXm5Ywsu5WZMeHtYtGat1JZx85XfjRs/MwhOGFYzN4Ht/6MGs
	lbnu7bCrJka72lJx1BmyFOAVzAAOFRhPXTecbCfQHGlTobrtmo3kpR+ejXLaoe6c/Yw6
	fqScI6EhIBHzdG52Qp+xaZHEO9q4bnA6j1pus9M7niedBcRN4Dti/1cuB42ynSOR+E1Q
	JKjw==
MIME-Version: 1.0
In-Reply-To: <001a113f8036fab00405620e4d72@google.com>
References: <001a1148d244c6f6f7055cd73fcd@google.com>
	<001a113f8036fab00405620e4d72@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 11 Apr 2018 16:57:50 +0200
Message-ID: <CACT4Y+bO2HN9Tuw2iMND9tD8578DNSOwUs7_W6Rvg-8oX5Qipw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] WARNING in kobject_add_internal
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: syzbot <syzbot+e204ced820ef739d71ef5438f5e1976a874abc8d@syzkaller.appspotmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, bridge@lists.linux-foundation.org, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>

On Fri, Jan 5, 2018 at 10:41 PM, syzbot
<syzbot+e204ced820ef739d71ef5438f5e1976a874abc8d@syzkaller.appspotmail.com>
wrote:
> syzkaller has found reproducer for the following crash on
> 89876f275e8d562912d9c238cd888b52065cf25c
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
>
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by:
> syzbot+e204ced820ef739d71ef5438f5e1976a874abc8d@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed.

#syz dup: WARNING: kobject bug in device_add

> ------------[ cut here ]------------
> kobject_add_internal failed for   (error: -12 parent: net)
> WARNING: CPU: 1 PID: 3494 at lib/kobject.c:244
> kobject_add_internal+0x3f6/0xbc0 lib/kobject.c:242
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 1 PID: 3494 Comm: syzkaller425998 Not tainted 4.15.0-rc6+ #249
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  panic+0x1e4/0x41c kernel/panic.c:183
>  __warn+0x1dc/0x200 kernel/panic.c:547
>  report_bug+0x211/0x2d0 lib/bug.c:184
>  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:1079
> RIP: 0010:kobject_add_internal+0x3f6/0xbc0 lib/kobject.c:242
> RSP: 0018:ffff8801c53c76f0 EFLAGS: 00010286
> RAX: dffffc0000000008 RBX: ffff8801bf5a88d8 RCX: ffffffff8159da9e
> RDX: 0000000000000000 RSI: 1ffff10038a78e99 RDI: ffff8801c53c73f8
> RBP: ffff8801c53c77e8 R08: 1ffff10038a78e5b R09: 0000000000000000
> R10: ffff8801c53c74b0 R11: 0000000000000000 R12: 1ffff10038a78ee4
> R13: 00000000fffffff4 R14: ffff8801d8359a80 R15: ffffffff86201980
>  kobject_add_varg lib/kobject.c:366 [inline]
>  kobject_add+0x132/0x1f0 lib/kobject.c:411
>  device_add+0x35d/0x1650 drivers/base/core.c:1787
>  netdev_register_kobject+0x183/0x360 net/core/net-sysfs.c:1604
>  register_netdevice+0xb2b/0x1010 net/core/dev.c:7698
>  tun_set_iff drivers/net/tun.c:2319 [inline]
>  __tun_chr_ioctl+0x1d89/0x3dd0 drivers/net/tun.c:2524
>  tun_chr_ioctl+0x2a/0x40 drivers/net/tun.c:2773
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>  entry_SYSCALL_64_fastpath+0x23/0x9a
> RIP: 0033:0x444fc9
> RSP: 002b:00007fff53389dc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000444fc9
> RDX: 0000000020533000 RSI: 00000000400454ca RDI: 0000000000000004
> RBP: 0000000000000005 R08: 0000000000000002 R09: 0000006f00003131
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402500
> R13: 0000000000402590 R14: 0000000000000000 R15: 0000000000000000
>
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
