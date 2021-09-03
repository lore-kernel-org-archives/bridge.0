Return-Path: <3DwoyYQkbAPou01mcnngtcrrkf.iqqingwugteqpvgpv.eqo@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Fri, 03 Sep 2021 04:42:07 -0700
In-Reply-To: <10b89a9f-443c-98d1-ca01-add5f6dd3355@nvidia.com>
Message-ID: <000000000000fdb19d05cb15c938@google.com>
From: syzbot <syzbot+24b98616278c31afc800@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [syzbot] KASAN: slab-out-of-bounds Read in add_del_if
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+24b98616278c31afc800@syzkaller.appspotmail.com

Tested on:

commit:         d15040a3 Merge branch 'bridge-ioctl-fixes'
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=aba0c23f8230e048
dashboard link: https://syzkaller.appspot.com/bug?extid=24b98616278c31afc800
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
