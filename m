Return-Path: <dvyukov@google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=aPd0T4nMPp5+McITAHFhs073CifRxWMUwmwxYGayYkI=;
	b=rjaL1ZpHoM13fKR3np1C2zYZHY/Y2oQB7qrCJbgzJLx1otaUNOCPdZt2rERT+ioe2h
	6KsBPv958jPzU3UQjxbbUNxg+JhtqvT8QFUb8nC9Tz9riw882pzmcTJ95pcRh6y6rgbG
	o/ZtmdtmBJZDGYXEvKbw/+sFLyLcDd+crNUGqH1QIBGQj2sEUqaIR5P3xCcEjUN88426
	jhjg2BM1Lyp/WHJk9iKtt58dMz/+R4bdN91Q1AdwkP7ZJ8yRLbiR5Ml0b/XBI3c2/izS
	iOCznTpQno/RSXF+N/b9FH+igvcKNk86yKp1TQ4uTpz8VbIS/xJuis+Vib2kV5vwTftk
	V0QA==
MIME-Version: 1.0
References: <000000000000862b160580765e94@google.com>
	<3c44c1ff-2790-ec06-35c6-3572b92170c7@cumulusnetworks.com>
	<CACT4Y+ZA8gBURbeZaDtrt5NoqFy8a8W3jyaWbs34Qjic4Bu+DA@mail.gmail.com>
	<20190220102327.lq2zyqups2fso75z@gondor.apana.org.au>
	<CACT4Y+bUTWcvqEebNjoagw0JtM77NXwVu+i3cYmhgnntZRWyfg@mail.gmail.com>
	<20190529145845.bcvuc5ows4dedqh3@gondor.apana.org.au>
In-Reply-To: <20190529145845.bcvuc5ows4dedqh3@gondor.apana.org.au>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 29 May 2019 17:14:17 +0200
Message-ID: <CACT4Y+bWyNawZBQkV3TyyFF0tyHnJ9UPsCW-EzmC7rwwh3yk2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] KASAN: use-after-free Read in br_mdb_ip_get
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, syzbot <syzbot+bc5ab0af2dbf3b0ae897@syzkaller.appspotmail.com>, Thomas Graf <tgraf@suug.ch>, David Miller <davem@davemloft.net>

On Wed, May 29, 2019 at 4:58 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Hi Dmitry:
>
> On Thu, Feb 21, 2019 at 11:54:42AM +0100, Dmitry Vyukov wrote:
> >
> > Taking into account that this still happened only once, I tend to
> > write it off onto a previous silent memory corruption (we have dozens
> > of known bugs that corrupt memory). So if several people already
> > looked at it and don't see the root cause, it's probably time to stop
> > spending time on this until we have more info.
> >
> > Although, there was also this one:
> > https://groups.google.com/d/msg/syzkaller-bugs/QfCCSxdB1aM/y2cn9IZJCwAJ
> > I have not checked if it can be the root cause of this report, but it
> > points suspiciously close to this stack and when I looked at it, it
> > the report looked legit.
>
> Have you had any more reports of this kind coming from br_multicast?
>
> It looks like
>
> ommit 1515a63fc413f160d20574ab0894e7f1020c7be2
> Author: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Date:   Wed Apr 3 23:27:24 2019 +0300
>
>     net: bridge: always clear mcast matching struct on reports and leaves
>
> may have at least fixed the uninitialised value error.


The most up-to-date info is always available here:

>> dashboard link: https://syzkaller.appspot.com/bug?extid=bc5ab0af2dbf3b0ae897

It says no new crashes happened besides the original one.

We now have the following choices:

1. Invalidate with "#syz invalid"
2. Mark as tentatively fixed by that commit (could it fix it?) with
"#syz fix: net: bridge: always clear mcast matching struct on reports
and leaves"
3. Do nothing, then syzbot will auto-close it soon (bugs without
reproducers that did not happen in the past 180 days)
