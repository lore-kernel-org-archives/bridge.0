Return-Path: <3-GkSXgkbAA05BCxnyyr4n22vq.t11tyr75r4p106r06.p1z@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Sun, 05 Jan 2020 14:58:00 -0800
In-Reply-To: <000000000000ab3f800598cec624@google.com>
Message-ID: <000000000000802598059b6c7989@google.com>
From: syzbot <syzbot+4ec99438ed7450da6272@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Subject: Re: [Bridge] WARNING: bad unlock balance in sch_direct_xmit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: a@unstable.cc, alex.aring@gmail.com, allison@lohutok.net, andrew@lunn.ch, andy@greyhouse.net, ap420073@gmail.com, ast@domdv.de, b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux-foundation.org, cleech@redhat.com, daniel@iogearbox.net, davem@davemloft.net, dsa@cumulusnetworks.com, f.fainelli@gmail.com, fw@strlen.de, gregkh@linuxfoundation.org, gustavo@embeddedor.com, haiyangz@microsoft.com, info@metux.net, j.vosburgh@gmail.com, j@w1.fi, jakub.kicinski@netronome.com, jhs@mojatatu.com, jiri@resnulli.us, johan.hedberg@gmail.com, johannes.berg@intel.com, jwi@linux.ibm.com, kstewart@linuxfoundation.org, kvalo@codeaurora.org, kys@microsoft.com, linmiaohe@huawei.com, linux-bluetooth@vger.kernel.org, linux-hams@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org, linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org, liuhangbin@gmail.com, marcel@holtmann.org, mareklindner@neomailbox.ch, mkubecek@suse.cz, mmanning@vyatta.att-mail.com, netdev@vger.kernel.org, nikolay@cumulusnetworks.com, oss-drivers@netronome.com, paulus@samba.org, ralf@linux-mips.org, roopa@cumulusnetworks.com, sashal@kernel.org

syzbot has bisected this bug to:

commit ab92d68fc22f9afab480153bd82a20f6e2533769
Author: Taehee Yoo <ap420073@gmail.com>
Date:   Mon Oct 21 18:47:51 2019 +0000

     net: core: add generic lockdep keys

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e88ec6e00000
start commit:   36487907 Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17e88ec6e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13e88ec6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2f3ef188b7e16cf
dashboard link: https://syzkaller.appspot.com/bug?extid=4ec99438ed7450da6272
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1722c5c1e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167aee3ee00000

Reported-by: syzbot+4ec99438ed7450da6272@syzkaller.appspotmail.com
Fixes: ab92d68fc22f ("net: core: add generic lockdep keys")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
