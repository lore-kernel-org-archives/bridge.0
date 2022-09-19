Return-Path: <36vooYwkbAKMVbcNDOOHUDSSLG.JRRJOHXVHUFRQWHQW.FRP@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9CCF140241
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9282140140
MIME-Version: 1.0
Date: Mon, 19 Sep 2022 16:27:38 -0700
Message-ID: <000000000000b010bd05e9100e11@google.com>
From: syzbot <syzbot+a24c5252f3e3ab733464@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Bridge] [syzbot] memory leak in do_replace
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, fw@strlen.de, kadlec@netfilter.org, kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, razor@blackwall.org, roopa@nvidia.com, syzkaller-bugs@googlegroups.com

Hello,

syzbot found the following issue on:

HEAD commit:    3245cb65fd91 Merge tag 'devicetree-fixes-for-6.0-2' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a88ef7080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4afe4efcad47dde
dashboard link: https://syzkaller.appspot.com/bug?extid=a24c5252f3e3ab733464
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b0e87f080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1100f1d8880000

Downloadable assets:
disk image: https://storage.googleapis.com/2d6c9d59c55a/disk-3245cb65.raw.xz
vmlinux: https://storage.googleapis.com/0f52632026ad/vmlinux-3245cb65.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a24c5252f3e3ab733464@syzkaller.appspotmail.com

executing program
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffffc90000ded000 (size 4096):
  comm "syz-executor317", pid 3615, jiffies 4294946120 (age 22.550s)
  hex dump (first 32 bytes):
    90 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8153105f>] __vmalloc_node_range+0xb3f/0xbd0 mm/vmalloc.c:3224
    [<ffffffff81531239>] __vmalloc_node mm/vmalloc.c:3261 [inline]
    [<ffffffff81531239>] __vmalloc+0x49/0x50 mm/vmalloc.c:3275
    [<ffffffff83e28027>] do_replace+0x197/0x340 net/bridge/netfilter/ebtables.c:1131
    [<ffffffff83e2880c>] do_ebt_set_ctl+0x22c/0x310 net/bridge/netfilter/ebtables.c:2520
    [<ffffffff83a3fb68>] nf_setsockopt+0x68/0xa0 net/netfilter/nf_sockopt.c:101
    [<ffffffff83bb5d69>] ip_setsockopt+0x259/0x2040 net/ipv4/ip_sockglue.c:1444
    [<ffffffff83bcbe10>] tcp_setsockopt+0x70/0x1430 net/ipv4/tcp.c:3789
    [<ffffffff8425d1d8>] smc_setsockopt+0xd8/0x5c0 net/smc/af_smc.c:2941
    [<ffffffff8386dd2b>] __sys_setsockopt+0x1ab/0x380 net/socket.c:2252
    [<ffffffff8386df22>] __do_sys_setsockopt net/socket.c:2263 [inline]
    [<ffffffff8386df22>] __se_sys_setsockopt net/socket.c:2260 [inline]
    [<ffffffff8386df22>] __x64_sys_setsockopt+0x22/0x30 net/socket.c:2260
    [<ffffffff845eab35>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845eab35>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffffc90000df5000 (size 4096):
  comm "syz-executor317", pid 3615, jiffies 4294946120 (age 22.550s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8153105f>] __vmalloc_node_range+0xb3f/0xbd0 mm/vmalloc.c:3224
    [<ffffffff81531239>] __vmalloc_node mm/vmalloc.c:3261 [inline]
    [<ffffffff81531239>] __vmalloc+0x49/0x50 mm/vmalloc.c:3275
    [<ffffffff83e28071>] do_replace+0x1e1/0x340 net/bridge/netfilter/ebtables.c:1138
    [<ffffffff83e2880c>] do_ebt_set_ctl+0x22c/0x310 net/bridge/netfilter/ebtables.c:2520
    [<ffffffff83a3fb68>] nf_setsockopt+0x68/0xa0 net/netfilter/nf_sockopt.c:101
    [<ffffffff83bb5d69>] ip_setsockopt+0x259/0x2040 net/ipv4/ip_sockglue.c:1444
    [<ffffffff83bcbe10>] tcp_setsockopt+0x70/0x1430 net/ipv4/tcp.c:3789
    [<ffffffff8425d1d8>] smc_setsockopt+0xd8/0x5c0 net/smc/af_smc.c:2941
    [<ffffffff8386dd2b>] __sys_setsockopt+0x1ab/0x380 net/socket.c:2252
    [<ffffffff8386df22>] __do_sys_setsockopt net/socket.c:2263 [inline]
    [<ffffffff8386df22>] __se_sys_setsockopt net/socket.c:2260 [inline]
    [<ffffffff8386df22>] __x64_sys_setsockopt+0x22/0x30 net/socket.c:2260
    [<ffffffff845eab35>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845eab35>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
