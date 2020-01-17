Return-Path: <3ogMiXgkbACkXdePFQQJWFUUNI.LTTLQJZXJWHTSYJSY.HTR@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Fri, 17 Jan 2020 10:57:38 -0800
In-Reply-To: <00000000000074ed27059c33dedc@google.com>
Message-ID: <000000000000fb2c4f059c5a8309@google.com>
From: syzbot <syzbot+156a04714799b1d480bc@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Subject: Re: [Bridge] general protection fault in nft_chain_parse_hook
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de, kadlec@blackhole.kfki.hu, kadlec@netfilter.org, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, stephen@networkplumber.org, syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org

syzbot has bisected this bug to:

commit 98319cb9089844d76e65a6cce5bfbd165e698735
Author: Pablo Neira Ayuso <pablo@netfilter.org>
Date:   Tue Jan 9 01:48:47 2018 +0000

     netfilter: nf_tables: get rid of struct nft_af_info abstraction

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d38159e00000
start commit:   f5ae2ea6 Fix built-in early-load Intel microcode alignment
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10338159e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17d38159e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9290aeb7e6cf1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=156a04714799b1d480bc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a7e669e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11102356e00000

Reported-by: syzbot+156a04714799b1d480bc@syzkaller.appspotmail.com
Fixes: 98319cb90898 ("netfilter: nf_tables: get rid of struct nft_af_info  
abstraction")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
