Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-language:content-transfer-encoding;
	bh=5K+SuxpGvXfQ///N9XK1+tF5GqeC/HVgCK0aC6WVZtU=;
	b=OfC8vdkx64xyhbGpo8KCxYo+Lm9vikgIF+jEkc9Nv6Yxn4gP0DjP/kIQg51vfl7xGC
	jV8WoJ2HAmWTP3kg4XrVF4jk+AGlMOm8gSNklsPETgCIJkZwo7ReZmIX238PnP9Qyin9
	yd0vAmYMJBw9QIB5VddDz14pj4cZtz7R9nCvg=
References: <0000000000008be1b2058ebe7805@google.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <d16a3297-d651-0a32-e803-774a9c8c61bf@cumulusnetworks.com>
Date: Sun, 28 Jul 2019 19:51:03 +0300
MIME-Version: 1.0
In-Reply-To: <0000000000008be1b2058ebe7805@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] memory leak in fdb_create
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: syzbot <syzbot+88533dc8b582309bf3ee@syzkaller.appspotmail.com>, bridge@lists.linux-foundation.org, bsingharora@gmail.com, coreteam@netfilter.org, davem@davemloft.net, duwe@suse.de, kaber@trash.net, kadlec@blackhole.kfki.hu, linux-kernel@vger.kernel.org, mingo@redhat.com, mpe@ellerman.id.au, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, roopa@cumulusnetworks.com, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com

On 28/07/2019 17:20, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 04cf31a759ef575f750a63777cee95500e410994
> Author: Michael Ellerman <mpe@ellerman.id.au>
> Date:   Thu Mar 24 11:04:01 2016 +0000
> 
>     ftrace: Make ftrace_location_range() global
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1538c778600000
> start commit:   abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1738c778600000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1338c778600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=56f1da14935c3cce
> dashboard link: https://syzkaller.appspot.com/bug?extid=88533dc8b582309bf3ee
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16de5c06a00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10546026a00000
> 
> Reported-by: syzbot+88533dc8b582309bf3ee@syzkaller.appspotmail.com
> Fixes: 04cf31a759ef ("ftrace: Make ftrace_location_range() global")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

I see the problem, it'd happen if the multicast stats memory allocation fails on bridge
init then the fdb added due to the default vlan would remain and the bridge kmem cache
would be destroyed while not empty (you can even trigger a BUG because of that).
I'll post a patch shortly after running a few tests.

Thanks,
 Nik

