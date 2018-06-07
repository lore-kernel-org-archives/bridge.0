Return-Path: <dvyukov@google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=lHVxpV2EVdoYKc/fwrqIwN6GkUal5OunsOkx8ZOJZrU=;
	b=I4gPZYUgcpTv0HReIKY9z5TY6KbvTi9sWGMadBhdVx4fW6CZYdnXo6lO9TM62M4gIx
	CTuWTioIMbJwbD/W7ZynYr3Fl3bFNpRbelP1zp7qFV9K3wRVyh7H4Xi+P70J6p9Nq3fD
	qbVmG/++NbBPvo8JKiVi/SJLQKAWHtmF+tiVsHGrAfCWz1zOAyg2C2UEcD1fZDXyJEDK
	VKXBDe8D+Nc9PpCk9UE9PODnWfHMgZA6IvnAZc6lt87vCXY8zklTboj9CNuAB07ttQ0Z
	VR6IXExlJ0nVQq1fMf8iWqHbD9c4zFL7OY1aQ61j1JnroQnuobClokbXHgSErpzUId5N
	Rngw==
MIME-Version: 1.0
In-Reply-To: <0000000000009a3b5b056e109e42@google.com>
References: <0000000000009a3b5b056e109e42@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 7 Jun 2018 19:34:10 +0200
Message-ID: <CACT4Y+Ym9AV7rRi+EBPst_CeiA1CZy3RkgiQOvAm6zJ-Y4XA=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] KMSAN: uninit-value in ebt_stp_mt_check (2)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: syzbot <syzbot+da4494182233c23a5fcf@syzkaller.appspotmail.com>
Cc: netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, LKML <linux-kernel@vger.kernel.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, David Miller <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>

On Thu, Jun 7, 2018 at 7:29 PM, syzbot
<syzbot+da4494182233c23a5fcf@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    c6a6aed994b6 kmsan: remove dead code to trigger syzbot build
> git tree:       https://github.com/google/kmsan.git/master
> console output: https://syzkaller.appspot.com/x/log.txt?x=17bde74f800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=848e40757852af3e
> dashboard link: https://syzkaller.appspot.com/bug?extid=da4494182233c23a5fcf
> compiler:       clang version 7.0.0 (trunk 334104)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+da4494182233c23a5fcf@syzkaller.appspotmail.com

Hi Stephen,

This strikes again.

The first part of the check is par->nft_compat. I don't see where
ebt_check_entry initializes it. Should it? Or matches should not look at it?



> ==================================================================
> BUG: KMSAN: uninit-value in ebt_stp_mt_check+0x24b/0x450
> net/bridge/netfilter/ebt_stp.c:162
> CPU: 0 PID: 12006 Comm: syz-executor7 Not tainted 4.17.0+ #3
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
>  kmsan_report+0x149/0x260 mm/kmsan/kmsan.c:1084
>  __msan_warning_32+0x6e/0xc0 mm/kmsan/kmsan_instr.c:620
>  ebt_stp_mt_check+0x24b/0x450 net/bridge/netfilter/ebt_stp.c:162
>  xt_check_match+0x1438/0x1650 net/netfilter/x_tables.c:506
>  ebt_check_match net/bridge/netfilter/ebtables.c:372 [inline]
>  ebt_check_entry net/bridge/netfilter/ebtables.c:702 [inline]
>  translate_table+0x4e88/0x6120 net/bridge/netfilter/ebtables.c:943
>  do_replace_finish+0x1258/0x2ea0 net/bridge/netfilter/ebtables.c:999
>  do_replace+0x719/0x780 net/bridge/netfilter/ebtables.c:1138
>  do_ebt_set_ctl+0x2ab/0x3c0 net/bridge/netfilter/ebtables.c:1517
>  nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
>  nf_setsockopt+0x47c/0x4e0 net/netfilter/nf_sockopt.c:115
>  ip_setsockopt+0x24b/0x2b0 net/ipv4/ip_sockglue.c:1251
>  udp_setsockopt+0x108/0x1b0 net/ipv4/udp.c:2416
>  sock_common_setsockopt+0x13b/0x170 net/core/sock.c:3039
>  __sys_setsockopt+0x496/0x540 net/socket.c:1903
>  __do_sys_setsockopt net/socket.c:1914 [inline]
>  __se_sys_setsockopt net/socket.c:1911 [inline]
>  __x64_sys_setsockopt+0x15c/0x1c0 net/socket.c:1911
>  do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x4559f9
> RSP: 002b:00007f45b9246c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 00007f45b92476d4 RCX: 00000000004559f9
> RDX: 0000000000000080 RSI: 0000000000000000 RDI: 0000000000000014
> RBP: 000000000072bea0 R08: 0000000000000300 R09: 0000000000000000
> R10: 0000000020000480 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000004c0d6d R14: 00000000004d07c8 R15: 0000000000000000
>
> Local variable description: ----mtpar.i@translate_table
> Variable was created at:
>  translate_table+0xbb/0x6120 net/bridge/netfilter/ebtables.c:831
>  do_replace_finish+0x1258/0x2ea0 net/bridge/netfilter/ebtables.c:999
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000009a3b5b056e109e42%40google.com.
> For more options, visit https://groups.google.com/d/optout.
