Return-Path: <3zcAaZQkbAOgcijUKVVObKZZSN.QYYQVOecObMYXdOXd.MYW@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0CA158217D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 284DB82179
MIME-Version: 1.0
Date: Mon, 02 Oct 2023 06:08:29 -0700
In-Reply-To: <000000000000c4c9d405f2643e01@google.com>
Message-ID: <0000000000006ba21a0606bb78f9@google.com>
From: syzbot <syzbot+d7b7f1412c02134efa6d@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [syzbot] [bridge?] possible deadlock in
	br_multicast_rcv (3)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: amcohen@nvidia.com, axboe@fb.com, bridge@lists.linux-foundation.org, davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, hch@lst.de, hdanton@sina.com, idosch@nvidia.com, ivecera@redhat.com, jiri@resnulli.us, kbusch@kernel.org, kuba@kernel.org, lengchao@huawei.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com, netdev@vger.kernel.org, pabeni@redhat.com, razor@blackwall.org, roopa@nvidia.com, sagi@grimberg.me, syzkaller-bugs@googlegroups.com, trix@redhat.com

syzbot has bisected this issue to:

commit 0ae3eb7b4611207e140e9772398b9f88b72d6839
Author: Amit Cohen <amcohen@nvidia.com>
Date:   Mon Feb 1 19:47:49 2021 +0000

    netdevsim: fib: Perform the route programming in a non-atomic context

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13afdae6680000
start commit:   2faac9a98f01 Merge tag 'keys-fixes-20230321' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=106fdae6680000
console output: https://syzkaller.appspot.com/x/log.txt?x=17afdae6680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aaa4b45720ca0519
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b7f1412c02134efa6d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14aea34ec80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13001e91c80000

Reported-by: syzbot+d7b7f1412c02134efa6d@syzkaller.appspotmail.com
Fixes: 0ae3eb7b4611 ("netdevsim: fib: Perform the route programming in a non-atomic context")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
