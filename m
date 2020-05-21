Return-Path: <dvyukov@google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aJY0Ep267ouSAsUGL+ry/Av1nT7Mp2t1Mda3g0C6rV8=;
 b=FpDavvqmhyH4TVpicJ5DzY7zQZsoMuzIrMNXmgE8gmzuiJO21+n4dcBsTqUKWLgS9U
 JPuhtdzwLRQp/Ev48KcLWMiFgNr5j/IpYv5qH7HqqAeyVcwimI7EL0L0p/fpzD9HObuG
 nDbu6X2nt0Ud3Ue2hrhuy0coZEfZbsV8D++7u5huuMy7NrNfv1d4ioZWnSEvvS14SRh7
 emHV+Wk8FllyGlC/poviNGagE9to53QAWhXuNKSbfqUmlJOE15J1+AlXo6se+ti5sOTG
 8OFACe2YHqXk19jTeypQrb5GmoowUVZFULiC0iCI1SFerw8AF9YtNeeYb/q7cq2KmUr1
 xkpw==
MIME-Version: 1.0
References: <0000000000007b211005a6187dc9@google.com>
 <20200521140803.GI30374@kadam>
In-Reply-To: <20200521140803.GI30374@kadam>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 21 May 2020 16:28:05 +0200
Message-ID: <CACT4Y+bzz-h5vNGH0rDMUiuGZVX01oXawXAPbjtnNHb1KVWSvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] KASAN: slab-out-of-bounds Read in br_mrp_parse
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, horatiu.vultur@microchip.com, syzbot <syzbot+9c6f0f1f8e32223df9a4@syzkaller.appspotmail.com>, syzkaller <syzkaller@googlegroups.com>, kuba@kernel.org, David Miller <davem@davemloft.net>

On Thu, May 21, 2020 at 4:08 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, May 20, 2020 at 11:23:18AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    dda18a5c selftests/bpf: Convert bpf_iter_test_kern{3, 4}.c..
> > git tree:       bpf-next
>                   ^^^^^^^^
>
> I can figure out what this is from reading Next/Trees but it would be
> more useful if it were easier to script.

Hi Dan,

Is there a canonical way to refer to a particular branch of a particular tree?
From what I observed on mailing lists people seem to say "linux-next"
or "upstream tree" and that seems to mean specific things that
everybody understands.

What do you want to script? Note syzbot is not promising a specific
stable API wrt these plain text emails. These are flattened into text
format for human consumption and sent over unreliable media.

> > console output: https://syzkaller.appspot.com/x/log.txt?x=10c4e63c100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=668983fd3dd1087e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9c6f0f1f8e32223df9a4
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17eaba3c100000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128598f6100000
> >
>
> regards,
> dan carpenter
>
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20200521140803.GI30374%40kadam.
