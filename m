Return-Path: <34YezXAkbAKocijUKVVObKZZSN.QYYQVOecObMYXdOXd.MYW@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Sun, 14 Apr 2019 12:20:01 -0700
In-Reply-To: <001a113dea0ef7d2620566c15bac@google.com>
Message-ID: <00000000000019eb000586826c2a@google.com>
From: syzbot <syzbot+659574e7bcc7f7eb4df7@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Subject: Re: [Bridge] WARNING in compat_copy_entries (2)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: alexl@redhat.com, bridge@lists.linux-foundation.org, coreteam@netfilter.org, cosimo@endlessm.com, davem@davemloft.net, dvyukov@google.com, fw@strlen.de, kadlec@blackhole.kfki.hu, libc-alpha@sourceware.org, linux-kernel@vger.kernel.org, luto@amacapital.net, luto@kernel.org, mingo@kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, nicholson@endlessm.com, pablo@netfilter.org, peterz@infradead.org, raji@linux.vnet.ibm.com, stephen@networkplumber.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, torvalds@linux-foundation.org, tuliom@linux.vnet.ibm.com

syzbot has bisected this bug to:

commit 9dea5dc921b5f4045a18c63eb92e84dc274d17eb
Author: Andy Lutomirski <luto@kernel.org>
Date:   Tue Jul 14 22:24:24 2015 +0000

     x86/entry/syscalls: Wire up 32-bit direct socket calls

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1736919f200000
start commit:   ce380619 Merge tag 'please-pull-ia64_misc' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b6919f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36fbc8c97ef985d3
dashboard link: https://syzkaller.appspot.com/bug?extid=659574e7bcc7f7eb4df7
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179b4d8b800000

Reported-by: syzbot+659574e7bcc7f7eb4df7@syzkaller.appspotmail.com
Fixes: 9dea5dc921b5 ("x86/entry/syscalls: Wire up 32-bit direct socket  
calls")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
