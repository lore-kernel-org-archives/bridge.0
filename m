Return-Path: <3FLyWXAkbANEFLM7x881ExCC50.3BB381HF1EzBAG1AG.zB9@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Sat, 23 Mar 2019 16:07:00 -0700
In-Reply-To: <00000000000081994205827ea9a0@google.com>
Message-ID: <000000000000674a950584cb07a0@google.com>
From: syzbot <syzbot+276ddebab3382bbf72db@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Subject: Re: [Bridge] WARNING in xt_compat_add_offset
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de, kadlec@blackhole.kfki.hu, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, nikolay@cumulusnetworks.com, pablo@netfilter.org, roopa@cumulusnetworks.com, syzkaller-bugs@googlegroups.com

syzbot has bisected this bug to:

commit 2035f3ff8eaa29cfb5c8e2160b0f6e85eeb21a95
Author: Florian Westphal <fw@strlen.de>
Date:   Mon Jan 21 20:54:36 2019 +0000

     netfilter: ebtables: compat: un-break 32bit setsockopt when no rules  
are present

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1462834d200000
start commit:   8a61716f Merge tag 'ceph-for-5.0-rc8' of git://github.com/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1662834d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1262834d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7132344728e7ec3f
dashboard link: https://syzkaller.appspot.com/bug?extid=276ddebab3382bbf72db
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140c0914c00000

Reported-by: syzbot+276ddebab3382bbf72db@syzkaller.appspotmail.com
Fixes: 2035f3ff8eaa ("netfilter: ebtables: compat: un-break 32bit  
setsockopt when no rules are present")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
