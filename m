Return-Path: <35CXyXQkbAO0hnoZPaaTgPeeXS.VddVaTjhTgRdciTci.Rdb@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Thu, 12 Dec 2019 03:35:00 -0800
In-Reply-To: <000000000000b6b03205997b71cf@google.com>
Message-ID: <000000000000b949ee0599802274@google.com>
From: syzbot <syzbot+31043da7725b6ec210f1@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Subject: Re: [Bridge] BUG: corrupted list in __dentry_kill (2)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: a@unstable.cc, alex.aring@gmail.com, allison@lohutok.net, andrew@lunn.ch, andy@greyhouse.net, ap420073@gmail.com, ast@domdv.de, ast@kernel.org, b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, bridge@lists.linux-foundation.org, cleech@redhat.com, daniel@iogearbox.net, davem@davemloft.net, dsa@cumulusnetworks.com, dsahern@gmail.com, dvyukov@google.com, f.fainelli@gmail.com, fw@strlen.de, gregkh@linuxfoundation.org, haiyangz@microsoft.com, hawk@kernel.org, hdanton@sina.com, idosch@mellanox.com, info@metux.net, j.vosburgh@gmail.com, j@w1.fi, jakub.kicinski@netronome.com, jhs@mojatatu.com, jiri@mellanox.com, jiri@resnulli.us, johan.hedberg@gmail.com, johannes.berg@intel.com, john.fastabend@gmail.com, john.hurley@netronome.com, jwi@linux.ibm.com, kafai@fb.com, kstewart@linuxfoundation.org, kvalo@codeaurora.org, kys@microsoft.com, linux-bluetooth@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-hams@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org, linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org, liuhangbin@gmail.com, marcel@holtmann.org

syzbot has bisected this bug to:

commit ab92d68fc22f9afab480153bd82a20f6e2533769
Author: Taehee Yoo <ap420073@gmail.com>
Date:   Mon Oct 21 18:47:51 2019 +0000

     net: core: add generic lockdep keys

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d37cb6e00000
start commit:   938f49c8 Add linux-next specific files for 20191211
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11d37cb6e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16d37cb6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96834c884ba7bb81
dashboard link: https://syzkaller.appspot.com/bug?extid=31043da7725b6ec210f1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dc83dae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ac8396e00000

Reported-by: syzbot+31043da7725b6ec210f1@syzkaller.appspotmail.com
Fixes: ab92d68fc22f ("net: core: add generic lockdep keys")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
