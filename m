Return-Path: <3_Ue4XQkbAGISYZKALLERAPPID.GOOGLEUSERCONTENT.COM@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Tue, 29 Oct 2019 07:09:01 -0700
In-Reply-To: <0000000000009ea5720595dc03a3@google.com>
Message-ID: <0000000000007792ff05960d289d@google.com>
From: syzbot <syzbot+692f39f040c1f415567b@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Subject: Re: [Bridge] BUG: MAX_LOCKDEP_KEYS too low!
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: a@unstable.cc, alex.aring@gmail.com, allison@lohutok.net, andrew@lunn.ch, andy@greyhouse.net, ap420073@gmail.com, aroulin@cumulusnetworks.com, ast@domdv.de, b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux-foundation.org, cleech@redhat.com, daniel@iogearbox.net, davem@davemloft.net, dcaratti@redhat.com, dsa@cumulusnetworks.com, edumazet@google.com, f.fainelli@gmail.com, fw@strlen.de, gregkh@linuxfoundation.org, gustavo@embeddedor.com, gvaradar@cisco.com, haiyangz@microsoft.com, idosch@mellanox.com, info@metux.net, ivan.khoronzhuk@linaro.org, j.vosburgh@gmail.com, j@w1.fi, jakub.kicinski@netronome.com, jhs@mojatatu.com, jiri@mellanox.com, jiri@resnulli.us, johan.hedberg@gmail.com, johannes.berg@intel.com, john.hurley@netronome.com, jwi@linux.ibm.com, kstewart@linuxfoundation.org, kvalo@codeaurora.org, kys@microsoft.com, lariel@mellanox.com, linmiaohe@huawei.com, linux-bluetooth@vger.kernel.org, linux-hams@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org, linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org, liuhangbin@gmail.com, marcel@holtmann.org, mareklindner@neomailbox.ch

syzbot has bisected this bug to:

commit ab92d68fc22f9afab480153bd82a20f6e2533769
Author: Taehee Yoo <ap420073@gmail.com>
Date:   Mon Oct 21 18:47:51 2019 +0000

     net: core: add generic lockdep keys

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12e05224e00000
start commit:   60c1769a Add linux-next specific files for 20191028
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11e05224e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16e05224e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb86688f30db053d
dashboard link: https://syzkaller.appspot.com/bug?extid=692f39f040c1f415567b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10be9ed0e00000

Reported-by: syzbot+692f39f040c1f415567b@syzkaller.appspotmail.com
Fixes: ab92d68fc22f ("net: core: add generic lockdep keys")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
