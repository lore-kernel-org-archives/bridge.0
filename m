Return-Path: <dan.carpenter@oracle.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=VtH50d3j8PGL5fadgDPMpo+HStraNOmQY5K9l3SYH/Q=;
 b=cQK/u6IjxwwVLLC8pb1aAgmXTz3H7PM+14OySJ+Q+U9tTUVXD93HaHbcmmu7QTATP1kF
 AI15s21aN/QSHDEfTHep6UG5rA6yVmNE925zWrvYC9Rou652Czt7fz/unTGETkPCzuOi
 2utO3KjH+DGPhIBR4mqkwV98RmIyIiYFZyapOSM0OCGCgYzDbalsEfXNQzJd4PDphPYc
 RbH/mFKhqog5utSj40D3ddZ81RSrYB6V8pFLZ9ucxDlKgDT+jjvAhY/zrr6hdwomVuMD
 iLkDxlOUG1u9T+q2gyMhZP1kquuO2Mvke3AE6NR8dp9GSUwd/+SSP6zsmRlAseB5yRj3 Qg== 
Date: Thu, 21 May 2020 17:08:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20200521140803.GI30374@kadam>
References: <0000000000007b211005a6187dc9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007b211005a6187dc9@google.com>
Subject: Re: [Bridge] KASAN: slab-out-of-bounds Read in br_mrp_parse
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: syzbot <syzbot+9c6f0f1f8e32223df9a4@syzkaller.appspotmail.com>
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, horatiu.vultur@microchip.com, kuba@kernel.org, davem@davemloft.net

On Wed, May 20, 2020 at 11:23:18AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    dda18a5c selftests/bpf: Convert bpf_iter_test_kern{3, 4}.c..
> git tree:       bpf-next
                  ^^^^^^^^

I can figure out what this is from reading Next/Trees but it would be
more useful if it were easier to script.

> console output: https://syzkaller.appspot.com/x/log.txt?x=10c4e63c100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=668983fd3dd1087e
> dashboard link: https://syzkaller.appspot.com/bug?extid=9c6f0f1f8e32223df9a4
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17eaba3c100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128598f6100000
> 

regards,
dan carpenter


