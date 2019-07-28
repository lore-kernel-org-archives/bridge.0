Return-Path: <3EK89XQkbAFUFLM7x881ExCC50.3BB381HF1EzBAG1AG.zB9@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Sun, 28 Jul 2019 07:20:00 -0700
In-Reply-To: <0000000000005e6124058c0cbdbe@google.com>
Message-ID: <0000000000008be1b2058ebe7805@google.com>
From: syzbot <syzbot+88533dc8b582309bf3ee@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Subject: Re: [Bridge] memory leak in fdb_create
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, bsingharora@gmail.com, coreteam@netfilter.org, davem@davemloft.net, duwe@suse.de, kaber@trash.net, kadlec@blackhole.kfki.hu, linux-kernel@vger.kernel.org, mingo@redhat.com, mpe@ellerman.id.au, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, nikolay@cumulusnetworks.com, pablo@netfilter.org, roopa@cumulusnetworks.com, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com

syzbot has bisected this bug to:

commit 04cf31a759ef575f750a63777cee95500e410994
Author: Michael Ellerman <mpe@ellerman.id.au>
Date:   Thu Mar 24 11:04:01 2016 +0000

     ftrace: Make ftrace_location_range() global

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1538c778600000
start commit:   abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1738c778600000
console output: https://syzkaller.appspot.com/x/log.txt?x=1338c778600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56f1da14935c3cce
dashboard link: https://syzkaller.appspot.com/bug?extid=88533dc8b582309bf3ee
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16de5c06a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10546026a00000

Reported-by: syzbot+88533dc8b582309bf3ee@syzkaller.appspotmail.com
Fixes: 04cf31a759ef ("ftrace: Make ftrace_location_range() global")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
