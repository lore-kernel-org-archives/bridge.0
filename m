Return-Path: <dvyukov@google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=0wEV/ipC4bfJW9xp4vHq9B9GgjH4aRfvN7qnURusXlw=;
	b=d/aKUHijM4vj2nDYQ+dFb9FmAjLWqYwI6OG29UrSYBta4iBZj6KjcNTZ/5MFWDloKF
	jvlELMkk7EEAgV4JfTdRz1IHXpfjX0NffLmwakziIL3ZIvaR4IQfE4s2eGsdttTcSql7
	5MbirqQyG61d0m/gGfbnJxz+gjzknLM7c/w9/tNnnSDNIECtYnOwzH362cWHUhI7/GWS
	9S9ic3mPgCXbqwcsSFAdnbhlqk7e9FNrTP1XckRlKdKvSlA/n4VkvZyJNNQMlqqeRYFA
	ijILLjDQlNzgtNUfXWP3HZpUbeEpTVl0M7Lv2hE2kEjzAN3dQImJlqzl04iFAdWvV/Zs
	GVlA==
MIME-Version: 1.0
References: <000000000000862b160580765e94@google.com>
	<3c44c1ff-2790-ec06-35c6-3572b92170c7@cumulusnetworks.com>
	<CACT4Y+ZA8gBURbeZaDtrt5NoqFy8a8W3jyaWbs34Qjic4Bu+DA@mail.gmail.com>
	<20190220102327.lq2zyqups2fso75z@gondor.apana.org.au>
	<CACT4Y+bUTWcvqEebNjoagw0JtM77NXwVu+i3cYmhgnntZRWyfg@mail.gmail.com>
	<20190529145845.bcvuc5ows4dedqh3@gondor.apana.org.au>
	<CACT4Y+bWyNawZBQkV3TyyFF0tyHnJ9UPsCW-EzmC7rwwh3yk2g@mail.gmail.com>
	<20190529152650.mjzyd6evzmonymj6@gondor.apana.org.au>
In-Reply-To: <20190529152650.mjzyd6evzmonymj6@gondor.apana.org.au>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 31 May 2019 13:31:41 +0200
Message-ID: <CACT4Y+YEajNeYRvbVvddC0=mYKviPAyX_1C+mPn_DcWWFcwr8w@mail.gmail.com>
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

On Wed, May 29, 2019 at 5:27 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Wed, May 29, 2019 at 05:14:17PM +0200, Dmitry Vyukov wrote:
> >
> > > It looks like
> > >
> > > ommit 1515a63fc413f160d20574ab0894e7f1020c7be2
> > > Author: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> > > Date:   Wed Apr 3 23:27:24 2019 +0300
> > >
> > >     net: bridge: always clear mcast matching struct on reports and leaves
> > >
> > > may have at least fixed the uninitialised value error.
> >
> >
> > The most up-to-date info is always available here:
> >
> > >> dashboard link: https://syzkaller.appspot.com/bug?extid=bc5ab0af2dbf3b0ae897
> >
> > It says no new crashes happened besides the original one.
> >
> > We now have the following choices:
> >
> > 1. Invalidate with "#syz invalid"
> > 2. Mark as tentatively fixed by that commit (could it fix it?) with
> > "#syz fix: net: bridge: always clear mcast matching struct on reports
> > and leaves"
> > 3. Do nothing, then syzbot will auto-close it soon (bugs without
> > reproducers that did not happen in the past 180 days)
>
> I'm still not quite sure how this could cause the use-after-free,
> but it certainly seems to be the cause for the second issue of
> uninit-value:
>
> https://syzkaller.appspot.com/bug?extid=8dfe5ee27aa6d2e396c2
>
> And this one does seem to have occured again recently (two months
> ago).

I've closed the KMSAN bug report with this commit.

And since the uninit value was used inside of the rhashtable (as
hash?) it could lead to any kind of inconsistencies, I guess we can
do:

#syz fix:
net: bridge: always clear mcast matching struct on reports and leaves

here too.

Thanks for bringing this up!
