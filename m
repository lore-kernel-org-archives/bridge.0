Return-Path: <3wQu4XQkbAKweklWMXXQdMbbUP.SaaSXQgeQdOaZfQZf.OaY@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Tue, 29 Oct 2019 02:52:00 -0700
In-Reply-To: <000000000000044a7f0595fbaf2c@google.com>
Message-ID: <0000000000006db1370596099128@google.com>
From: syzbot <syzbot+8da67f407bcba2c72e6e@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Subject: Re: [Bridge] INFO: trying to register non-static key in
	bond_3ad_update_ad_actor_settings
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: a@unstable.cc, alex.aring@gmail.com, allison@lohutok.net, andrew@lunn.ch, andy@greyhouse.net, ap420073@gmail.com, aroulin@cumulusnetworks.com, ast@domdv.de, b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux-foundation.org, cleech@redhat.com, daniel@iogearbox.net, davem@davemloft.net, dcaratti@redhat.com, dsa@cumulusnetworks.com, edumazet@google.com, f.fainelli@gmail.com, fw@strlen.de, gbastien@versatic.net, gregkh@linuxfoundation.org, gustavo@embeddedor.com, haiyangz@microsoft.com, idosch@mellanox.com, info@metux.net, ivan.khoronzhuk@linaro.org, j.vosburgh@gmail.com, j@w1.fi, jakub.kicinski@netronome.com, jhs@mojatatu.com, jiri@mellanox.com, jiri@resnulli.us, johan.hedberg@gmail.com, johannes.berg@intel.com, john.hurley@netronome.com, jwi@linux.ibm.com, kstewart@linuxfoundation.org, kvalo@codeaurora.org, kys@microsoft.com, linmiaohe@huawei.com, linux-bluetooth@vger.kernel.org, linux-hams@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org, linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org, liuhangbin@gmail.com, marcel@holtmann.org, mareklindner@neomailbox.ch, mcroce@redhat.com

syzbot has bisected this bug to:

commit ab92d68fc22f9afab480153bd82a20f6e2533769
Author: Taehee Yoo <ap420073@gmail.com>
Date:   Mon Oct 21 18:47:51 2019 +0000

     net: core: add generic lockdep keys

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b54d70e00000
start commit:   60c1769a Add linux-next specific files for 20191028
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11b54d70e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16b54d70e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb86688f30db053d
dashboard link: https://syzkaller.appspot.com/bug?extid=8da67f407bcba2c72e6e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d43a04e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16be3b9ce00000

Reported-by: syzbot+8da67f407bcba2c72e6e@syzkaller.appspotmail.com
Fixes: ab92d68fc22f ("net: core: add generic lockdep keys")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
